module Test2 where

-- Question 1

compoundInterest :: Fractional a => a -> a -> [a]
compoundInterest a b = a : compoundInterest (a*(1+(b/100))) b

-- Question 2

data Hand = Rock | Paper | Scissors
    deriving (Show, Eq, Read)

rps :: Hand -> Hand -> Int -- guards
rps a b
    | a == b = 0
    | a == Rock && b == Scissors = 1
    | a == Paper && b == Rock = 1
    | a == Scissors && b == Paper = 1
    | otherwise = 2

rps2 :: Hand -> Hand -> Int -- pattern matching
rps2 Rock Rock = 0
rps2 Rock Paper = 2
rps2 Rock Scissors = 1
rps2 Paper Rock = 1
rps2 Paper Paper = 0
rps2 Paper Scissors = 2
rps2 Scissors Rock = 2
rps2 Scissors Paper = 1
rps2 Scissors Scissors = 0

rps3 :: Hand -> Hand -> Int -- if
rps3 a b =
    if a == b then 0
    else if a == Rock && b == Scissors then 1
    else if a == Paper && b == Rock then 1
    else if a == Scissors && b == Paper then 1
    else 2

-- Question 3

prodTup :: Fractional a => (a, a) -> a
prodTup (a,b) = a * b

weightAvg :: Fractional a => [a] -> [a] -> a
weightAvg a b = sum (map prodTup (zip a b)) / sum a

-- Question 4

rle :: Eq a => [a] -> [(a,Int)]
rle = foldr code []
      where code c []         = [(c,1)]
            code c ((x,n):ts) | c == x    = (x,n+1):ts
                              | otherwise = (c,1):(x,n):ts

--listOfLists :: Eq a -> [[a]]
--listOfLists x:xs = 

-- Question 5

-- palindrome :: Eq a => [a] -> Bool

-- fls :: [[a] -> [a]]

-- tripler :: (t -> t) -> t -> t

-- Question 6

-- it returns ["thisissentence"]

-- makes a list of lists with the length of the list of lists being x and each list is a double of the input list

-- functionr 5 [1,2,3,4,5] returns [[1,2,3,4,5,1,2,3,4,5],[1,2,3,4,5,1,2,3,4,5],[1,2,3,4,5,1,2,3,4,5],[1,2,3,4,5,1,2,3,4,5],[1,2,3,4,5,1,2,3,4,5]]

-- functionr 2 [2,4,3,1] returns [[2,4,3,1,2,4,3,1],[2,4,3,1,2,4,3,1]]

-- 2nd line of each not in scope

-- make a second base case for false such as isOdd 0 = False and isEven 1 = False

-- make the function recursive in its scope such as isOdd n = n - 2 and isEven n = n - 2