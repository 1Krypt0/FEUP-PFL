fibRec :: (Integral a) => a -> a
fibRec n
  | n == 0 = 0
  | n == 1 = 1
  | n > 1 = fibRec (n - 1) + fibRec (n - 2)
  | otherwise = error "Invalid argument"

fibLista :: (Integral a) => a -> a
fibLista n = fibs !! fromIntegral n
  where
    fibs = 0 : 1 : [fibs !! fromIntegral (i -1) + fibs !! fromIntegral (i -2) | i <- [2 .. n]]

fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita n = fibs !! fromIntegral n
  where
    fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
