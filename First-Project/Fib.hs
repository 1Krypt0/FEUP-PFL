{- Recursive version of the Fibonnaci sequence-}
fibRec :: (Integral a) => a -> a
fibRec n
  | n == 0 = 0
  | n == 1 = 1
  | n > 1 = fibRec (n - 1) + fibRec (n - 2)
  | otherwise = error "Invalid argument"

{-Find a way to store the used values in the fibs function without being an infinite list-}
fibLista :: (Integral a) => a -> a
fibLista n = fibs !! fromIntegral n
  where
    fibs = 0 : 1 : [fibs !! fromIntegral(i-1) + fibs !! fromIntegral(i-2) | i <- [2 .. n]]

fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita n = fibs !! fromIntegral n
  where
    fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
