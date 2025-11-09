{
module Parser where

import AST
import Lexer
}

%name parse
%tokentype { Token }
%error { parseError }

%token
  procedure   { TokenProcedure }
  is          { TokenIs }
  begin       { TokenBegin }
  end         { TokenEnd }
  if          { TokenIf }
  then        { TokenThen }
  else        { TokenElse }
  while       { TokenWhile }
  loop        { TokenLoop }
  and         { TokenAnd }
  or          { TokenOr }
  not         { TokenNot }
  true        { TokenTrue }
  false       { TokenFalse }
  putline     { TokenPutLine }
  getline     { TokenGetLine }
  id          { TokenId $$ }
  int         { TokenInt $$ }
  string      { TokenString $$ }
  ':='        { TokenAssign }
  '+'         { TokenPlus }
  '-'         { TokenMinus }
  '*'         { TokenTimes }
  '/'         { TokenDiv }
  '='         { TokenEq }
  '<'         { TokenLt }
  '>'         { TokenGt }
  '('         { TokenLParen }
  ')'         { TokenRParen }
  ';'         { TokenSemicolon }

%left or
%left and
%nonassoc '=' '<' '>'
%left '+' '-'
%left '*' '/'
%right not NEG

%%

Program : procedure id is begin Statements end id ';' 
            { Program $2 $5 }

Statements : Statement                { [$1] }
           | Statement Statements     { $1 : $2 }

Statement : id ':=' Expression ';'              { Assignment $1 $3 }
          | if Expression then Statements end if ';'  
              { If $2 $4 Nothing }
          | if Expression then Statements else Statements end if ';'  
              { If $2 $4 (Just $6) }
          | while Expression loop Statements end loop ';'  
              { While $2 $4 }
          | Expression ';'                      { ExpressionStmt $1 }

Expression : id                                 { Var $1 }
           | int                                { IntLit $1 }
           | string                             { StrLit $1 }
           | true                               { BoolLit True }
           | false                              { BoolLit False }
           | Expression '+' Expression          { BinOp Add $1 $3 }
           | Expression '-' Expression          { BinOp Sub $1 $3 }
           | Expression '*' Expression          { BinOp Mul $1 $3 }
           | Expression '/' Expression          { BinOp Div $1 $3 }
           | Expression '=' Expression          { BinOp Eq $1 $3 }
           | Expression '<' Expression          { BinOp Lt $1 $3 }
           | Expression '>' Expression          { BinOp Gt $1 $3 }
           | Expression and Expression          { BinOp And $1 $3 }
           | Expression or Expression           { BinOp Or $1 $3 }
           | not Expression                     { UnOp Not $2 }
           | '-' Expression %prec NEG           { UnOp Neg $2 }
           | putline '(' Expression ')'         { Call "Put_Line" [$3] }
           | getline                            { Call "Get_Line" [] }
           | '(' Expression ')'                 { $2 }

{
parseError :: [Token] -> a
parseError tokens = error ("Parse error at: " ++ show (take 10 tokens))
}