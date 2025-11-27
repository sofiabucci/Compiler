module TACGenerator where

import AST
import SymbolTable
import TAC
import Control.Monad.State

type GenState = (Int, [TAC])  -- (nextTemp, instructions)
type GenM = State GenState

freshTemp :: GenM TACExpr
freshTemp = do
    (n, instrs) <- get
    put (n+1, instrs)
    return (TACTemp n)

emit :: TAC -> GenM ()
emit instr = do
    (n, instrs) <- get
    put (n, instrs ++ [instr])

generateTAC :: Program -> TACProgram
generateTAC (Program name _ stmts) = 
    let (_, instrs) = runState (genStmts stmts) (0, [])
    in instrs

genStmts :: [Statement] -> GenM ()
genStmts = mapM_ genStmt

genStmt :: Statement -> GenM ()
genStmt (Assignment var expr) = do
    tacExpr <- genExpr expr
    emit $ Assign var tacExpr
genStmt (If cond thenStmts elseStmts) = do
    elseLabel <- freshLabel
    endLabel <- freshLabel
    condExpr <- genExpr cond
    emit $ IfZ condExpr elseLabel
    genStmts thenStmts
    emit $ Goto endLabel
    emit $ Label elseLabel
    case elseStmts of
        Just stmts -> genStmts stmts
        Nothing -> return ()
    emit $ Label endLabel
genStmt (While cond bodyStmts) = do
    startLabel <- freshLabel
    endLabel <- freshLabel
    emit $ Label startLabel
    condExpr <- genExpr cond
    emit $ IfZ condExpr endLabel
    genStmts bodyStmts
    emit $ Goto startLabel
    emit $ Label endLabel
genStmt (ExpressionStmt (Call "Put_Line" [arg])) = do
    tacArg <- genExpr arg
    emit $ Param tacArg
    emit $ Call "Put_Line" 1
genStmt (ExpressionStmt (Call "Get_Line" [])) = do
    temp <- freshTemp
    emit $ Call "Get_Line" 0
    emit $ Assign "input" temp

genExpr :: Expression -> GenM TACExpr
genExpr (Var v) = return $ TACVar v
genExpr (IntLit i) = return $ TACInt i
genExpr (StrLit s) = return $ TACStr s
genExpr (BoolLit b) = return $ TACBool b
genExpr (BinOp op left right) = do
    leftExpr <- genExpr left
    rightExpr <- genExpr right
    temp <- freshTemp
    emit $ Assign (show temp) (TACBinOp op leftExpr rightExpr)
    return temp
genExpr (UnOp op expr) = do
    expr' <- genExpr expr
    temp <- freshTemp
    emit $ Assign (show temp) (TACUnOp op expr')
    return temp
genExpr (Call func args) = do
    tacArgs <- mapM genExpr args
    mapM_ (\a -> emit $ Param a) tacArgs
    temp <- freshTemp
    emit $ Call func (length args)
    emit $ Assign (show temp) (TACVar "retval")
    return temp

freshLabel :: GenM String
freshLabel = do
    (n, _) <- get
    put (n+1, [])
    return $ "L" ++ show n

data TACBinOp = TACAdd | TACSub | TACMul | TACDiv | TACEq | TACNeq | TACLt | TACGt | TACLeq | TACGeq | TACAnd | TACOr
data TACUnOp = TACNot | TACNeg