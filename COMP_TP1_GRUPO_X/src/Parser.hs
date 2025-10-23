{-# LANGUAGE FlexibleContexts #-}

module Parser where

import AST
import Lexer
import Control.Monad.Except
import Control.Monad.State

type Parser = ExceptT String (State [Token])

parseProgram :: String -> Either String Program
parseProgram input = 
    case evalState (runExceptT parser) (lexer input) of
        Left err -> Left err
        Right (program, []) -> Right program
        Right (_, tokens) -> Left $ "Unexpected tokens at end: " ++ show (take 3 tokens)

parser :: Parser Program
parser = do
    program <- parseProgram'
    eof
    return program

parseProgram' :: Parser Program
parseProgram' = do
    match TProcedure
    name <- matchIdentifier
    match TIs
    match TBegin
    stmts <- parseStatements
    match TEnd
    match TSemi
    return $ Program name stmts

parseStatements :: Parser [Statement]
parseStatements = do
    tokens <- get
    case tokens of
        (TEnd:_) -> return []
        _ -> do
            stmt <- parseStatement
            stmts <- parseStatements
            return (stmt:stmts)

parseStatement :: Parser Statement
parseStatement = do
    tokens <- get
    case tokens of
        (TIf:_) -> parseIf
        (TWhile:_) -> parseWhile
        (TIdentifier var:TAssign:_) -> parseAssignment var
        _ -> ExpressionStmt <$> parseExpression

parseAssignment :: String -> Parser Statement
parseAssignment var = do
    match (TIdentifier var)
    match TAssign
    expr <- parseExpression
    match TSemi
    return $ Assignment var expr

parseIf :: Parser Statement
parseIf = do
    match TIf
    cond <- parseExpression
    match TThen
    thenBranch <- parseStatements
    elseBranch <- parseElse
    match TEnd
    match TIf
    match TSemi
    return $ If cond thenBranch elseBranch
  where
    parseElse = do
        tokens <- get
        case tokens of
            (TElse:_) -> do
                match TElse
                Just <$> parseStatements
            _ -> return Nothing

parseWhile :: Parser Statement
parseWhile = do
    match TWhile
    cond <- parseExpression
    match TLoop
    body <- parseStatements
    match TEnd
    match TLoop
    match TSemi
    return $ While cond body

-- Helper functions for parser combinators
match :: Token -> Parser Token
match expected = do
    tokens <- get
    case tokens of
        (token:rest) | token == expected -> do
            put rest
            return token
        (token:_) -> throwError $ 
            "Expected " ++ show expected ++ " but got " ++ show token
        [] -> throwError $ 
            "Expected " ++ show expected ++ " but reached end of input"

matchIdentifier :: Parser String
matchIdentifier = do
    tokens <- get
    case tokens of
        (TIdentifier name:rest) -> do
            put rest
            return name
        (token:_) -> throwError $
            "Expected identifier but got " ++ show token
        [] -> throwError "Expected identifier but reached end of input"

eof :: Parser ()
eof = do
    tokens <- get
    case tokens of
        [] -> return ()
        _ -> throwError $ "Expected EOF but got " ++ show (head tokens)