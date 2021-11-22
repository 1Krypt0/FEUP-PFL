import Data.Text.Internal.Read (digitToInt)

type Digit = Integer

{- Bool was added to check for the sign of the number -}
type BigNumber = (Bool, [Digit])

output :: BigNumber -> String
output num
  | fst num = concatMap show (snd num)
  | otherwise = '-' : concatMap show (snd num)

scanner :: String -> BigNumber
scanner str
  | head str == '-' = (False, negl)
  | otherwise = (True, l)
  where
    l = reverse (map (toInteger . digitToInt) str)
    negl = reverse (map (toInteger . digitToInt) (tail str))

xor :: Bool -> Bool -> Bool
xor a b = (a && not b) || (not a && b)

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN n1 n2
  | not (xor (fst n1) (fst n2)) = positiveSum n1 n2
  | xor (fst n1) (fst n2) = negativeSum n1 n2
  | otherwise = error "Invalid BigNumber"

negativeSum :: BigNumber -> BigNumber -> BigNumber
negativeSum n1 n2
  | fst n1 = subBN n1 n2
  | fst n2 = subBN n2 n1
  | otherwise = error "Invalid BigNumber"

subBN :: BigNumber -> BigNumber -> BigNumber
subBN n1 n2
  | fst n1 && not (fst n2) = somaBN n1 num2
  | otherwise = error "Fodeu"
  where
    num2 = (True, snd n2)

dropTrailingZeroes :: [Digit] -> [Digit]
dropTrailingZeroes l = reverse (dropWhile (== 0) (reverse l))

stuffZeroes :: [Digit] -> [Digit] -> [Digit]
stuffZeroes l remainder = replicate (length remainder - length l) 0

positiveSum :: BigNumber -> BigNumber -> BigNumber
positiveSum n1 n2
  | fst n1 && fst n2 = (True, dropTrailingZeroes res)
  | not (fst n1) && not (fst n2) = (False, dropTrailingZeroes res)
  | otherwise = error "Invalid input, somehow"
  where
    res = [mod (x + y + z) 10 | (x, y, z) <- zip3 num1 num2 remainder]
    remainder = 0 : [if n >= 10 then 1 else 0 | n <- zipWith (+) (snd n1) (snd n2)]
    num1 = snd n1 ++ stuffZeroes (snd n1) remainder
    num2 = snd n2 ++ stuffZeroes (snd n2) remainder
