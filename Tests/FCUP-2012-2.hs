{-

1 - Write a recursive definiton of the function rld :: [(Int, Char)] -> String,
    which decompresses a chain of characters that uses "run length decoding"

-}

rld :: [(Int, Char)] -> String
rld lst = rldAux lst ""

rldAux :: [(Int, Char)] -> String -> String
rldAux xs res =
  foldl (\res x -> res ++ uncurry replicate x) res xs

{-

2 - Consider the following recursive type to represent logical propositions

-}

data Prop
  = Const Bool --constants
  | Var Char --variables
  | Neg Prop --negation
  | Conj Prop Prop --conjunction
  | Disj Prop Prop --disjunction
  deriving (Show)

dual :: Prop -> Prop
dual (Const a) = Const (not a)
dual (Var c) = Var c
dual (Neg p) = Neg p
dual (Conj p1 p2) = Disj (dual p1) (dual p2)
dual (Disj p1 p2) = Conj (dual p1) (dual p2)

{-

3 - Using induction on lists, show the following property
TODO: Prove the property

-}
