import Data.Char (digitToInt)
import Utils (stuffZeroes, xor)

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

--  | otherwise = negativeSum n1 n2

-- Defines the sign of the final result, later calling a helper function to compute the actual sum
regularSum :: BigNumber -> BigNumber -> BigNumber
regularSum (_, [0]) (_, [0]) = (True, [0])
regularSum n1 n2
  | fst n1 && fst n2 = (True, regularSumAux num1 num2 [] 0)
  | otherwise = (False, regularSumAux num1 num2 [] 0)
  where
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

-- Helper function to determine the greatest of two BigNumbers as they are
-- If used in auxiliary functions, be sure to reverse the list first
gt :: BigNumber -> BigNumber -> Bool
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
