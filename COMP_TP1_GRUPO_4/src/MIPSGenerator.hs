module MIPSGenerator where

import TAC
import Data.Map (Map)
import qualified Data.Map as Map
import Data.List (intercalate)

-- Função principal: converte programa TAC para MIPS
generateMIPS :: TACProgram -> String
generateMIPS instrs = unlines $
    [ "# ===== SEÇÃO DE DADOS ====="
    , ".data"
    , "  input:    .space 100       # Buffer para entrada"
    , "  newline:  .asciiz \"\\n\"    # String para nova linha"
    , "  true_str: .asciiz \"true\"  # String para true"
    , "  false_str:.asciiz \"false\" # String para false"
    , ""
    , "# ===== SEÇÃO DE CÓDIGO ====="
    , ".text"
    , ".globl main"
    , "main:"
    ] ++ map instrToMIPS instrs ++
    [ ""
    , "# ===== FINALIZAÇÃO DO PROGRAMA ====="
    , "  li $v0, 10                 # Syscall para exit"
    , "  syscall"
    ]

-- Converte uma instrução TAC para MIPS
instrToMIPS :: TAC -> String
instrToMIPS (Assign dest expr) = 
    let (srcReg, srcCode) = exprToMIPS expr
        destReg = regForVar dest
    in srcCode ++ "  move " ++ destReg ++ ", " ++ srcReg ++ "       # " ++ dest ++ " = " ++ tacShowExpr expr

instrToMIPS (Label lbl) = 
    lbl ++ ":                          # RÓTULO"

instrToMIPS (Goto lbl) = 
    "  j " ++ lbl ++ "                   # GOTO"

instrToMIPS (IfZ cond lbl) = 
    let (condReg, condCode) = exprToMIPS cond
    in condCode ++ "  beqz " ++ condReg ++ ", " ++ lbl ++ "     # IFZ " ++ tacShowExpr cond

instrToMIPS (IfNZ cond lbl) = 
    let (condReg, condCode) = exprToMIPS cond
    in condCode ++ "  bnez " ++ condReg ++ ", " ++ lbl ++ "     # IFNZ " ++ tacShowExpr cond

instrToMIPS (Param expr) = 
    let (reg, code) = exprToMIPS expr
    in code ++ "  move $a0, " ++ reg ++ "              # PARAM " ++ tacShowExpr expr

-- Chamada de Put_Line 
instrToMIPS (Call "Put_Line" 1) = 
    unlines [ "  li $v0, 4                   # Put_Line string"
            , "  syscall"
            , "  la $a0, newline            # Nova linha"
            , "  li $v0, 4"
            , "  syscall" ]

-- Chamada de Get_Line 
instrToMIPS (Call "Get_Line" 0) = 
    unlines [ "  li $v0, 8                   # Get_Line input"
            , "  la $a0, input"
            , "  li $a1, 100"
            , "  syscall" ]

-- Chamada genérica de função
instrToMIPS (Call func n) = 
    "  jal " ++ func ++ "                  # CALL " ++ func ++ " (" ++ show n ++ " params)"

instrToMIPS (Return expr) = 
    let (reg, code) = exprToMIPS expr
    in code ++ "  move $v0, " ++ reg ++ "              # RETURN " ++ tacShowExpr expr ++ "\n" ++ 
       "  jr $ra"

-- Converte expressão TAC para registo MIPS + código
exprToMIPS :: TACExpr -> (String, String)
exprToMIPS (TACVar v) = (regForVar v, "")
exprToMIPS (TACInt i) = ("$t0", "  li $t0, " ++ show i ++ "           # Inteiro " ++ show i ++ "\n")
exprToMIPS (TACStr s) = 
    let label = "str_" ++ show (hash s)
    in ("$a0", "  la $a0, " ++ label ++ "         # String: " ++ s ++ "\n")
exprToMIPS (TACBool True) = ("$t0", "  li $t0, 1                 # Boolean true\n")
exprToMIPS (TACBool False) = ("$t0", "  li $t0, 0                 # Boolean false\n")
exprToMIPS (TACTemp t) = ("$t" ++ show (t `mod` 8), "")

-- Mapeia variáveis para registos MIPS
regForVar :: String -> String
regForVar "retval" = "$v0"          
regForVar "input" = "$a0"           
regForVar var
    | var `elem` ["t0","t1","t2","t3","t4","t5","t6","t7"] = "$" ++ var
    | take 1 var == "t" && all (`elem` "0123456789") (drop 1 var) = "$t" ++ show (read (drop 1 var) `mod` 8)
    | otherwise = "$s" ++ show (hash var `mod` 4 + 1)  

-- Função hash simples para distribuir variáveis em registos
hash :: String -> Int
hash = foldl (\acc c -> acc * 31 + fromEnum c) 0

-- Função auxiliar para imprimir programa MIPS completo
printMIPS :: TACProgram -> String
printMIPS = generateMIPS

-- Converte expressão TAC para string 
tacShowExpr :: TACExpr -> String
tacShowExpr (TACVar v) = v
tacShowExpr (TACInt i) = show i
tacShowExpr (TACStr s) = "\"" ++ s ++ "\""
tacShowExpr (TACBool b) = show b
tacShowExpr (TACTemp t) = "t" ++ show t