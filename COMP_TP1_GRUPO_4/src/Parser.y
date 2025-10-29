{
module Parser where
import AST
import Lexer
}

%name parseProgram
%tokentype { Token }

%token
    TIdentifier   { TIdentifier $$ }
    TInt          { TInt $$ }
    TString       { TString $$ }
    TProcedure    { TProcedure }
    TIs           { TIs }
    TBegin        { TBegin }
    TEnd          { TEnd }
    TIf           { TIf }
    TThen         { TThen }
    TElse         { TElse }
    TWhile        { TWhile }
    TLoop         { TLoop }
    TAnd          { TAnd }
    TOr           { TOr }
    TNot          { TNot }
    TPutLine      { TPutLine }
    TGetLine      { TGetLine }
    TAssign       { TAssign }
    TPlus         { TPlus }
    TMinus        { TMinus }
    TMult         { TMult }
    TDiv          { TDiv }
    TEq           { TEq }
    TLt           { TLt }
    TGt           { TGt }
    TSemi         { TSemi }
    TColon        { TColon }
    TComma        { TComma }
    TLParen       { TLParen }
    TRParen       { TRParen }

%nonassoc TElse
%right TAssign
%left TOr
%left TAnd
%left TEq TLt TGt
%left TPlus TMinus
%left TMult TDiv
%right TNot

%%

Program : TProcedure TIdentifier TIs TBegin Statements TEnd TSemi
            { Program $2 $5 }

Statements : {- empty -}           { [] }
           | Statement Statements  { $1 : $2 }

Statement : Assignment
          | IfStmt
          | WhileStmt
          | ExpressionStmt

Assignment : TIdentifier TAssign Expression TSemi
            { Assignment $1 $3 }

IfStmt : TIf Expression TThen Statements TEnd TIf TSemi
          { If $2 $4 Nothing }
       | TIf Expression TThen Statements TElse Statements TEnd TIf TSemi
          { If $2 $4 (Just $6) }

WhileStmt : TWhile Expression TLoop Statements TEnd TLoop TSemi
             { While $2 $4 }

ExpressionStmt : Expression TSemi
                  { ExpressionStmt $1 }

Expression : TIdentifier           { Var $1 }
           | TInt                  { IntLit $1 }
           | TString               { StrLit $1 }
           | TPutLine TLParen Expression TRParen
                                   { Call "Put_Line" [$3] }
           | TGetLine TLParen TRParen
                                   { Call "Get_Line" [] }
           | Expression TPlus Expression   { BinOp Add $1 $3 }
           | Expression TMinus Expression  { BinOp Sub $1 $3 }
           | Expression TMult Expression   { BinOp Mul $1 $3 }
           | Expression TDiv Expression    { BinOp Div $1 $3 }
           | Expression TEq Expression     { BinOp Eq $1 $3 }
           | Expression TLt Expression     { BinOp Lt $1 $3 }
           | Expression TGt Expression     { BinOp Gt $1 $3 }
           | Expression TAnd Expression    { BinOp And $1 $3 }
           | Expression TOr Expression     { BinOp Or $1 $3 }
           | TNot Expression        { UnOp Not $2 }
           | TMinus Expression      %prec TNot { UnOp Neg $2 }
           | TLParen Expression TRParen { $2 }

{
happyError :: [Token] -> a
happyError _ = error "Syntax error"

parse :: [Token] -> Program
parse = parseProgram
}