{
module Lexer where
import AST
}

%wrapper "basic"

$white = [\ \t\n\r]+
$digit = [0-9]
$alpha = [a-zA-Z]

tokens :-

-- Comentários
--.*                           ;

-- Palavras reservadas
procedure                     { \s -> TProcedure }
is                            { \s -> TIs }
begin                         { \s -> TBegin }
end                           { \s -> TEnd }
if                            { \s -> TIf }
then                          { \s -> TThen }
else                          { \s -> TElse }
while                         { \s -> TWhile }
loop                          { \s -> TLoop }
and                           { \s -> TAnd }
or                            { \s -> TOr }
not                           { \s -> TNot }
Put_Line                      { \s -> TPutLine }
Get_Line                      { \s -> TGetLine }

-- Identificadores
$alpha [$alpha $digit \_ \']* { \s -> TIdentifier s }

-- Números
$digit+                       { \s -> TInt (read s) }

-- Strings
\" [^\"]* \"                  { \s -> TString (init (tail s)) }

-- Símbolos
":="                          { \s -> TAssign }
"+"                           { \s -> TPlus }
"-"                           { \s -> TMinus }
"*"                           { \s -> TMult }
"/"                           { \s -> TDiv }
"="                           { \s -> TEq }
"<"                           { \s -> TLt }
">"                           { \s -> TGt }
";"                           { \s -> TSemi }
":"                           { \s -> TColon }
","                           { \s -> TComma }
"("                           { \s -> TLParen }
")"                           { \s -> TRParen }

-- Whitespace
$white+                       ;

{
alexScanTokens :: String -> [Token]
alexScanTokens = alexScanTokens'

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
}