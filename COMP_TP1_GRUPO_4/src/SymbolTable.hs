module SymbolTable where

import Data.Map (Map)
import qualified Data.Map as Map

data Type = IntType | StringType | BoolType | UnknownType
    deriving (Show, Eq)

data Symbol = Symbol 
    { symName :: String
    , symType :: Type
    , symOffset :: Int
    } deriving (Show)

type SymbolTable = Map String Symbol

data Scope = Scope 
    { scopeSymbols :: SymbolTable
    , scopeParent :: Maybe Scope
    , nextOffset :: Int
    }

newScope :: Maybe Scope -> Scope
newScope parent = Scope Map.empty parent 0

insertSymbol :: String -> Type -> Scope -> Scope
insertSymbol name typ scope = 
    let sym = Symbol name typ (nextOffset scope)
        newSymbols = Map.insert name sym (scopeSymbols scope)
    in scope { scopeSymbols = newSymbols, nextOffset = nextOffset scope + 4 }

lookupSymbol :: String -> Scope -> Maybe Symbol
lookupSymbol name scope = 
    case Map.lookup name (scopeSymbols scope) of
        Just sym -> Just sym
        Nothing -> case scopeParent scope of
            Just parent -> lookupSymbol name parent
            Nothing -> Nothing