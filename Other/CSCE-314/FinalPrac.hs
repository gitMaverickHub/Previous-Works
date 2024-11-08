module FinalPrac where

import Control.Exception

-- 1.1

compReturn :: Fractional a => a -> a -> [a]
compReturn a b = a : compReturn (a*(1+(b/100))) b

-- 1.2

showEvery3 :: Fractional a => [a] -> [(Int,a)]
showEvery3 a = [ (x,a !! x) | x <- [0..], x `mod` 3 == 0 ]

-- 1.3

--------- compReturn' :: Fractional a => a -> a -> [a]

-- 2

ecode :: [Char] -> [Char]
ecode [] = []
ecode (x:(y:ys))
    |x == 'e' = y : ecode ys
    |otherwise = ecode (y:ys)
ecode (x:y)
    |x == 'e' = y
    |otherwise = []

-- 3

-- 4

data Expr = Val Int | Add [Expr] | Mul [Expr]

data MyException = MulExceptionEmptyList | AddExceptionEmptyList
   deriving (Show)

instance Exception MyException

eval :: Expr -> Int
eval (Val i) = i
eval (Add []) = throw AddExceptionEmptyList
eval (Add [x]) = eval x
eval (Add (x:xs)) = eval x + eval (Add xs)
eval (Mul []) = throw MulExceptionEmptyList
eval (Mul [x]) = eval x
eval (Mul (x:xs)) = eval x * eval (Mul xs)

-- 5.1

-- a) myParser :: Parser Int

-- b) [(2,"")]

-- c) [(5,"bye")]

-- d) [(9,"")]

-- e) [(1,"(***[*(**])*)*")]

-- 5.2

--  It matches strings comprising sequences of stars which have [] or () elements within, so long as those are balanced and matched

-- 5.3

--  Count of the number *'s in the matched string

-- 5.4

-- No. Intuition is that it is like a Dyck language (balanced brackets, etc.) but also with *'s interleaved ins

-- 5.5

-- myp = do    vs <- many1 star
--             x <- myp
--             return (x + (length vs))
--             +++ do openBr
--                 c <- myp
--                 closeBr
--                 d <- myp
--                 return (c+d)
--                     +++ do openPr
--                         c <- myp
--                         closePr
--                         d <- myp
--                         return (c+d)
--                         +++
--                             return 0

-- 6 

powSet :: [a] -> [[a]]
powSet [] = [[]]
powSet (x:xs) = p ++ [x:l  | l <- p]
    where p = powSet xs

-- 7

-- 8.1

-- dot :: Parser Char
-- dot = char '.'
-- dash :: Parser Char
-- dash = char '-'
-- morseString = many1 morseLetter
-- morseLetter = mA +++ mB +++ mC

-- mA = do FinalPrac.dot
--         dash
--         return 'A'

-- mB = do dash 
--         FinalPrac.dot
--         FinalPrac.dot
--         FinalPrac.dot
--         return 'B'

-- mC = do dash 
--         FinalPrac.dot
--         dash
--         FinalPrac.dot
--         return 'C'

-- 8.2

-- It become ambigious, so NO. Example: "-..." matches B, and also matches DE

-- 8.3

-- manyEven p = do v <- p
--                 vs <- manyOdd p
--                 return (v:vs)
--               +++
--                 failure

-- manyOdd p = do  v <- p
--                 do 
--                     vs <- manyEven p 
--                     return (v:vs)
--                  +++ 
--                     return [v]

-- 9.1

-- 9.2