{-

This is my resolution of FCUP's 2018 Haskell test. If there is a better answer
to any question, please do let me know.

-}

{-

1 - Answer the following questions, showing only the result of each expression

a) 1 : (5 : (4 : (3 : []))) -> [1, 5, 4, 3]

b) tail [4, 5, 6, 9] -> [5, 6, 9]

c) head ([2, 3] ++ [1, 4] ++ [4, 6]) -> [2, 3]

d) drop 5 [0, 3 .. 30] -> [15, 18, 21, 24, 27, 30]

e) length ([1, 2] : [] : [3, 4] : [[5]]) -> 4

f) [x * y | x <- [1..3], y <- [x .. 3]] -> [1, 2, 3, 4, 6, 9]

g) [x | x <- [1..3], y <- [1..3], (x + y) == 4] -> [1, 2, 3]

h) [((-1)^n) * n | n <- [0 .. 10]]

i) h [0..7] -> 8

j) :type (['1', '2', '3'], [1.0, 2.0, 3.0]) -> ([Char], [Float])

k) :type fst --> (a, b) -> a

l) :type h --> (Ord a, Eq a) => a -> a -> a -> Bool

m) :type f --> [a] -> a

-}

{-

2 - Write a function numEqual that gives the amount of numbers that are equal
    among them.

-}

numEqual :: Integer -> Integer -> Integer -> Integer
numEqual n m p
  | n == m && m == p = 3
  | n == m && m /= p = 2
  | n == p && p /= m = 2
  | p == m && m /= n = 2
  | otherwise = 0

{-

3 - Write a function that calculates the area of a quadrilateral.

-}

area :: Float -> Float -> Float -> Float -> Float -> Float -> Float
area a b c d p q = sqrt (4 * p ^ 2 * q ^ 2 - (b ^ 2 + d ^ 2 - a ^ 2 - c ^ 2) ^ 2) / 4

{-

4 - Define a recursive function that returns the biggest prefix of a list
    such that all ements inside it are even.

-}

enquantoPar :: [Integer] -> [Integer]
enquantoPar [] = []
enquantoPar (x : xs)
  | even x = x : enquantoPar xs
  | otherwise = []

{-

5 - Define the function nat_zip that, given a list, indicates the index
    where that element arises, and the element itself

-}

natZip :: [a] -> [(Int, a)]
natZip l = [(x, y) | (x, y) <- zip [1 .. length l] l]

{-

6 - Implement a list of the function squares that, given a list of integers,
    determines another list that has the squares of the elements of xs

-}

quadrados :: [Integer] -> [Integer]
quadrados [] = []
quadrados (x : xs) = x ^ 2 : quadrados xs

quadrados2 :: [Integer] -> [Integer]
quadrados2 l = [x ^ 2 | x <- l]
