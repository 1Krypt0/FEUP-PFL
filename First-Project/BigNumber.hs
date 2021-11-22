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
    l = map (toInteger . digitToInt) str
    negl = map (toInteger . digitToInt) (tail str)

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN n1 n2 = scanner (show (read (output n1) + read (output n2)))

somaBN2 :: BigNumber -> BigNumber -> BigNumber
somaBN2 n1 n2
  | fst n1 && fst n2 = scanner (show (num1 + num2))
  | fst n1 && not (fst n2) = scanner (show (num1 - num2))
  | not (fst n1) && fst n2 = scanner (show (- num1 + num2))
  | not (fst n1) && not (fst n2) = scanner (show (- num1 - num2))
  | otherwise = error "Invalid BigNumber"
  where
    num1 = sum [(10 ^ n) * (reverse (snd n1) !! n) | n <- [0 .. length (snd n1) - 1]]
    num2 = sum [(10 ^ n) * (reverse (snd n2) !! n) | n <- [0 .. length (snd n2) - 1]]

subBN :: BigNumber -> BigNumber -> BigNumber
subBN n1 n2 = scanner (show (read (output n1) + ((-1) * read (output n2))))

subBN2 :: BigNumber -> BigNumber -> BigNumber
subBN2 n1 n2
  | fst n1 && fst n2 = scanner (show (num1 - num2))
  | fst n1 && not (fst n2) = scanner (show (num1 + num2))
  | not (fst n1) && fst n2 = scanner (show (- num1 - num2))
  | not (fst n1) && not (fst n2) = scanner (show (- num1 + num2))
  | otherwise = error "Invalid BigNumber"
  where
    num1 = sum [(10 ^ n) * (reverse (snd n1) !! n) | n <- [0 .. length (snd n1) - 1]]
    num2 = sum [(10 ^ n) * (reverse (snd n2) !! n) | n <- [0 .. length (snd n2) - 1]]

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN n1 n2 = scanner (show (read (output n1) * read (output n2)))
