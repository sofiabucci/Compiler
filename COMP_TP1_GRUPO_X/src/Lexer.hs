{-# LANGUAGE FlexibleContexts #-}

module Lexer where

import Control.Monad (void)
import Control.Monad.State
import Data.Char (isAlpha, isDigit, isAlphaNum, isSpace)

data Token
    = TIdentifier String
    | TInt Integer
    | TString String
    | TProcedure | TIs | TBegin | TEnd 
    | TIf | TThen | TElse | TWhile | TLoop
    | TAnd | TOr | TNot
    | TPutLine | TGetLine
    | TAssign | TPlus | TMinus | TMult | TDiv
    | TEq | TLt | TGt
    | TSemi | TColon | TComma | TLParen | TRParen
    | TEOF
    deriving (Show, Eq, Ord)

data LexerState = LexerState
    { input :: String
    , position :: Int
    , line :: Int
    , column :: Int
    }

type Lexer = StateT LexerState Maybe

initialState :: String -> LexerState
initialState str = LexerState str 0 1 1

lexer :: String -> [Token]
lexer input = case evalStateT lexTokens (initialState input) of
    Just tokens -> tokens ++ [TEOF]
    Nothing -> error "Lexical error"

lexTokens :: Lexer [Token]
lexTokens = do
    state <- get
    if null (input state) 
        then return []
        else do
            skipWhitespace
            token <- nextToken
            tokens <- lexTokens
            return (token : tokens)

nextToken :: Lexer Token
nextToken = do
    state <- get
    case input state of
        [] -> return TEOF
        (c:cs) 
            | isAlpha c -> lexIdentifier
            | isDigit c -> lexNumber
            | c == '"'  -> lexString
            | otherwise -> lexSymbol

lexIdentifier :: Lexer Token
lexIdentifier = do
    ident <- takeWhile1 isAlphaNum
    return $ case ident of
        "procedure" -> TProcedure
        "is" -> TIs
        "begin" -> TBegin
        "end" -> TEnd
        "if" -> TIf
        "then" -> TThen
        "else" -> TElse
        "while" -> TWhile
        "loop" -> TLoop
        "and" -> TAnd
        "or" -> TOr
        "not" -> TNot
        "Put_Line" -> TPutLine
        "Get_Line" -> TGetLine
        _ -> TIdentifier ident

lexNumber :: Lexer Token
lexNumber = do
    numStr <- takeWhile1 isDigit
    return $ TInt (read numStr)

lexString :: Lexer Token
lexString = do
    void $ match '"'
    str <- takeWhile (/= '"')
    void $ match '"'
    return $ TString str

lexSymbol :: Lexer Token
lexSymbol = do
    state <- get
    case input state of
        (':':'=':cs) -> advance 2 >> return TAssign
        ('+':cs) -> advance 1 >> return TPlus
        ('-':cs) -> advance 1 >> return TMinus
        ('*':cs) -> advance 1 >> return TMult
        ('/':cs) -> advance 1 >> return TDiv
        ('=':cs) -> advance 1 >> return TEq
        ('<':cs) -> advance 1 >> return TLt
        ('>':cs) -> advance 1 >> return TGt
        (';':cs) -> advance 1 >> return TSemi
        (':':cs) -> advance 1 >> return TColon
        (',':cs) -> advance 1 >> return TComma
        ('(':cs) -> advance 1 >> return TLParen
        (')':cs) -> advance 1 >> return TRParen
        _ -> fail "Unknown symbol"

-- Helper functions
advance :: Int -> Lexer ()
advance n = modify $ \state -> state 
    { input = drop n (input state)
    , position = position state + n
    , column = column state + n
    }

match :: Char -> Lexer Char
match c = do
    state <- get
    case input state of
        (x:xs) | x == c -> advance 1 >> return c
        _ -> fail $ "Expected '" ++ [c] ++ "'"

takeWhile :: (Char -> Bool) -> Lexer String
takeWhile p = do
    state <- get
    let (token, rest) = span p (input state)
    put state { input = rest, position = position state + length token }
    return token

takeWhile1 :: (Char -> Bool) -> Lexer String
takeWhile1 p = do
    str <- takeWhile p
    if null str then fail "takeWhile1: no characters" else return str

skipWhitespace :: Lexer ()
skipWhitespace = void $ takeWhile isSpace