module TACGenerator where

import AST
import SymbolTable
import TAC
import Control.Monad.State

type GenState = (Int, Int, [TAC])
type GenM = State GenState

freshTemp :: GenM TACExpr
freshTemp = do
    (tempCount, labelCount, instrs) <- get
    put (tempCount + 1, labelCount, instrs)
    return (TACTemp tempCount)

freshLabel :: GenM String
freshLabel = do
    (tempCount, labelCount, instrs) <- get
    put (tempCount, labelCount + 1, instrs)
    return $ "L" ++ show labelCount

emit :: TAC -> GenM ()
emit instr = do
    (tempCount, labelCount, instrs) <- get
    put (tempCount, labelCount, instrs ++ [instr])

tempName :: TACExpr -> String
tempName (TACTemp n) = "t" ++ show n
tempName (TACVar v)  = v
tempName _ = error "tempName: expected TACTemp or TACVar"

generateTAC :: Program -> TACProgram
generateTAC (Program _name _declarations stmts) =
    let initialState = (0, 0, []) :: GenState
        (_, newState) = runState (genStmts stmts) initialState
        (_, _, instrs) = newState
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
    condTemp <- genExpr cond
    emit $ IfZ condTemp elseLabel
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
    condTemp <- genExpr cond
    emit $ IfZ condTemp endLabel
    genStmts bodyStmts
    emit $ Goto startLabel
    emit $ Label endLabel

genStmt (ExpressionStmt (AST.Call "Put_Line" [arg])) = do
    tacArg <- genExpr arg
    emit $ Param tacArg
    emit $ TAC.Call "Put_Line" 1

genStmt (ExpressionStmt (AST.Call "Get_Line" [])) = do
    resultTemp <- freshTemp
    emit $ TAC.Call "Get_Line" 0
    emit $ Assign (tempName resultTemp) (TACVar "retval")

genStmt (ExpressionStmt (AST.Call func args)) = do
    tacArgs <- mapM genExpr args
    mapM_ (\a -> emit $ Param a) tacArgs
    resultTemp <- freshTemp
    emit $ TAC.Call func (length args)
    emit $ Assign (tempName resultTemp) (TACVar "retval")

genExpr :: Expression -> GenM TACExpr
genExpr (Var v) = return $ TACVar v
genExpr (IntLit i) = return $ TACInt i
genExpr (StrLit s) = return $ TACStr s
genExpr (BoolLit b) = return $ TACBool b

genExpr (BinOp op left right) = do
    leftTemp <- genExpr left
    rightTemp <- genExpr right
    resultTemp <- freshTemp


    case op of
        Add -> emit $ Assign (tempName resultTemp) (TACVar $ "(" ++ TAC.showExpr leftTemp ++ " + " ++ TAC.showExpr rightTemp ++ ")")
        Sub -> emit $ Assign (tempName resultTemp) (TACVar $ "(" ++ TAC.showExpr leftTemp ++ " - " ++ TAC.showExpr rightTemp ++ ")")
        Mul -> emit $ Assign (tempName resultTemp) (TACVar $ "(" ++ TAC.showExpr leftTemp ++ " * " ++ TAC.showExpr rightTemp ++ ")")
        Div -> emit $ Assign (tempName resultTemp) (TACVar $ "(" ++ TAC.showExpr leftTemp ++ " / " ++ TAC.showExpr rightTemp ++ ")")
        Eq  -> emit $ Assign (tempName resultTemp) (TACVar $ "(" ++ TAC.showExpr leftTemp ++ " == " ++ TAC.showExpr rightTemp ++ ")")
        Lt  -> emit $ Assign (tempName resultTemp) (TACVar $ "(" ++ TAC.showExpr leftTemp ++ " < " ++ TAC.showExpr rightTemp ++ ")")
        Gt  -> emit $ Assign (tempName resultTemp) (TACVar $ "(" ++ TAC.showExpr leftTemp ++ " > " ++ TAC.showExpr rightTemp ++ ")")
        And -> emit $ Assign (tempName resultTemp) (TACVar $ "(" ++ TAC.showExpr leftTemp ++ " and " ++ TAC.showExpr rightTemp ++ ")")
        Or  -> emit $ Assign (tempName resultTemp) (TACVar $ "(" ++ TAC.showExpr leftTemp ++ " or " ++ TAC.showExpr rightTemp ++ ")")
        _   -> emit $ Assign (tempName resultTemp) (TACVar $ "(" ++ TAC.showExpr leftTemp ++ " ?? " ++ TAC.showExpr rightTemp ++ ")")

    return resultTemp

genExpr (UnOp op expr) = do
    exprTemp <- genExpr expr
    resultTemp <- freshTemp

    case op of
        Not -> emit $ Assign (tempName resultTemp) (TACVar $ "not " ++ TAC.showExpr exprTemp)
        Neg -> emit $ Assign (tempName resultTemp) (TACVar $ "-" ++ TAC.showExpr exprTemp)

    return resultTemp

genExpr (AST.Call func args) = do
    tacArgs <- mapM genExpr args
    mapM_ (\a -> emit $ Param a) tacArgs
    resultTemp <- freshTemp
    emit $ TAC.Call func (length args)
    emit $ Assign (tempName resultTemp) (TACVar "retval")
    return resultTemp