module Utils where

xor :: Bool -> Bool -> Bool
xor a b = (a && not b) || (not a && b)

-- Helper function to determine the greatest of two BigNumbers as they are
-- If used in auxiliary functions, be sure to reverse the list first
gt :: (Bool, [Integer]) -> (Bool, [Integer]) -> Bool
gt (False, _) (True, _) = False
gt (True, _) (False, _) = True
gt (True, []) (True, []) = False
gt (False, []) (False, []) = False
gt (True, x : xs) (True, y : ys)
  | length xs > length ys = True
  | length xs < length ys = False
  | x > y = True
  | x < y = False
  | otherwise = gt (True, xs) (True, ys)
gt (False, x : xs) (False, y : ys) = not (gt (True, x : xs) (True, y : ys))
gt _ _ = False

eq :: (Bool, [Integer]) -> (Bool, [Integer]) -> Bool
eq (_, [0]) (_, [0]) = True
eq (True, _) (False, _) = False
eq (False, _) (True, _) = False
eq n1 n2 = snd n1 == snd n2

stuffZeroes :: Integer -> [Integer]
stuffZeroes len = replicate (fromIntegral len) 0

third :: (a, b, c, d) -> c
third (a, b, c, d) = c

fourth :: (a, b, c, d) -> d
fourth (a, b, c, d) = d

second :: (a, b, c) -> b
second (a, b, c) = b
