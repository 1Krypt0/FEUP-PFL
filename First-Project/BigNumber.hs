type Digit = Integer

{- Bool was added to check for the sign of the number -}
type BigNumber = (Bool, [Digit])

output :: BigNumber -> String
output num
  | fst num = concatMap show (snd num)
  | otherwise = '-' : concatMap show (snd num)

digs :: Integral x => x -> [x]
digs 0 = []
digs x = digs (x `div` 10) ++ [x `mod` 10]

scanner :: String -> BigNumber
scanner str
  | head str == '-' = (False, digs (read (tail str)))
  | otherwise = (True, digs (read str))

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN n1 n2 = scanner (show (read (output n1) + read (output n2)))

subBN :: BigNumber -> BigNumber -> BigNumber
subBN n1 n2 = scanner (show (read (output n1) + ((-1) * read (output n2))))
