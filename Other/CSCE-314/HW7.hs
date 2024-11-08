-- Maverick Boyle, 426005785, Assignment 7, CSCE-314

module HW7 where

import Prelude hiding (lookup)

import Test.HUnit
import System.Exit

-- AST definition for W
data WValue = VInt Int 
            | VBool Bool 
              deriving (Eq, Show)

data WExp = Val WValue

          | Var String

          | Plus WExp WExp
          | Minus WExp WExp
          | Multiplies WExp WExp
          | Divides WExp WExp

          | Equals WExp WExp
          | NotEqual WExp WExp
          | Less WExp WExp
          | Greater WExp WExp
          | LessOrEqual WExp WExp
          | GreaterOrEqual WExp WExp

          | And WExp WExp
          | Or WExp WExp
          | Not WExp

data WStmt = Empty
           | VarDecl String WExp
           | Assign String WExp
           | If WExp WStmt WStmt
           | While WExp WStmt
           | Block [WStmt]

type Memory = [(String, WValue)]
marker = ("|", undefined)
isMarker (x, _) = x == "|"

-- eval function
eval :: WExp -> Memory -> WValue
eval (Val x) [] = x
-- eval (Var x) [] = x
eval (Plus (Val (VInt x)) (Val (VInt y))) [] = VInt (x + y)
eval (Minus (Val (VInt x)) (Val (VInt y))) [] = VInt (x - y)
eval (Multiplies (Val (VInt x)) (Val (VInt y))) [] = VInt (x * y)
eval (Divides (Val (VInt x)) (Val (VInt y))) [] = VInt (x `div` y)
eval (Equals (Val (VInt x)) (Val (VInt y))) [] = VBool (x == y)
eval (NotEqual (Val (VInt x)) (Val (VInt y))) [] = VBool (x /= y)
eval (Less (Val (VInt x)) (Val (VInt y))) [] = VBool (x < y)
eval (Greater (Val (VInt x)) (Val (VInt y))) [] = VBool (x > y)
eval (LessOrEqual (Val (VInt x)) (Val (VInt y))) [] = VBool (x <= y)
eval (GreaterOrEqual (Val (VInt x)) (Val (VInt y))) [] = VBool (x >= y)
eval (And (Val (VBool x)) (Val (VBool y))) [] = VBool (x && y)
eval (Or (Val (VBool x)) (Val (VBool y))) [] = VBool (x || y)
eval (Not (Val (VBool x))) [] = VBool (not x)

-- exec function
exec :: WStmt -> Memory -> Memory
exec Empty [] = []
exec (VarDecl x (Var y)) [] = []
exec (Assign x (Var y)) [] = []
-- exec If = 
-- exec While = 
-- exec Block = 

-- fib function
fib = 
  Block
  [
    VarDecl "a" (Val (VInt 0)),
    VarDecl "b" (Val (VInt 1)),
    VarDecl "temp" (Val (VInt 0)),
    While (Greater (Var "x") (Val (VInt 2)))
    (
      Block
      [
        Assign "temp" (Plus (Var "a") (Var "b")),
        Assign "a" (Var "b"),
        Assign "b" (Var "temp"),
        Assign "x" (Minus (Var "x") (Val (VInt 1)))  
      ]
      ),
    Assign "result" (Var "b")
  ]

-- example programs
factorial = 
  Block
  [
    VarDecl "acc" (Val (VInt 1)),
    While (Greater (Var "x") (Val (VInt 1)))
    (
      Block
      [
        Assign "acc" (Multiplies (Var "acc") (Var "x")),
        Assign "x" (Minus (Var "x") (Val (VInt 1)))         
      ]
    ),
    Assign "result" (Var "acc")
  ]

p1 = Block
     [
       VarDecl "x" (Val (VInt 0)),
       VarDecl "b" (Greater (Var "x") (Val (VInt 0))),
       If (Or (Var "b") (Not (GreaterOrEqual (Var "x") (Val (VInt 0)))))
         ( Block [ Assign "x" (Val (VInt 1)) ] )
         ( Block [ Assign "x" (Val (VInt 2)) ] )
     ]

-- some useful helper functions
lookup s [] = Nothing
lookup s ((k,v):xs) | s == k = Just v
                    | otherwise = lookup s xs

asInt (VInt v) = v
asInt x = error $ "Expected a number, got " ++ show x

asBool (VBool v) = v
asBool x = error $ "Expected a boolean, got " ++ show x

fromJust (Just v) = v
fromJust Nothing = error "Expected a value in Maybe, but got Nothing"

-- unit tests
myTestList =

  TestList [
    test $ assertEqual "p1 test" [] (exec p1 []),

    let res = lookup "result" (exec factorial [("result", undefined), ("x", VInt 10)])
    in test $ assertBool "factorial of 10" (3628800 == asInt (fromJust res))
    ]    

-- main: run the unit tests  
main = do c <- runTestTT myTestList
          putStrLn $ show c
          let errs = errors c
              fails = failures c
          if (errs + fails /= 0) then exitFailure else return ()