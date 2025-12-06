module SymbolTable where
import Data.Map as Map

data SymbolCategory = Variable
                     | Function
                     | Type
                     deriving (Eq, Show)

data DataType = IntegerType
               | FloatType
               | BooleanType
               | CharacterType
               | ArrayType Int DataType
               | RecordType [(String, DataType)]
               | UnknowType
               deriving (Eq, Show)

data SymbolInfo = SymbolInfo {
    symbolCategory :: SymbolCategory,
    dataType :: DataType, 
    isConstant :: Bool, 
    value :: Maybe String
} deriving (Eq, Show)


emptyTable :: SymbolTable
emptyTable = Map.empty

insertSymbol :: String -> SymbolInfo -> SymbolTable -> SymbolTable
insertSymbol name category table = Map.insert name category table

lookupSymbol :: String -> SymbolTable -> Maybe SymbolInfo
lookupSymbol name table = Map.lookup name table


type ScopeStack = [SymbolTable]

initialScope :: ScopeStack
initialScope = [emptyTable]

enterScope :: ScopeStack -> ScopeStack
enterScope stack = emptyTable : stack

exitScope :: ScopeStack -> ScopeStack
exitScope [] = error "Stack Vazia, não há âmbitos para fechar"
exitScope (_:rest) = rest

lookupSymbolScope :: String -> ScopeStack -> Maybe SymbolInfo
lookupSymbolScope _ [] = Nothing
lookupSymbolScope name (current:outerScopes) = 
    case lookupSymbol name current of
        Just info -> Just info            
        Nothing -> lookupSymbolScope name outerScopes     

declareSymbol :: String -> SymbolInfo -> ScopeStack -> ScopeStack
declareSymbol name category [] = error "Stack Vazia, não há âmbitos para fechar"
declareSymbol name category (current:outerScopes) =
    (insertSymbol name category current) : outerScopes

type SymbolTable = Map.Map String SymbolInfo

makeVariable :: DataType -> SymbolInfo
makeVariable typ = SymbolInfo Variable typ False Nothing

makeFunction :: DataType -> SymbolInfo
makeFunction returnType = SymbolInfo Function returnType False Nothing

makeType :: DataType -> SymbolInfo
makeType typ = SymbolInfo Type typ False Nothing

makeConstant :: DataType -> String -> SymbolInfo
makeConstant typ val = SymbolInfo Variable typ True (Just val)

declareVariable :: String -> DataType -> ScopeStack -> ScopeStack
declareVariable name typ stack = declareSymbol name (makeVariable typ) stack

declareFunction :: String -> DataType -> ScopeStack -> ScopeStack
declareFunction name returnType stack = declareSymbol name (makeFunction returnType) stack

declareType :: String -> DataType -> ScopeStack -> ScopeStack
declareType name typ stack = declareSymbol name (makeType typ) stack

getSymbolType :: String -> ScopeStack -> Maybe DataType
getSymbolType name stack =
    case lookupSymbolScope name stack of
        Just info -> Just (dataType info)
        Nothing -> Nothing

isInteger :: String -> ScopeStack -> Bool
isInteger name stack =
    case getSymbolType name stack of
        Just IntegerType -> True 
        _ -> False