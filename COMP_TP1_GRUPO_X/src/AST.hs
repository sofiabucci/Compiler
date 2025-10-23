-- src/AST.hs
module AST where

data Program = Program String [Statement]
    deriving (Show, Eq)

data Statement 
    = Assignment String Expression
    | If Expression [Statement] (Maybe [Statement])
    | While Expression [Statement]
    | ExpressionStmt Expression
    deriving (Show, Eq)

data Expression
    = Var String
    | IntLit Integer
    | StrLit String
    | BoolLit Bool
    | BinOp Op Expression Expression
    | UnOp UnOp Expression
    | Call String [Expression]
    deriving (Show, Eq)

data Op = Add | Sub | Mul | Div | Eq | Lt | Gt | And | Or
    deriving (Show, Eq)

data UnOp = Not | Neg
    deriving (Show, Eq)