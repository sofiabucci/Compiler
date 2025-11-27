{-
Módulo: TACGenerator.hs
Descrição: Gera código de três endereços a partir da AST
-}

module TACGenerator where

import AST
import SymbolTable
import TAC
import Control.Monad.State

-- Estado do gerador: (próximo temporário, lista de instruções)
type GenState = (Int, [TAC])
type GenM = State GenState

-- Gera um novo temporário único
freshTemp :: GenM TACExpr
freshTemp = do
    (n, instrs) <- get           -- Pega estado atual
    put (n+1, instrs)            -- Atualiza contador
    return (TACTemp n)           -- Retorna novo temporário

-- Adiciona uma instrução à lista
emit :: TAC -> GenM ()
emit instr = do
    (n, instrs) <- get           -- Pega instruções atuais
    put (n, instrs ++ [instr])   -- Adiciona nova instrução

-- Função principal: converte AST para TAC
generateTAC :: Program -> TACProgram
generateTAC (Program name _ stmts) = 
    let (_, instrs) = runState (genStmts stmts) (0, [])  -- Executa monad State
    in instrs

-- Gera código para lista de statements
genStmts :: [Statement] -> GenM ()
genStmts = mapM_ genStmt

-- Gera código para um statement individual
genStmt :: Statement -> GenM ()
genStmt (Assignment var expr) = do
    tacExpr <- genExpr expr          -- Gera código para expressão
    emit $ Assign var tacExpr        -- Emite instrução de atribuição

genStmt (If cond thenStmts elseStmts) = do
    elseLabel <- freshLabel          -- Rótulo para else
    endLabel <- freshLabel           -- Rótulo para fim do if
    condExpr <- genExpr cond         -- Gera código para condição
    
    -- if (cond == false) goto elseLabel
    emit $ IfZ condExpr elseLabel
    
    -- Código do then
    genStmts thenStmts
    
    -- goto endLabel (pular else)
    emit $ Goto endLabel
    
    -- elseLabel:
    emit $ Label elseLabel
    
    -- Código do else (se existir)
    case elseStmts of
        Just stmts -> genStmts stmts
        Nothing -> return ()
    
    -- endLabel:
    emit $ Label endLabel

genStmt (While cond bodyStmts) = do
    startLabel <- freshLabel         -- Rótulo do início do loop
    endLabel <- freshLabel           -- Rótulo do fim do loop
    
    -- startLabel:
    emit $ Label startLabel
    
    -- Gera código para condição
    condExpr <- genExpr cond
    
    -- if (cond == false) goto endLabel
    emit $ IfZ condExpr endLabel
    
    -- Corpo do loop
    genStmts bodyStmts
    
    -- goto startLabel (voltar ao início)
    emit $ Goto startLabel
    
    -- endLabel:
    emit $ Label endLabel

-- Gera código para Put_Line e Get_Line
genStmt (ExpressionStmt (Call "Put_Line" [arg])) = do
    tacArg <- genExpr arg            -- Gera código para argumento
    emit $ Param tacArg              -- Passa como parâmetro
    emit $ Call "Put_Line" 1         -- Chama Put_Line com 1 parâmetro

genStmt (ExpressionStmt (Call "Get_Line" [])) = do
    temp <- freshTemp                -- Cria temporário para resultado
    emit $ Call "Get_Line" 0         -- Chama Get_Line sem parâmetros
    emit $ Assign "input" temp       -- Armazena resultado em "input"

-- Gera código para expressões
genExpr :: Expression -> GenM TACExpr
genExpr (Var v) = return $ TACVar v  -- Variável direta

genExpr (IntLit i) = return $ TACInt i    -- Literal inteiro
genExpr (StrLit s) = return $ TACStr s    -- Literal string
genExpr (BoolLit b) = return $ TACBool b  -- Literal booleano

genExpr (BinOp op left right) = do
    leftExpr <- genExpr left         -- Gera código para operando esquerdo
    rightExpr <- genExpr right       -- Gera código para operando direito
    temp <- freshTemp                -- Cria temporário para resultado
    -- Emite instrução: temp = left op right
    emit $ Assign (show temp) (TACBinOp op leftExpr rightExpr)
    return temp

genExpr (UnOp op expr) = do
    expr' <- genExpr expr            -- Gera código para expressão
    temp <- freshTemp                -- Cria temporário para resultado
    -- Emite instrução: temp = op expr
    emit $ Assign (show temp) (TACUnOp op expr')
    return temp

genExpr (Call func args) = do
    tacArgs <- mapM genExpr args     -- Gera código para argumentos
    mapM_ (\a -> emit $ Param a) tacArgs  -- Passa cada argumento
    temp <- freshTemp                -- Cria temporário para retorno
    emit $ Call func (length args)   -- Chama função
    emit $ Assign (show temp) (TACVar "retval")  -- Armazena valor de retorno
    return temp

-- Gera um novo rótulo único
freshLabel :: GenM String
freshLabel = do
    (n, _) <- get                    -- Pega contador atual
    put (n+1, [])                    -- Incrementa contador
    return $ "L" ++ show n           -- Retorna L1, L2, etc.

-- Operadores binários para TAC
data TACBinOp = TACAdd | TACSub | TACMul | TACDiv | TACEq | TACNeq | TACLt | TACGt | TACLeq | TACGeq | TACAnd | TACOr

-- Operadores unários para TAC  
data TACUnOp = TACNot | TACNeg