{-
Módulo: TAC.hs
Descrição: Define a estrutura do código de três endereços (Three-Address Code)
-}

module TAC where

-- Instruções do código de três endereços
data TAC = Assign String TACExpr    -- x = y (atribuição)
         | Label String             -- L1: (rótulo para jumps)
         | Goto String              -- goto L1 (salto incondicional)
         | IfZ TACExpr String       -- ifz x goto L1 (salto se zero)
         | IfNZ TACExpr String      -- ifnz x goto L1 (salto se não zero)
         | Param TACExpr            -- param x (passagem de parâmetro)
         | Call String Int          -- call f, n (chamada de função com n params)
         | Return TACExpr           -- return x (retorno de função)
    deriving (Show, Eq)

-- Expressões no código de três endereços
data TACExpr = TACVar String        -- Variável (x)
             | TACInt Integer       -- Inteiro (42)
             | TACStr String        -- String ("hello")
             | TACBool Bool         -- Booleano (True/False)
             | TACTemp Int          -- Temporário (t1, t2, ...)
    deriving (Show, Eq)

-- Programa como lista de instruções TAC
type TACProgram = [TAC]

-- Gera um novo temporário (incrementa contador)
newTemp :: Int -> (Int, TACExpr)
newTemp n = (n+1, TACTemp n)

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