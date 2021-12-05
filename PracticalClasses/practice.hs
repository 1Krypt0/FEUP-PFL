import Distribution.Simple.UserHooks (UserHooks (postBuild))

half :: Fractional a => a -> a
half x = x / 2

xor :: Bool -> Bool -> Bool
xor a b = (a && not b) || (b && not a)

cbrt :: Floating a => a -> a
cbrt x = x ** (1 / 3)

heron :: Floating a => a -> a -> a -> a
heron a b c = sqrt (s * (s - a) * (s - b) * (s - c))
  where
    s = (a + b + c) / 2

{- What in the world is wrong with my brain. I can't figure this out -}
isTriangular :: (Ord a, Num a) => a -> a -> a -> Bool
isTriangular a b c = (a + b <= c) && (a + c <= b) && (b + c <= a)

isPythagorean :: (Num a, Eq a) => a -> a -> a -> Bool
isPythagorean a b c = (a ^ 2 + b ^ 2 == c ^ 2) || (b ^ 2 + c ^ 2 == a ^ 2) || (c ^ 2 + a ^ 2 == b ^ 2)

max3 :: Ord a => a -> a -> a -> a
max3 a b c
  | a >= b && a >= c = a
  | b >= c = b
  | otherwise = c

factorial :: (Num p, Eq p, Ord p) => p -> p
factorial 0 = 1
factorial n
  | n > 0 = n * factorial (n - 1)
  | otherwise = error "Invalid Arguments"

myGcd :: Integral a => a -> a -> a
myGcd a b = myGcdAux (max posA posB) (min posA posB)
  where
    posA = abs a
    posB = abs b

myGcdAux :: Integral a => a -> a -> a
myGcdAux a b
  | b == 0 = abs a
  | abs b > 0 = myGcdAux b (mod a b)
  | otherwise = error "Invalid Arguments"

{- This function computes the nth power of m, recursively -}
mPower :: (Ord t, Num t, Fractional a) => a -> t -> a
mPower a b
  | b == 0 = 1
  | b > 0 = a * mPower a (b - 1)
  | otherwise = 1 / mPower a (- b)

mySwap :: (a, b) -> (b, a)
mySwap (a, b) = (b, a)

distanceInf :: (Floating a, Ord a) => (a, a) -> (a, a) -> a
distanceInf (x1, y1) (x2, y2) = max (abs (x1 - x2)) (abs (y1 - y2))

myMinimumAux [] m = m
myMinimumAux (x : xs) m
  | x < m = myMinimumAux xs x
  | otherwise = myMinimumAux xs m

myMinimum :: Ord p => [p] -> p
myMinimum (x : xs) = myMinimumAux xs x
myMinimum [] = error "Empty list!"

myAnd :: [Bool] -> Bool
myAnd (x : xs) = x && myAnd xs

myOr :: [Bool] -> Bool
myOr (x : xs) = x || myOr xs
