module Main where

import AST
import Lexer
import Parser
import SymbolTable
import TACGenerator
import MIPSGenerator
import System.Environment (getArgs)
import System.IO (writeFile)

main :: IO ()
main = do
    args <- getArgs
    case args of
        [filename] -> do
            content <- readFile filename
            let tokens = alexScanTokens content
            putStrLn "=== TOKENS ==="
            mapM_ print tokens
            
            putStrLn "\n=== AST ==="
            let ast = parse tokens
            print ast
            
            putStrLn "\n=== THREE-ADDRESS CODE ==="
            let tac = generateTAC ast
            mapM_ (putStrLn . tacToString) tac
            
            putStrLn "\n=== MIPS CODE ==="
            let mips = generateMIPS tac
            putStrLn mips
            writeFile "output.asm" mips
            
        _ -> putStrLn "Usage: stack run examples/test1.ada"