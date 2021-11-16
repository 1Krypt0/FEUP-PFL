type Digit = Integer

type BigNumber = [Integer]

output :: BigNumber -> String
output = concatMap show
