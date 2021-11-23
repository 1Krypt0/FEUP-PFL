module Utils where

xor :: Bool -> Bool -> Bool
xor a b = (a && not b) || (not a && b)

gt :: [Integer] -> [Integer] -> Bool
gt [] _ = False
gt _ [] = True
gt (x : xs) (y : ys)
  | length xs > length ys = True
  | length xs < length ys = False
  | x > y = True
  | x == y = gt xs ys
  | otherwise = False

eq :: [Integer] -> [Integer] -> Bool
eq [] [] = True
eq (x : xs) (y : ys)
  | x == y = eq xs ys
  | otherwise = False

dropTrailingZeroes :: [Integer] -> [Integer]
dropTrailingZeroes l = reverse (dropWhile (== 0) (reverse l))

stuffZeroes :: [Integer] -> [Integer] -> [Integer]
stuffZeroes l remainder = replicate (length remainder - length l) 0
