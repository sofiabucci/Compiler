module Main where

import AST
import TAC
import TACGenerator
import MIPSGenerator
import Parser (parse)
import Lexer (alexScanTokens)
import System.IO (readFile, writeFile)
import System.Directory (doesFileExist)
import System.FilePath (takeBaseName)

main :: IO ()
main = do
    putStrLn "=== COMPILADOR ADA -> TAC -> MIPS ==="
    putStrLn "=== SEGUNDA PARTE DO TRABALHO ===\n"
    
    let filePath = "examples/test1.ada"
    
    putStrLn $ "PROCURANDO ARQUIVO: " ++ filePath
    
    compileAdaFile filePath

-- compilar arquivo .ada
compileAdaFile :: FilePath -> IO ()
compileAdaFile filePath = do
    content <- readFile filePath
    
    putStrLn "CÓDIGO FONTE ADA:"
    putStrLn "==================="
    putStrLn content
    putStrLn ""
    
    putStrLn "FAZENDO LEXING E PARSING..."
    putStrLn "=============================="
    
    let tokens = alexScanTokens content
    putStrLn $ "Tokens reconhecidos: " ++ show (length tokens) ++ " tokens"
    
    let parseResult = parse tokens
    putStrLn "Parsing concluído com sucesso!"
    putStrLn ""
    
    putStrLn "ESTRUTURA AST:"
    putStrLn "================"
    print parseResult
    putStrLn ""
    
    putStrLn "GERANDO CÓDIGO TAC..."
    putStrLn "========================"
    
    let tacCode = generateTAC parseResult
    putStrLn "CÓDIGO TAC GERADO:"
    putStrLn "------------------"
    mapM_ (putStrLn . tacToString) tacCode
    
    putStrLn ""
    putStrLn "GERANDO CÓDIGO MIPS..."
    putStrLn "========================="
    
    let mipsCode = generateMIPS tacCode
    
    let baseName = takeBaseName filePath
    let tacFile = baseName ++ ".tac"
    let asmFile = baseName ++ ".asm"
    
    -- arquivos de saída
    writeFile tacFile (unlines (map tacToString tacCode))
    writeFile asmFile mipsCode
    
    putStrLn $ "ARQUIVOS GERADOS COM SUCESSO:"
    putStrLn $ "   - " ++ tacFile ++ " (Código TAC)"
    putStrLn $ "   - " ++ asmFile ++ " (Código MIPS)"
    putStrLn ""
    putStrLn "PARA TESTAR NO MARS:"
    putStrLn $ "   - Abra o arquivo " ++ asmFile ++ " no MARS"
    putStrLn $ "   - Execute e verifique a saída"
    putStrLn ""
    putStrLn "COMPILAÇÃO CONCLUÍDA!"