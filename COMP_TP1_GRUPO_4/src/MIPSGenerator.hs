module MIPSGenerator (generateMIPS) where

import TAC
import qualified Data.Map as Map
import Data.List (nub)

-- =======================================
-- COLETA DE STRINGS DO TAC
-- =======================================

collectStrings :: TACProgram -> [String]
collectStrings = foldr collect []
  where
    collect (Assign _ e) acc = collectExpr e acc
    collect (IfZ e _) acc    = collectExpr e acc
    collect (IfNZ e _) acc   = collectExpr e acc
    collect (Param e) acc    = collectExpr e acc
    collect (Return e) acc   = collectExpr e acc
    collect _ acc = acc

collectExpr :: TACExpr -> [String] -> [String]
collectExpr (TACStr s) acc = s : acc
collectExpr _ acc = acc

-- =======================================
-- GERADOR PRINCIPAL
-- =======================================

generateMIPS :: TACProgram -> String
generateMIPS instrs =
    let strings = nub (collectStrings instrs)
        numbered = zip strings [0..]
        strMap = Map.fromList [ (s, "str_" ++ show n) | (s,n) <- numbered ]
    in unlines $
        [ "# ===== SEÇÃO DE DADOS ====="
        , ".data"
        , "  input:    .space 100"
        , "  newline:  .asciiz \"\\n\""
        , "  true_str: .asciiz \"true\""
        , "  false_str:.asciiz \"false\""
        ]
        ++ map declareString (Map.toList strMap)
        ++ [ ""
           , "# ===== SEÇÃO DE CÓDIGO ====="
           , ".text"
           , ".globl main"
           , "main:"
           ]
        ++ concatMap (instrToMIPS strMap) instrs
        ++ [ ""
           , "# ===== FINALIZAÇÃO ====="
           , "  li $v0, 10"
           , "  syscall"
           ]

declareString :: (String, String) -> String
declareString (value, label) =
    "  " ++ label ++ ": .asciiz " ++ show value

-- =======================================
-- GERAÇÃO DE CÓDIGO PARA TAC
-- =======================================

instrToMIPS :: Map.Map String String -> TAC -> [String]
instrToMIPS _ (Label lbl) = [lbl ++ ":"]

instrToMIPS _ (Goto lbl) = ["  j " ++ lbl]

instrToMIPS mp (IfZ expr lbl) =
    let (reg, code) = exprToMIPS mp expr
    in lines code ++ ["  beqz " ++ reg ++ ", " ++ lbl]

instrToMIPS mp (IfNZ expr lbl) =
    let (reg, code) = exprToMIPS mp expr
    in lines code ++ ["  bnez " ++ reg ++ ", " ++ lbl]

instrToMIPS mp (Assign var expr) =
    let (reg, code) = exprToMIPS mp expr
    in lines code ++ ["  move " ++ regForVar var ++ ", " ++ reg]

instrToMIPS mp (Param expr) =
    let (reg, code) = exprToMIPS mp expr
    in lines code ++
       [ "  move $a0, " ++ reg
       , "  li $v0, 4"
       , "  syscall"
       ]

instrToMIPS mp (Return expr) =
    let (reg, code) = exprToMIPS mp expr
    in lines code ++ ["  move $v0, " ++ reg]

instrToMIPS _ (Call "Put_Line" _) =
    [ "  li $v0, 4"
    , "  syscall"
    , "  la $a0, newline"
    , "  li $v0, 4"
    , "  syscall"
    ]

instrToMIPS _ (Call "Get_Line" _) =
    [ "  li $v0, 8"
    , "  la $a0, input"
    , "  li $a1, 100"
    , "  syscall"
    ]

instrToMIPS _ _ = []

-- =======================================
-- EXPRESSÕES
-- =======================================

exprToMIPS :: Map.Map String String -> TACExpr -> (String, String)

exprToMIPS _ (TACVar v) = (regForVar v, "")

exprToMIPS _ (TACTemp n) =
    ("$t" ++ show (n `mod` 8), "")

exprToMIPS _ (TACInt n) =
    ("$t0", "  li $t0, " ++ show n ++ "\n")

exprToMIPS mp (TACStr s) =
    let label = mp Map.! s
    in ("$a0", "  la $a0, " ++ label ++ "\n")

exprToMIPS _ (TACBool True) =
    ("$t0", "  li $t0, 1\n")

exprToMIPS _ (TACBool False) =
    ("$t0", "  li $t0, 0\n")

-- =======================================
-- REGISTRADORES PARA VARIÁVEIS
-- =======================================

regForVar :: String -> String
regForVar v =
    case v of
        ('t':_) -> "$" ++ v
        _       -> "$s" ++ show (abs (sum (map fromEnum v)) `mod` 4)


