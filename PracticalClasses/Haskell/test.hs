main :: IO ()
main = putStrLn "Hello!"

raizes :: Float -> Float -> Float -> [Float]
raizes a b c
  | delta > 0 = let r = sqrt delta in [(b + r) / (2 * a), (b - r) / (2 * a)]
  | delta == 0 = [- b / (2 * a)]
  | otherwise = []
  where
    delta = b ^ 2 - 4 * a * c

-- 1.2
areaTriangulo :: Floating a => a -> a -> a -> a
areaTriangulo a b c = sqrt (s * (s - a) * (s - b) * (s - c))
  where
    s = (a + b + c) / 2

-- 1.3
metades l = (take halfLen l, drop halfLen l)
  where
    halfLen = div (length l) 2

-- 1.4a
last' :: [a] -> a
last' l = head (reverse l)

last'' :: [a] -> a
last'' l = head (drop (length l -1) l)

--1.4b
init' :: [a] -> [a]
init' l = take (length l - 1) l

init'' :: [a] -> [a]
init'' l = reverse (tail (reverse l))

-- 1.14
curta :: [a] -> Bool
curta l
  | length l <= 2 = True
  | otherwise = False
