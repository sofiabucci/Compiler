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
    
    -- Define o arquivo de entrada
    let filePath = "examples/test1.ada"
    
    putStrLn $ "PROCURANDO ARQUIVO: " ++ filePath

-- Compila um arquivo .ada usando o lexer e parser existentes
compileAdaFile :: FilePath -> IO ()
compileAdaFile filePath = do
    -- Lê o conteúdo do arquivo
    content <- readFile filePath
    
    putStrLn "CÓDIGO FONTE ADA:"
    putStrLn "==================="
    putStrLn content
    putStrLn ""
    
    -- Usa o lexer e parser existentes
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
    
    -- Gera nomes de arquivo baseados no arquivo de entrada
    let baseName = takeBaseName filePath
    let tacFile = baseName ++ ".tac"
    let asmFile = baseName ++ ".asm"
    
    -- Escreve os arquivos de saída
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