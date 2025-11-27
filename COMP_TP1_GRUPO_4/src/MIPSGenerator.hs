module MIPSGenerator where

import TAC
import Data.Map (Map)
import qualified Data.Map as Map

generateMIPS :: TACProgram -> String
generateMIPS instrs = unlines $
    [ ".data"
    , "input: .space 100"
    , "newline: .asciiz \"\\n\""
    , ".text"
    , "main:"
    ] ++ map instrToMIPS instrs ++
    [ "li $v0, 10"
    , "syscall"
    ]

instrToMIPS :: TAC -> String
instrToMIPS (Assign dest expr) = 
    let (src, code) = exprToMIPS expr
    in code ++ "move " ++ regForVar dest ++ ", " ++ src
instrToMIPS (Label lbl) = lbl ++ ":"
instrToMIPS (Goto lbl) = "j " ++ lbl
instrToMIPS (IfZ cond lbl) = 
    let (creg, code) = exprToMIPS cond
    in code ++ "beqz " ++ creg ++ ", " ++ lbl
instrToMIPS (IfNZ cond lbl) = 
    let (creg, code) = exprToMIPS cond
    in code ++ "bnez " ++ creg ++ ", " ++ lbl
instrToMIPS (Param expr) = 
    let (reg, code) = exprToMIPS expr
    in code ++ "move $a0, " ++ reg
instrToMIPS (Call "Put_Line" 1) = 
    "li $v0, 4\nsyscall"
instrToMIPS (Call "Get_Line" 0) = 
    "li $v0, 8\nla $a0, input\nli $a1, 100\nsyscall"
instrToMIPS _ = ""

exprToMIPS :: TACExpr -> (String, String)
exprToMIPS (TACVar v) = (regForVar v, "")
exprToMIPS (TACInt i) = ("$t0", "li $t0, " ++ show i ++ "\n")
exprToMIPS (TACStr s) = ("$a0", "la $a0, str_" ++ show (hash s) ++ "\n")
exprToMIPS (TACBool True) = ("$t0", "li $t0, 1\n")
exprToMIPS (TACBool False) = ("$t0", "li $t0, 0\n")
exprToMIPS (TACTemp t) = ("$t" ++ show t, "")

regForVar :: String -> String
regForVar "retval" = "$v0"
regForVar "input" = "$a0"
regForVar var = "$s" ++ show (hash var `mod` 8)

hash :: String -> Int
hash = foldl (\acc c -> acc * 31 + fromEnum c) 0