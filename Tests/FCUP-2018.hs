{-

This is my resolution of FCUP's 2018 Haskell test. If there is a better answer
to any question, please do let me know.

-}

{-

1 - Answer the following questions, showing only the result of each expression

a) [[1, 2, 3]] ++ [] ++ [[4], [5]] -> [[1, 2, 3], [4], [5]]

b) length ([1] : [2] : [] : [3] : [4] : []) -> 5

c) take 7 [8, 6 .. 0] -> [8, 6, 4, 2, 0]

d) fst ([(1, 2), (3, 4), (5, 6), (9, 7), (8,13)] !! 3) -> 9

e) [(y, x) | x <- [1..5], y <- [1..3], (x + y) 'mod' 3 == 0] -> [(2, 1), (1, 2), (3, 3), (2, 4), (1, 5)]

f) [2^x | x <- [1..5], y <- [1..3], (x+y) 'mod' 3 == 0] ->

g) n = 1 : [(2 * (n !! (x - 1))) + 1 | x <- [1..9]]]

h) 15

i) :type ([False, True], ['1', '2']) -> ([Bool], [Char])

j) :type p --> a -> b -> (a , b)

k) :type h --> (Eq a) => [a] -> [a] -> [a]

l) :type feql --> (Eq a) => [a] -> Bool

-}

{-

2 - Define the respective functions

a) A function distancia, that given two points calculates the distance between
   them

b) A function colineares, that determines if 3 points are "colineares" (don't
   know the translation)

-}

-- 2 a)
distancia :: (Float, Float) -> (Float, Float) -> Float
distancia (x1, y1) (x2, y2) = sqrt ((x2 - x1) ^ 2 + (y2 - y1) ^ 2)

-- 2 b)
colineares :: (Float, Float) -> (Float, Float) -> (Float, Float) -> Bool
colineares (x1, y1) (x2, y2) (x3, y3) = ((y1 - y2) / (x1 - x2)) == ((y2 - y3) / (x2 - x3))

{-

3 - Consider the function niguais, that returns a list with n copies of element
    x

a) Define the function recursively

b) Define the function using comprehension lists

-}

niguais :: Integer -> a -> [a]
niguais 0 x = []
niguais n x = x : niguais (n -1) x

niguais2 :: Integer -> a -> [a]
niguais2 n x = [x | y <- [1 .. n]]

{-

4 - Write a recursive function that joins two ordered lists into one, keeping
    them ordered

-}

merge :: (Ord a) => [a] -> [a] -> [a]
merge l [] = l
merge [] l = l
merge (x : xs) (y : ys)
  | x < y = x : merge xs (y : ys)
  | otherwise = y : merge (x : xs) ys

{-

5 - Define the function length_zip that given a list, returns a list of pairs
    such that the first element is the index at which the element appears,
    and the second one is the element itself

-}

lengthZip :: [a] -> [(Int, a)]
lengthZip xs = reverse [(x, y) | (x, y) <- zip [1 .. length xs] (reverse xs)]

{-

6 - Change making problem (pls not again pls)

-}
