-- Maverick Boyle 428005784

module HW3 where

-- Basic Haskell Drills

myReverse :: [Int] -> [Int]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

isElement :: Eq a => a -> [a] -> Bool
isElement a [] = False
isElement a (x:xs)
    | a == x = True
    | otherwise = isElement a xs

duplicate :: [Int] -> [Int]
duplicate [] = []
duplicate (x:xs) = x : x : duplicate xs

removeDuplicate :: Eq a => [a] -> [a]
removeDuplicate [] = []
removeDuplicate (x1:x2:xs)
    | x1 == x2 = removeDuplicate (x2:xs)
    | otherwise = x1 : removeDuplicate (x2:xs)
removeDuplicate (x:xs) = x : removeDuplicate xs

rotate :: [Int] -> Int -> [Int]
rotate [] _ = []
rotate xs 0 = xs
rotate (x:xs) n
    | n > 0 = rotate (xs ++ [x]) (n-1)
    | n < 0 = rotate (x:xs) (length (x:xs) + n)

flatten :: [[Int]] -> [Int]
-- This is what I originally put myself but my extension slowly told me to rewrite
-- it with concat.
-- flatten [] = []
-- flatten (x:xs) = x ++ flatten xs
flatten = concat

isPalindrome :: Eq a => [a] -> Bool
isPalindrome [] = True
isPalindrome [x] = True
isPalindrome xs
    | head xs /= last xs = False
    | otherwise = isPalindrome(tail (init xs))

coprime :: Int -> Int -> Bool
coprime x 1 = True
coprime x y
    | rem x y == 0 = False
    | otherwise = coprime y (rem x y)

-- Aaah!

seeDoctor :: String -> String -> Bool

seeDoctor [] (b:bs)
    | null bs = True
    | b /= 'a' = False
    | otherwise = seeDoctor [] bs
seeDoctor (a:as) (b:bs)
    | (a:as) < (b:bs) = False
    | null as = seeDoctor [] (b:bs)
    | last as /= 'h' || last bs /= 'h' || a /= 'a' || b /= 'a' = False
    | otherwise = seeDoctor as bs

-- Water Gates

-- Made a factors function to help define waterGate
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

waterGate :: Int -> Int
waterGate 0 = 0
waterGate 1 = 1
waterGate n
    | odd (length (factors n)) = waterGate (n-1) + 1
    | otherwise = waterGate (n-1)

-- Goldbach's other conjecture

-- Made an isPrime function to help define goldbachNum
isPrime :: Int -> Bool
isPrime n
    | length (factors n) > 2 = False
    | otherwise = True

-- Made an isOddComposite function to help define goldbachNum
isOddComposite :: Int -> Bool
isOddComposite n
    | odd n && not (isPrime n) = True
    | otherwise = False

-- Made a primeList function to help define goldbachNum
primeList :: Int -> [Int]
primeList n = [x | x <- [1..n], isPrime x]

-- Made an oddCompositeList function to help define goldbachNum
oddCompositeList :: [Int]
oddCompositeList = [x | x <- [1..], isOddComposite x]

-- Made an isSquare function to help define goldbachNum
isSquare :: Int -> Bool
isSquare n
    | floor (sqrt (fromIntegral n)) ^ 2 == n = True
    | otherwise = False

-- Made an isGoldbach function to help define goldbachNum
isGoldbach :: Int -> [Int] -> Bool
isGoldbach c [] = False
isGoldbach c (p:ps) 
    | isSquare ((c - p) `div` 2) = True
    | otherwise = isGoldbach c ps

goldbachNum :: Int
goldbachNum = head [x | x <- oddCompositeList, not (isGoldbach x (primeList x))]