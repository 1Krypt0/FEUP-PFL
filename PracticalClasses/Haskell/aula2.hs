{- Aula 2: Lists and other stuff -}

-- Ex 1
myConcat :: [[a]] -> [a]
myConcat l = [x | xs <- l, x <- xs]

-- Ex 1 (another version)
myConcat' :: [[a]] -> [a]
myConcat' [] = []
myConcat' (x : xs) = x ++ myConcat xs

-- Ex 2
myReplicate :: Integral a => a -> b -> [b]
myReplicate 0 _ = []
myReplicate n x
  | n > 0 = x : myReplicate (n - 1) x
  | n < 0 = error "Argument out of bounds"

-- Ex 3
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x : xs) = myReverse xs ++ [x]

-- Ex 3 (another version)
myReverse' :: [a] -> [a]
myReverse' l = myRevAux l []

myRevAux :: [a] -> [a] -> [a]
myRevAux [] acc = acc
myRevAux (x : xs) acc = myRevAux xs (x : acc)

{- Exercises that I need to solve myself -}

-- Ex 2.1
sumOfSquares :: Integral a => a
sumOfSquares = sum [x ^ 2 | x <- [1 .. 100]]

-- Ex 2.3
dotprod :: [Float] -> [Float] -> Float
dotprod l1 l2 = sum [x * y | (x, y) <- zip l1 l2]

-- Ex 2.6
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = concat [[(x, y, z), (y, x, z)] | x <- [1 .. n], y <- [1 .. x], let z = (floor . sqrt . fromInteger) (x ^ 2 + y ^ 2), z <= n, x ^ 2 + y ^ 2 == z ^ 2]
