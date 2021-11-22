module Utils where

xor :: Bool -> Bool -> Bool
xor a b = (a && not b) || (not a && b)

gt :: [Integer] -> [Integer] -> Bool
gt [] [] = False
gt _ [] = True
gt [] _ = False
gt (x : xs) (y : ys)
  | x > y = True
  | x == y = gt xs ys
  | otherwise = False

dropTrailingZeroes :: [Integer] -> [Integer]
dropTrailingZeroes l = reverse (dropWhile (== 0) (reverse l))

stuffZeroes :: [Integer] -> [Integer] -> [Integer]
stuffZeroes l remainder = replicate (length remainder - length l) 0
