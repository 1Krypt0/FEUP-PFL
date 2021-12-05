-- Exercise 2.1
sumOfSquares = sum [x ^ 2 | x <- [1 .. 100]]

-- Exercise 2.2 a)
aprox :: Int -> Double
aprox n = 4 * sum [fromIntegral ((-1) ^ x) / fromIntegral ((2 * x) + 1) | x <- [0 .. n]]

-- Exercise 2.2 b)
aprox' :: Int -> Double
aprox' n = sqrt (12 * sum [fromIntegral ((-1) ^ x) / fromIntegral ((x + 1) ^ 2) | x <- [0 .. n]])

-- Exercise 2.3
dotprod :: [Float] -> [Float] -> Float
dotprod l1 l2 = sum [a * b | (a, b) <- zip l1 l2]

-- Exercise 2.4
divprop :: Integer -> [Integer]
divprop n = [x | x <- [1 .. n - 1], mod n x == 0]

-- Exercise 2.5
perfeitos :: Integer -> [Integer]
perfeitos n = [x | x <- [1 .. n], sum (divprop x) == x]

-- Exercise 2.6
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [(x, y, z) | x <- [1 .. n], y <- [1 .. n], z <- [1 .. n], x ^ 2 + y ^ 2 == z ^ 2]

-- Exercise 2.7
primo :: Integer -> Bool
primo n
  | divprop n == [1] = True
  | otherwise = False

-- Exercise 2.8

-- Helper function for the exercise
binom :: Integer -> Integer -> Integer
binom n k = div (product [1 .. n]) (product [1 .. k] * product [1 .. (n - k)])

pascal :: Integer -> [Integer]
pascal n = [binom x y | x <- [0 .. n - 1], y <- [0 .. n - 1]]
