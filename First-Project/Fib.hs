import BigNumber

fibRec :: (Integral a) => a -> a
fibRec n
  | n == 0 = 0
  | n == 1 = 1
  | n > 1 = fibRec (n - 1) + fibRec (n - 2)
  | otherwise = error "Invalid argument"

fibLista :: (Integral a) => a -> a
fibLista n = fibs !! fromIntegral n
  where
    fibs = 0 : 1 : [fibs !! fromIntegral (i - 1) + fibs !! fromIntegral (i - 2) | i <- [2 .. n]]

fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita n = fibs !! fromIntegral n
  where
    fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

fibRecBN :: BigNumber -> BigNumber
fibRecBN n
  | equal n (True, [0]) || equal n (False, [0]) = (True, [0])
  | equal n (True, [1]) = (True, [1])
  | greaterThan n (True, [1]) = somaBN (fibRecBN (subBN n (True, [1]))) (fibRecBN (subBN n (True, [2])))
  | otherwise = error "Invalid BigNumber"

fibListaBN :: BigNumber -> BigNumber
fibListaBN n = fibs !! read (output n)
  where
    fibs = (True, [0]) : (True, [1]) : [somaBN (fibs !! fromIntegral (read (output i) - 1)) (fibs !! fromIntegral (read (output i) - 2)) | i <- [(True, [2]) .. n]]
