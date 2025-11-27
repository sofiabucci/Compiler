{-
Módulo: MIPSGenerator.hs
Descrição: Converte código de três endereços para assembly MIPS
-}

module MIPSGenerator where

import TAC
import Data.Map (Map)
import qualified Data.Map as Map

-- Função principal: converte programa TAC para MIPS
generateMIPS :: TACProgram -> String
generateMIPS instrs = unlines $
    [ ".data"                       -- Seção de dados
    , "input: .space 100"           -- Buffer para entrada
    , "newline: .asciiz \"\\n\""    -- String para nova linha
    , ".text"                       -- Seção de código
    , "main:"                       -- Ponto de entrada
    ] ++ map instrToMIPS instrs ++  -- Converte cada instrução
    [ "li $v0, 10"                  -- Exit syscall
    , "syscall"
    ]

-- Converte uma instrução TAC para MIPS
instrToMIPS :: TAC -> String
instrToMIPS (Assign dest expr) = 
    let (src, code) = exprToMIPS expr  -- Converte expressão fonte
    in code ++ "move " ++ regForVar dest ++ ", " ++ src  -- move dest, src

instrToMIPS (Label lbl) = lbl ++ ":"   -- Rótulo MIPS

instrToMIPS (Goto lbl) = "j " ++ lbl   -- Jump incondicional

instrToMIPS (IfZ cond lbl) = 
    let (creg, code) = exprToMIPS cond  -- Converte condição
    in code ++ "beqz " ++ creg ++ ", " ++ lbl  -- Branch if equal zero

instrToMIPS (IfNZ cond lbl) = 
    let (creg, code) = exprToMIPS cond
    in code ++ "bnez " ++ creg ++ ", " ++ lbl  -- Branch if not zero

instrToMIPS (Param expr) = 
    let (reg, code) = exprToMIPS expr
    in code ++ "move $a0, " ++ reg      -- Move para registo de argumento

-- Chamada de Put_Line (syscall 4 - print string)
instrToMIPS (Call "Put_Line" 1) = 
    "li $v0, 4\nsyscall"               -- System call para print string

-- Chamada de Get_Line (syscall 8 - read string)  
instrToMIPS (Call "Get_Line" 0) = 
    "li $v0, 8\nla $a0, input\nli $a1, 100\nsyscall"

instrToMIPS _ = ""  -- Instrução não suportada

-- Converte expressão TAC para registo MIPS + código
exprToMIPS :: TACExpr -> (String, String)
exprToMIPS (TACVar v) = (regForVar v, "")  -- Variável → registo

exprToMIPS (TACInt i) = ("$t0", "li $t0, " ++ show i ++ "\n")  -- Inteiro → load immediate

exprToMIPS (TACStr s) = ("$a0", "la $a0, str_" ++ show (hash s) ++ "\n")  -- String → load address

exprToMIPS (TACBool True) = ("$t0", "li $t0, 1\n")    -- True → 1
exprToMIPS (TACBool False) = ("$t0", "li $t0, 0\n")   -- False → 0

exprToMIPS (TACTemp t) = ("$t" ++ show t, "")  -- Temporário → registo temporário

-- Mapeia variáveis para registos MIPS
regForVar :: String -> String
regForVar "retval" = "$v0"    -- Valor de retorno
regForVar "input" = "$a0"     -- Input buffer
regForVar var = "$s" ++ show (hash var `mod` 8)  -- Variáveis → $s0-$s7

-- Função hash simples para distribuir variáveis em registos
hash :: String -> Int
hash = foldl (\acc c -> acc * 31 + fromEnum c) 0