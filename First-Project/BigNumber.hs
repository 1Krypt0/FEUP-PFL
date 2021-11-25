module BigNumber where

import Data.Text.Internal.Read (digitToInt)
import Utils (dropLeadingZeroes, dropTrailingZeroes, eq, gt, stuffZeroes, xor)

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
positiveSum (_, [0]) (_, [0]) = (True, [0])
positiveSum n1 n2
  | fst n1 && fst n2 = (True, reverse (dropTrailingZeroes (positiveSumAux num1 num2 [] 0)))
  | not (fst n1) && not (fst n2) = (False, reverse (dropTrailingZeroes (positiveSumAux num1 num2 [] 0)))
  | otherwise = error "Invalid input"
  where
    len = length largest - length smallest
    num1 = smallest ++ stuffZeroes (fromIntegral len)
    num2 = largest
    smallest = if min (length (snd n1)) (length (snd n2)) == length (snd n1) then snd n1 else snd n2
    largest = if smallest == snd n1 then snd n2 else snd n1

positiveSumAux :: [Digit] -> [Digit] -> [Digit] -> Digit -> [Digit]
positiveSumAux (x : xs) (y : ys) res carry
  | (x + y + carry) >= 10 = positiveSumAux xs ys (res ++ [x + y + carry - 10]) 1
  | otherwise = positiveSumAux xs ys (res ++ [x + y + carry]) 0
positiveSumAux [] [] res 1 = res ++ [1]
positiveSumAux _ [] res _ = res
positiveSumAux [] _ res _ = res

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
  | gt (reverse (snd n1)) (reverse (snd n2)) = (True, dropTrailingZeroes (reverse (normalSubAux num2 num1 [] 0)))
  | eq (reverse (snd n1)) (reverse (snd n2)) = (True, [0])
  | otherwise = (False, dropTrailingZeroes (reverse (normalSubAux num2 num1 [] 0)))
  where
    smallest = if largest == snd n1 then snd n2 else snd n1
    largest = if gt (reverse (snd n1)) (reverse (snd n2)) then snd n1 else snd n2
    len = length largest - length smallest
    num1 = smallest ++ stuffZeroes (fromIntegral len)
    num2 = largest

normalSubAux :: [Digit] -> [Digit] -> [Digit] -> Digit -> [Digit]
normalSubAux (x : xs) (y : ys) res borrow
  | x - borrow < y = normalSubAux xs ys (((x - borrow) + 10 - y) : res) 1
  | otherwise = normalSubAux xs ys ((x - borrow - y) : res) 0
normalSubAux [] _ res _ = res
normalSubAux _ [] res _ = res

-- DIVISION
first :: (a, b, c, d) -> a
first (x, y, z, u) = x

second :: (a, b, c, d) -> b
second (x, y, z, u) = y

divBN :: BigNumber -> BigNumber -> (BigNumber, Bool) --BigNumber)
divBN n1 n2 = res
  where
    res = divBNAux (num1, num2)
    num1 = (fst n1, reverse (snd n1))
    num2 = (fst n2, reverse (snd n2))

divBNAux :: (BigNumber, BigNumber) -> (BigNumber, Bool) --BigNumber)
divBNAux (a, b) = (a, fst (subBNAux a b)) --last (until (\[(w, x), (y, z)] -> not (fst (subBNAux z x))) (\[(w, x), (y, z)] -> [(w, x), (somaAux y (True, [1]), subBNAux z x)]) [(a, b), ((True, [0]), a)])

greaterThan :: BigNumber -> BigNumber -> Bool
greaterThan (True, _) (False, _) = True
greaterThan (False, _) (True, _) = False
greaterThan x y = gt (snd x) (snd y)

equal :: BigNumber -> BigNumber -> Bool
equal a b = (fst a == fst b) && (snd a == snd b)
