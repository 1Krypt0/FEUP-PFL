{-

This is my resolution of FCUP's 2012 Haskell test. If there is a better answer,
   please do let me know.
-}

{-

1 - Indicate the result of each expression.

a) head (tail [1, 2, 3]) -> 2

b) (reverse [3, 2]) ++ [4, 5] -> [2, 3, 4, 5]

c) length ([1, 2] : [3, 4] : []) -> 2

d) length [1, 3 .. 7] -> 4

e) sum [x^2 | x <- [-1, 0, 1]]

f) length (drop 6 "abcdefg123")

g) :type [(1, "a"), (3, "bc"), (5, "de")] -> [(Num, [Char])]

h) :type length -> Foldable t => t a -> Int

i) :type take -> Int -> [a] -> [a]

j) :type filter -> (a -> Bool) -> [a] -> [a]

-}

{-

2 - Write a definition of a function perfeito:: Int -> Bool that verifies if a
    given integer is perfect.

-}

divisores :: Int -> [Int]
divisores n = [x | x <- [1 .. n - 1], mod n x == 0]

perfeito :: Int -> Bool
perfeito n = n == sum (divisores n)

{-

3 - Write a recurive definition of the rle :: String -> [(Int, Char)] function,
    which compresses a chain using "run-length encoding"

-}

--TODO: Write a functional version of this program
rle :: String -> [(Int, Char)]
rle str = rleAux str []

rleAux :: String -> [(Int, Char)] -> [(Int, Char)]
rleAux [] res = res
rleAux (x : xs) [] = rleAux xs [(1, 'a'), (2, 'b')]
rleAux (x : xs) res
  | x == snd current = rleAux xs (reverse ((fst current + 1, snd current) : tail (reverse res)))
  | otherwise = [last res] --rleAux xs res ++ [(1, x)]
  where
    current = last res
