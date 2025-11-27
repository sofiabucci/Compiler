{-
Módulo: Main.hs
Descrição: Testa o compilador completo
-}

module Main where

import AST
import Compiler
import MIPSGenerator
import System.IO (writeFile)

main :: IO ()
main = do
    putStrLn "=== TESTE DO COMPILADOR ==="
    
    -- Teste 1: Expressão aritmética x - 2*5
    putStrLn "\n1. Compilação da expressão: x - 2*5"
    let expr = Minus (Var "x") (Mult (Number 2) (Number 5))
    let tac1 = compileExprMain expr
    putStrLn "Código de três endereços:"
    mapM_ (putStrLn . instrToString) tac1
    
    putStrLn "\nCódigo MIPS:"
    let mips1 = printMIPS tac1
    putStrLn mips1
    writeFile "expr_test.asm" mips1
    
    -- Teste 2: Comando if-then-else
    putStrLn "\n2. Compilação do comando: if x > 5 then y := 10 else y := 20"
    let cmd = If (Greater (Var "x") (Number 5)) 
                 (Assign "y" (Number 10)) 
                 (Assign "y" (Number 20))
    let tac2 = compileCmdMain cmd
    putStrLn "Código de três endereços:"
    mapM_ (putStrLn . instrToString) tac2
    
    putStrLn "\nCódigo MIPS:"
    let mips2 = printMIPS tac2
    putStrLn mips2
    writeFile "cmd_test.asm" mips2
    
    -- Teste 3: Comando while
    putStrLn "\n3. Compilação do comando: while x < 10 do x := x + 1"
    let cmd3 = While (Less (Var "x") (Number 10)) 
                     (Assign "x" (Plus (Var "x") (Number 1)))
    let tac3 = compileCmdMain cmd3
    putStrLn "Código de três endereços:"
    mapM_ (putStrLn . instrToString) tac3
    
    putStrLn "\nCódigo MIPS:"
    let mips3 = printMIPS tac3
    putStrLn mips3
    writeFile "while_test.asm" mips3
    
    putStrLn "\n✅ Arquivos .asm gerados para teste no MARS!"