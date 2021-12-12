import GHC.Integer (Integer)

-- Exercise 1.1
testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = a < b + c && b < a + c && c < a + b

-- Exercise 1.2
areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt (s * (s - a) * (s - b) * (s - c))
  where
    s = (a + b + c) / 2

-- Exercise 1.3
metades :: [a] -> ([a], [a])
metades l = splitAt halfLen l
  where
    halfLen = div (length l) 2

-- Exercise 1.4 a)
myLast1 :: [a] -> a
myLast1 l = last l

myLast2 :: [a] -> a
myLast2 l = l !! max 0 (length l - 1)

-- Exercise 1.4 b)
myInit1 :: [a] -> [a]
myInit1 l = init l

myInit2 :: [a] -> [a]
myInit2 l = reverse (drop 1 (reverse l))

-- Exercise 1.5
binom :: Integer -> Integer -> Integer
binom n k = div (product [1 .. n]) (product [1 .. k] * product [1 .. (n - k)])

-- Exercise 1.6
raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = ((- b - delta) / denom, (- b + delta) / denom)
  where
    delta = sqrt ((b ** 2) - (4 * a * c))
    denom = 2 * a

-- Exercise 1.10
classifica :: Float -> Float -> String
classifica w h
  | imc < 18.5 = "baixo peso"
  | imc < 25 = "peso normal"
  | imc < 30 = "excesso de peso"
  | otherwise = "obesidade"
  where
    imc = w / (h ** 2)

-- Exercicio 1.11
max3 :: Ord a => a -> a -> a -> a
max3 a b c = max (max a b) c

min3 :: Ord a => a -> a -> a -> a
min3 a b c = min (min a b) c

-- Exercicio 1.12
xor :: Bool -> Bool -> Bool
xor True True = False
xor False False = False
xor _ _ = True

-- Exercicio 1.13
safetail1 :: [a] -> [a]
safetail1 [] = []
safetail1 l = tail l

safetail2 :: [a] -> [a]
safetail2 l
  | null l = []
  | otherwise = tail l

safetail3 :: [a] -> [a]
safetail3 l = if null l then [] else tail l

-- Exercicio 1.14
curta1 :: [a] -> Bool
curta1 [] = True
curta1 [_] = True
curta1 [_, _] = True
curta1 _ = False

curta2 :: [a] -> Bool
curta2 l
  | length l <= 2 = True
  | otherwise = False
