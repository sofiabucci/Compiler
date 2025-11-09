{
module Lexer where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
$alphanum = [a-zA-Z0-9_]

tokens :-

  $white+                       ;
  "--".*                        ;
  
  procedure                     { \s -> TokenProcedure }
  is                            { \s -> TokenIs }
  begin                         { \s -> TokenBegin }
  end                           { \s -> TokenEnd }
  if                            { \s -> TokenIf }
  then                          { \s -> TokenThen }
  else                          { \s -> TokenElse }
  while                         { \s -> TokenWhile }
  loop                          { \s -> TokenLoop }
  and                           { \s -> TokenAnd }
  or                            { \s -> TokenOr }
  not                           { \s -> TokenNot }
  True                          { \s -> TokenTrue }
  False                         { \s -> TokenFalse }
  
  Put_Line                      { \s -> TokenPutLine }
  Get_Line                      { \s -> TokenGetLine }
  
  $alpha $alphanum*             { \s -> TokenId s }
  $digit+                       { \s -> TokenInt (read s) }
  \"[^\"]*\"                    { \s -> TokenString (init (tail s)) }
  
  ":="                          { \s -> TokenAssign }
  ":"                           { \s -> TokenColon }        
  "+"                           { \s -> TokenPlus }
  "-"                           { \s -> TokenMinus }
  "*"                           { \s -> TokenTimes }
  "/"                           { \s -> TokenDiv }
  "="                           { \s -> TokenEq }
  "<"                           { \s -> TokenLt }
  ">"                           { \s -> TokenGt }
  "("                           { \s -> TokenLParen }
  ")"                           { \s -> TokenRParen }
  ";"                           { \s -> TokenSemicolon }

{
data Token
  = TokenProcedure
  | TokenIs
  | TokenBegin
  | TokenEnd
  | TokenIf
  | TokenThen
  | TokenElse
  | TokenWhile
  | TokenLoop
  | TokenAnd
  | TokenOr
  | TokenNot
  | TokenTrue
  | TokenFalse
  | TokenPutLine
  | TokenGetLine
  | TokenId String
  | TokenInt Integer
  | TokenString String
  | TokenAssign
  | TokenColon                
  | TokenPlus
  | TokenMinus
  | TokenTimes
  | TokenDiv
  | TokenEq
  | TokenLt
  | TokenGt
  | TokenLParen
  | TokenRParen
  | TokenSemicolon
  deriving (Eq, Show)
}
