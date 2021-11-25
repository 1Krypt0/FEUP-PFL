module BigNumber where

import Data.Char (digitToInt)
import Utils (eq, gt, stuffZeroes, xor)

type BigNumber = (Bool, [Digit])

type Digit = Integer

-- Converts a given string into BigNumber format
scanner :: String -> BigNumber
scanner str
  | head str == '-' = (False, negNum)
  | otherwise = (True, posNum)
  where
    negNum = map (toInteger . digitToInt) (tail str)
    posNum = map (toInteger . digitToInt) str

-- Converts a BigNumber back into a string
output :: BigNumber -> String
output num
  | fst num = concatMap show (snd num)
  | otherwise = '-' : concatMap show (snd num)

-- Function responsible for setting up the BigNumbers to the proper format for adittion.
-- They will enter as represented but will be sent to the auxiliary function reversed,
-- as a way to make calculations easy. If other functions neeed to sum numbers, the somaBNAux should be called instead
somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN n1 n2 = somaBNAux num1 num2
  where
    num1 = (fst n1, reverse (snd n1))
    num2 = (fst n2, reverse (snd n2))

-- Defines which type of sum will be needed, based on the sign of the values. Other functions needing to add
-- numbers should call this one instead
somaBNAux :: BigNumber -> BigNumber -> BigNumber
somaBNAux n1 n2
  | not (xor (fst n1) (fst n2)) = regularSum n1 n2
  | otherwise = negativeSum n1 n2

-- Defines the sign of the final result, later calling a helper function to compute the actual sum
regularSum :: BigNumber -> BigNumber -> BigNumber
regularSum (_, [0]) (_, [0]) = (True, [0])
regularSum n1 n2
  | fst n1 && fst n2 = (True, res)
  | otherwise = (False, res)
  where
    res = regularSumAux num1 num2 [] 0
    num1 = snd largest ++ [0]
    num2 = snd smallest ++ stuffZeroes (fromIntegral (diff + 1))
    largest = if gt (fst n1, reverse (snd n1)) (fst n2, reverse (snd n2)) then n1 else n2
    smallest = if largest == n1 then n2 else n1
    diff = length (snd largest) - length (snd smallest)

-- This functions computes the actual sum, with its input being no more than the integers that
-- make up both numbers, stored in a list. The smaller one is padded with zeroes, as a way to avoid problems
-- with out of bounds access. Also, it returns the result in the correct order again, so there is no need to
-- complicate again in other places
regularSumAux :: [Digit] -> [Digit] -> [Digit] -> Digit -> [Digit]
regularSumAux [] [] res _
  | last res == 0 = tail (reverse res)
  | otherwise = reverse res
regularSumAux (x : xs) (y : ys) res carry
  | result >= 10 = regularSumAux xs ys (res ++ [result - 10]) 1
  | otherwise = regularSumAux xs ys (res ++ [result]) 0
  where
    result = x + y + carry
regularSumAux [] _ res _ = res
regularSumAux _ [] res _ = res

negativeSum :: BigNumber -> BigNumber -> BigNumber
negativeSum n1 n2
  | fst n1 = subBNAux n1 num2
  | otherwise = subBNAux n2 num1
  where
    num1 = (True, snd n1)
    num2 = (True, snd n2)

subBN :: BigNumber -> BigNumber -> BigNumber
subBN (False, [0]) (True, [0]) = (True, [0])
subBN n1 n2 = subBNAux num1 num2
  where
    num1 = (fst n1, reverse (snd n1))
    num2 = (fst n2, reverse (snd n2))

subBNAux :: BigNumber -> BigNumber -> BigNumber
subBNAux n1 n2
  | fst n1 && fst n2 = regularSub n1 n2
  | fst n1 && not (fst n2) = somaBNAux n1 num2
  | not (fst n1) && fst n2 = (False, snd (somaBNAux num1 num2))
  | otherwise = regularSub num2 num1
  where
    num1 = (True, snd n1)
    num2 = (True, snd n2)

-- RegularSub is only called when both values are positive, and all it does is force the value so that the first
-- is always greater than the second, as all that is needed to do is switch the sign in the end.
regularSub :: BigNumber -> BigNumber -> BigNumber
regularSub (_, [0]) (_, [0]) = (True, [0])
regularSub n1 n2
  | eq n1 n2 = (True, [0])
  | largest == n1 = (True, res)
  | otherwise = (False, res)
  where
    res = regularSubAux num1 num2 [] 0
    num1 = snd largest
    num2 = snd smallest ++ stuffZeroes (fromIntegral diff)
    largest = if gt (fst n1, reverse (snd n1)) (fst n2, reverse (snd n2)) then n1 else n2
    smallest = if largest == n1 then n2 else n1
    diff = length (snd largest) - length (snd smallest)

regularSubAux :: [Digit] -> [Digit] -> [Digit] -> Digit -> [Digit]
regularSubAux [] [] res _
  | last res == 0 = dropWhile (== 0) (reverse res)
  | otherwise = reverse res
regularSubAux (x : xs) (y : ys) res borrow
  | result >= 0 = regularSubAux xs ys (res ++ [result]) 0
  | otherwise = regularSubAux xs ys (res ++ [result + 10]) 1
  where
    result = (x - borrow) - y
regularSubAux [] _ res _ = res
regularSubAux _ [] res _ = res

divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN n1 n2 = last (until (\[(w, x), (y, z)] -> not (fst (subBN z x))) (\[(w, x), (y, z)] -> [(w, x), (somaBN y (True, [1]), subBN z x)]) [(n1, n2), ((True, [0]), n1)])
