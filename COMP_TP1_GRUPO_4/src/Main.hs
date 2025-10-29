module Main where

import AST
import Lexer
import Parser
import System.Environment (getArgs)

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
            
        _ -> putStrLn "Usage: stack run examples/test1.ada"