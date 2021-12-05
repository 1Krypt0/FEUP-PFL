isVowel :: Char -> Bool
isVowel c = c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'

transformaAux :: String -> String -> String
transformaAux [] res = res
transformaAux (x : xs) res
  | not (isVowel x) = transformaAux xs [x] ++ res
  | otherwise = transformaAux xs [x] ++ ['p'] ++ [x] ++ res

transforma :: String -> String
transforma str = reverse (transformaAux str [])

subidas :: [Integer] -> Integer
subidas [_] = 0
subidas l = subidasAux l 0

subidasAux :: [Integer] -> Integer -> Integer
subidasAux [_] counter = counter
subidasAux (x : xs) counter
  | x < head xs = subidasAux xs (counter + 1)
  | otherwise = subidasAux xs counter
subidasAux [] counter = counter

data Arv a = F | N a (Arv a) (Arv a)

alturas :: Arv a -> Arv Integer
alturas F = F
alturas (N x F F) = N 1 F F
alturas (N x left right) = N (1 + myMin (getValue (alturas left)) (getValue (alturas right))) (alturas left) (alturas right)

getValue :: Arv Integer -> Integer
getValue F = 0
getValue (N x y z) = x

myMin :: Integer -> Integer -> Integer
myMin a b
  | a < b = a
  | otherwise = b
