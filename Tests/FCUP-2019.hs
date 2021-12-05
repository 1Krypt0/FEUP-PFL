{-

This is my resolution of FCUP's 2019 Haskell test. If there is a better answer
to any question, please do let me know.

-}

{-

1 - Answer the following questions, showing only the result of each expression

a) [[1, 2]] ++ [[]] ++ [[3,4], [5]] -> [[1, 2], [3, 4], [5]]

b) ([1, 2] : [] : [3,4] : [[5]]) !! 3 -> [[1, 2], [], [3,4] , [5]] !! 3 -> [5]

c) length ([] : [] : []) -> 2

d) drop 4 [0, 4 .. 32] -> [16, 20, 24, 28, 32]

e) [(x + y, x * y) | x <- [1..4], y [x+1 .. 4]] -> [(3, 2), (4, 3), (5, 4), (5, 6), (6, 8), (7, 12)]

f) [[y | y <- ys, y 'mod' 2 == 0] | ys <- [[3, 5, 2, 8], [4, 6, 7, 1, 3], [9, 5, 11]]] -> [[2, 8], [4, 6], []]

g) [(x, 6 - x) |  x <- [0..6]]

h) h [1, 3, 1, 5, 0, 4] -> 15

i) :type [('1', "a"), ('2', "b")] -> [(Char, [Char])]

j) :type f x xs = sum xs < x -> (Num a, Ord a) => a -> [a] -> Bool

k) :type ig -> Eq a => [a] -> Bool

l) :type fix -> (Eq a) => (a -> a) -> a -> Bool

-}

{-

2 - Define the following functions

a) A function pitagoricos, that given 3 integers, determines if they are or not
   a pitagoric triad.

b) A function hipotenusa, that given the measurements of the two smaller sides
   of the triangle, determines the hypotenuse.

-}

-- 2 a)
pitagoricos :: Integer -> Integer -> Integer -> Bool
pitagoricos a b c = (a ^ 2 + b ^ 2 == c ^ 2) || (a ^ 2 + c ^ 2 == b ^ 2) || (c ^ 2 + b ^ 2 == a ^ 2)

-- 2 b)
hipotenusa :: Float -> Float -> Float
hipotenusa a b = sqrt (a ^ 2 + b ^ 2)

{-

3 - Define a function that returns all values in a list that are different from
    the next value of a list that are different from the next value.

a) Define the function recursively

b) Define the function using list comprehensions

-}

-- 3 a)
diferentes :: (Eq a) => [a] -> [a]
diferentes l = diferentesAux l []

diferentesAux :: (Eq a) => [a] -> [a] -> [a]
diferentesAux [] res = res
diferentesAux (x : y : xs) res
  | x /= y = diferentesAux (y : xs) res ++ [x]
  | otherwise = diferentesAux (y : xs) res
diferentesAux _ res = res

-- 3 b)
diferentes2 :: (Eq a) => [a] -> [a]
diferentes2 l = [x | (x, y) <- zip l (tail l), x /= y]

{-

4 - Define the zip3 function using comprehension lists and the zip function

-}

myZip3 :: [a] -> [b] -> [c] -> [(a, b, c)]
myZip3 l1 l2 l3 = [(x, y, z) | ((x, y), z) <- zip laux l3]
  where
    laux = [(x, y) | (x, y) <- zip l1 l2]

{-

TODO: Improve this
5 - Define a function

-}

partir :: (Eq a) => a -> [a] -> ([a], [a])
partir x = partirAux x []

partirAux :: (Eq a) => a -> [a] -> [a] -> ([a], [a])
partirAux x l1 [] = (l1, [])
partirAux x l1 l2
  | head l2 == x = (l1, l2)
  | otherwise = partirAux x (l1 ++ [head l2]) (tail l2)
