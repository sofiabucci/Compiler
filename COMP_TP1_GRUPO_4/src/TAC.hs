module TAC where

-- Instruções do código de três endereços
data TAC = Assign String TACExpr    
         | Label String             
         | Goto String              
         | IfZ TACExpr String       
         | IfNZ TACExpr String      
         | Param TACExpr            
         | Call String Int          
         | Return TACExpr           
    deriving (Show, Eq)

-- Expressões no código de três endereços
data TACExpr = TACVar String        
             | TACInt Integer       
             | TACStr String         
             | TACBool Bool         
             | TACTemp Int          
    deriving (Show, Eq)

-- Programa como lista de instruções TAC
type TACProgram = [TAC]

-- Converte instrução TAC para string (para debugging)
tacToString :: TAC -> String
tacToString (Assign dest expr) = show dest ++ " = " ++ showExpr expr
tacToString (Label lbl) = lbl ++ ":"
tacToString (Goto lbl) = "goto " ++ lbl
tacToString (IfZ cond lbl) = "ifz " ++ showExpr cond ++ " goto " ++ lbl
tacToString (IfNZ cond lbl) = "ifnz " ++ showExpr cond ++ " goto " ++ lbl
tacToString (Param expr) = "param " ++ showExpr expr
tacToString (Call func n) = "call " ++ func ++ ", " ++ show n
tacToString (Return expr) = "return " ++ showExpr expr

-- Converte expressão TAC para string
showExpr :: TACExpr -> String
showExpr (TACVar v) = v
showExpr (TACInt i) = show i
showExpr (TACStr s) = "\"" ++ s ++ "\""
showExpr (TACBool b) = show b
showExpr (TACTemp t) = "t" ++ show t