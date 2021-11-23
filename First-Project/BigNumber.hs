import Data.Text.Internal.Read (digitToInt)
import Utils (dropTrailingZeroes, eq, gt, stuffZeroes, xor)

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
    l = map (toInteger . digitToInt) str
    negl = map (toInteger . digitToInt) (tail str)

-- SOMA

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN n1 n2 = somaAux num1 num2
  where
    num1 = (fst n1, reverse (snd n1))
    num2 = (fst n2, reverse (snd n2))

somaAux :: BigNumber -> BigNumber -> BigNumber
somaAux n1 n2
  | not (xor (fst n1) (fst n2)) = positiveSum n1 n2
  | xor (fst n1) (fst n2) = negativeSum n1 n2
  | otherwise = error "Invalid BigNumber"

positiveSum :: BigNumber -> BigNumber -> BigNumber
positiveSum n1 n2
  | fst n1 && fst n2 = (True, reverse (dropTrailingZeroes res))
  | not (fst n1) && not (fst n2) = (False, reverse (dropTrailingZeroes res))
  | otherwise = error "Invalid input"
  where
    res = [mod (x + y + z) 10 | (x, y, z) <- zip3 num1 num2 remainder]
    remainder = 0 : [if n >= 10 then 1 else 0 | n <- zipWith (+) (snd n1) (snd n2)]
    num1 = snd n1 ++ stuffZeroes (snd n1) remainder
    num2 = snd n2 ++ stuffZeroes (snd n2) remainder

-- SUB

subBN :: BigNumber -> BigNumber -> BigNumber
subBN n1 n2 = subBNAux num1 num2
  where
    num1 = (fst n1, reverse (snd n1))
    num2 = (fst n2, reverse (snd n2))

subBNAux :: BigNumber -> BigNumber -> BigNumber
subBNAux n1 n2
  | fst n1 && fst n2 = normalSub n1 n2
  | fst n1 && not (fst n2) = somaAux n1 num2
  | not (fst n1) && fst n2 = (False, snd (somaAux num1 num2))
  | not (fst n1) && not (fst n2) = normalSub num1 num1
  | otherwise = error "Invalid BigNumber"
  where
    num1 = (True, snd n1)
    num2 = (True, snd n2)

negativeSum :: BigNumber -> BigNumber -> BigNumber
negativeSum n1 n2
  | fst n1 = subBN n1 num2
  | fst n2 = subBN n2 num1
  | otherwise = error "Invalid BigNumber"
  where
    num1 = (True, snd n1)
    num2 = (True, snd n2)

normalSub :: BigNumber -> BigNumber -> BigNumber
normalSub n1 n2
  | gt (reverse (snd n1)) (reverse (snd n2)) = (True, normalSubAux (snd n1) (snd n2 ++ stuffZeroes (snd n2) (snd n1)) [] 0)
  | eq (reverse (snd n1)) (reverse (snd n2)) = (True, [0])
  | otherwise = (False, normalSubAux (snd n2) (snd n1 ++ stuffZeroes (snd n1) (snd n2)) [] 0)

normalSubAux :: [Digit] -> [Digit] -> [Digit] -> Digit -> [Digit]
normalSubAux (x : xs) (y : ys) res borrow
  | x - borrow < y = normalSubAux xs ys (((x - borrow) + 10 - y) : res) 1
  | otherwise = normalSubAux xs ys ((x - borrow - y) : res) 0
normalSubAux [] _ res _ = res
normalSubAux _ [] res _ = res

-- create borrow array if num1 is bigger fill with 1, else 0 and then subtract the borrow
