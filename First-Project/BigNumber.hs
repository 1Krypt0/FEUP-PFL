import Data.Text.Internal.Read (digitToInt)
import Utils (dropTrailingZeroes, gt, stuffZeroes, xor)

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

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN n1 n2
  | not (xor (fst n1) (fst n2)) = positiveSum n1 n2
  | xor (fst n1) (fst n2) = negativeSum n1 n2
  | otherwise = error "Invalid BigNumber"

subBN :: BigNumber -> BigNumber -> BigNumber
subBN n1 n2
  | fst n1 && fst n2 = normalSub n1 n2
  | fst n1 && not (fst n2) = somaBN n1 num2
  | not (fst n1) && fst n2 = (False, snd (somaBN num1 num2))
  | not (fst n1) && not (fst n2) = normalSub n2 num1
  | otherwise = error "Invalid BigNumber"
  where
    num1 = (True, snd n1)
    num2 = (True, snd n2)

positiveSum :: BigNumber -> BigNumber -> BigNumber
positiveSum n1 n2
  | fst n1 && fst n2 = (True, dropTrailingZeroes res)
  | not (fst n1) && not (fst n2) = (False, dropTrailingZeroes res)
  | otherwise = error "Invalid input"
  where
    res = [mod (x + y + z) 10 | (x, y, z) <- zip3 num1 num2 remainder]
    remainder = 0 : [if n >= 10 then 1 else 0 | n <- zipWith (+) (snd n1) (snd n2)]
    num1 = snd n1 ++ stuffZeroes (snd n1) remainder
    num2 = snd n2 ++ stuffZeroes (snd n2) remainder

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
  | gt (snd n1) (snd n2) = (True, normalSubAux (snd n1) (stuffZeroes (snd n2) (snd n1)) [] 0)
  | otherwise = (False, normalSubAux (snd n2) (stuffZeroes (snd n1) (snd n2)) [] 0)

normalSubAux :: [Digit] -> [Digit] -> [Digit] -> Digit -> [Digit]
normalSubAux (x : xs) (y : ys) res borrow
  | (x - borrow) < y = normalSubAux xs ys ((((x - borrow) + 10) - y) : res) 1
  | otherwise = normalSubAux xs ys (((x - borrow) - y) : res) 0
normalSubAux [] _ res _ = res
normalSubAux _ [] res _ = res

{-
  where
    res = [mod (x - (y + z)) 10 | (x, y, z) <- zip3 n1 num2 borrow]
    num2 = n2 ++ stuffZeroes n2 n1
    borrow = 0 : [if n < 0 then 1 else 0 | n <- zipWith (-) n1 num2]
-}

{- fazer sub
verificar se < 0
se sim, subtrair 1 ao proximo elemento de n1
adicionar 10 ao resultado de sub
next
-}
-- create borrow array if num1 is bigger fill with 1, else 0 and then subtract the borrow
