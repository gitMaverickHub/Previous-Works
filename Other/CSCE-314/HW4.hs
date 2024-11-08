-- Maverick Boyle 426005784

module HW4 where

-- Chinese Remainder Theorem

coprime :: Integer -> Integer -> Bool
coprime x 1 = True
coprime x y
    | rem x y == 0 = False
    | otherwise = coprime y (rem x y)

xlist :: Integer -> Integer -> [Integer]
xlist a b = [ (x*b)+a | x <- [0..]]

find1stComNum :: [Integer] -> [Integer] -> Integer --sorted list such as xlist
find1stComNum (x:xs) (y:ys)
    | x > y = find1stComNum (x:xs) ys
    | x < y = find1stComNum xs (y:ys)
    | otherwise = x
find1stComNum x [] = 999999999999999999
find1stComNum [] y = 999999999999999999

crt :: [(Integer, Integer)] -> (Integer, Integer)
crt [] = (0,0)
crt ((a,b):(c,d):xs)
    | coprime b d = crt  ((find1stComNum (xlist a b) (xlist c d),b*d) : xs)
    | otherwise = (999999999999999999,999999999999999999)
crt ((a,b):xs) = (a,b)

-- k-composite Numbers and Anagram Codes

factors :: Integer -> [Integer]
factors n = [x | x <- [1..n], n `mod` x == 0]

kcomposite :: Integer -> [Integer]
kcomposite a = [ x |  x <- [a..], length (factors x) - 2 == fromIntegral a]

sLength :: [Char] -> Integer
--sLength [] = 0                    -- How I originally did it myself before my extension told me to use foldr
--sLength (a:as) = 1 + sLength as
sLength = foldr (\ a -> (+) 1) 0

anagram1stNum :: [Char] -> Integer
--anagram1stNum a = head (tail (factors (find1stComNum (kcomposite 2) [sLength a..])))
-- Just wanted to try it using !! instead of manipulating head tail
anagram1stNum a = factors (find1stComNum (kcomposite 2) [sLength a..]) !! 1

anagram2ndNum :: [Char] -> Integer
anagram2ndNum a = factors (find1stComNum (kcomposite 2) [sLength a..]) !! 2

anagram1stNumList :: [Char] -> [Integer]
anagram1stNumList a = [0..(anagram1stNum a - 1)]

anagram2ndNumList :: [Char] -> [Integer]
anagram2ndNumList a = [0..(anagram2ndNum a - 1)]

anagramEncodeOrder :: [Integer] -> [Integer] -> [Integer]
anagramEncodeOrder x (y:ys) 
    |  y == -1 = []
    | otherwise = map ((y +) . (fromIntegral (length (y:ys)) *)) x ++ anagramEncodeOrder x (ys ++ [-1])

anagramEncode :: [Char] -> [Char]
anagramEncode a
    | sLength a /= anagram1stNum a * anagram2ndNum a = anagramEncode (a ++ "X")
    | otherwise = map ((a !!) . fromIntegral) (anagramEncodeOrder (anagram1stNumList a) (anagram2ndNumList a))

anagramDecodeOrder :: [Integer] -> [Integer] -> [Integer]
anagramDecodeOrder (x:xs) y 
    |  x == -1 = []
    | otherwise = map ((x +) . (fromIntegral (length (x:xs)) *)) y ++ anagramEncodeOrder y (xs ++ [-1])

deleteXs :: [Char] -> [Char]
deleteXs (x:xs)
    | x /= 'X' = x : deleteXs xs
    | otherwise = []
  
anagramDecode :: [Char] -> [Char]
anagramDecode a = deleteXs (map ((a !!) . fromIntegral) (anagramDecodeOrder (anagram1stNumList a) (anagram2ndNumList a)))

--Die Hard 3: Jug Problems

measureWater :: Int -> Int -> Int -> Bool
measureWater a b c
    | (a + b) < c = False
    | otherwise = c `mod` gcd a b == 0