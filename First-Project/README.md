# Trabalho Prático 1 - Programação Funcional e em Lógica
---

# Test Cases

For each function developed, the following test cases where important to determine the function's efficiency and accuracy.

## Original Fib.hs Functions

### fibRec

| Test | Expected Output | Output    | Time Spent (in seconds) | Importance                                                          |
|------|-----------------|-----------|-------------------------|---------------------------------------------------------------------|
| 0    | 0               | 0         | 0.01                    | One of the base cases for the Fibonacci sequence.                   |
| 1    | 1               | 1         | 0.01                    | The other base case for the Fibonacci sequence.                     |
| 10   | 55              | 55        | 0.01                    | A starter value to check the accuracy.                              |
| 20   | 6765            | 6765      | 0.08                    | An even higher but important result to check if the speed holds.    |
| 30   | 832040          | 832040    | 3.68                    | An even higher where it is possible to see the processing demanded. |
| 40   | 102334155       | 102334155 | 474.91                  | A very high number that the function takes a long time to complete. |


### fibLista

| Test   | Expected Output | Output         | Time Spent (in seconds) | Importance                                                                                                                  |
|--------|-----------------|----------------|-------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| 0      | 0               | 0              | 0.01                    | The first base case for the Fibonacci sequence.                                                                             |
| 1      | 1               | 1              | 0.01                    | The other base case of the Fibonacci sequence.                                                                              |
| 10     | 55              | 55             | 0.01                    | A starter value to check for accuracy.                                                                                      |
| 40     | 102334155       | 102334155      | 0.01                    | The last value tested for the recursive version, to check the difference in speed.                                          |
| 100000 | 2.59 * 10^20898 | 2.6 * 10^20898 | 143.37                  | A very high number that helps checking the efficiency of the method and how high it could calculate within reasonable time. |


### fibListaInfinita

| Test   | Expected Output | Output         | Time Spent (in seconds) | Importance                                                                                                                           |
|--------|-----------------|----------------|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| 0      | 0               | 0              | 0.01                    | One of the basic results of the fibonacci sequence.                                                                                  |
| 1      | 1               | 1              | 0.01                    | One of the basic results of the fibonacci sequence.                                                                                  |
| 10     | 55              | 55             | 0.01                    | A higher but important result to check the accuracy.                                                                                 |
| 100000 | 2.59 * 10^20898 | 2.6 * 10^20898 | 0.69                    | The last value tested for the normal list version, to check the difference in speed.                                                 |
| 500000 |                 |                | 13.21                   | A superbly high number to test only if the program still ran. As no values were found to compare it to, it is assumed to be correct. |


## BigNumber.hs Functions

### scanner

| Test     | Expected Output      | Output               | Importance                                                             |
|----------|----------------------|----------------------|------------------------------------------------------------------------|
| "0"      | (True,[0])           | (True,[0])           | Simple case to test if 0 is not eliminated.                            |
| "-1"     | (False,[1])          | (False,[1])          | Important to test if the sign is being read correctly.                 |
| "200000" | (True,[2,0,0,0,0,0]) | (True,[2,0,0,0,0,0]) | Higher number to check if the list of digits is interpreted correctly. |
| "0050"   | (True,[5,0])         | (True,[5,0])         | Zeroes on the beginning of the number are ignored.                     |


### output

| Test           | Expected Output | Output | Importance                                                                                                             |
|----------------|-----------------|--------|------------------------------------------------------------------------------------------------------------------------|
| (True,[0])     | "0"             | "0"    | Base case that causes bugs sometimes.                                                                                  |
| (False,[0])    | "0"             | "0"    | Although it is possible to declares a negative 0 in scanner, the result will always default to the "positive" version. |
| (True,[0,0,5]) | "5"             | "5"    | Zeroes on the beginning of the number are ignored.                                                                     |
| (False,[8,0])  | "-80"           | "-80"  | Important to test if the bool is being interpreted as the negative sign.                                               |


### somaBN

| Test                          | Expected Output  | Output           | Importance                                                                               |
|-------------------------------|------------------|------------------|------------------------------------------------------------------------------------------|
| (True,[1]) (True,[0])         | (True,[1])       | (True,[l])       | Case to check if the identity element is correct (0).                                    |
| (True,[5]) (False,[7,0])      | (False,[6,5])    | (False,[6,5])    | Check if the sign of the output is correct, contemplating the magnitudes of the numbers. |
| (False,[5]) (True,[7,0])      | (True,[6,5])     | (True,[6,5])     | Check if the sign of the output is correct, contemplating the magnitudes of the numbers. |
| (False,[8,0]) (False,[2,0])   | (False,[1,0,0])  | (False,[1,0,0])  | Test if the sum of two negative numbers returns an even smaller number.                  |
| (True,[9,9,9]) (True,[9,9,9]) | (True,[1,9,9,8]) | (True,[1,9,9,8]) | Test if the sum of big digits like 9 and 9 would be a problem for the carry process.     |


### subBN

| Test                        | Expected Output | Output        | Importance                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|-----------------------------|-----------------|---------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| (True,[0]) (True,[0])       | (True,[0])      | (True,[0])    | Base case that checks for the identity element (0).                                                                                                                                                                                                                                                                                                                                                                                                           |
| (True,[5]) (False,[7,0])    | (True,[7,5])    | (True,[7,5])  | Check if the sign of the output is correct, contemplating the subtraction of a negative number (x - (-y) = x + y).                                                                                                                                                                                                                                                                                                                                            |
| (False,[5]) (True,[7,0])    | (False,[7,5])   | (False,[7,5]) | Check if the sign of the output is correct, contemplating the sign of the first number and the subtraction of a positive number.                                                                                                                                                                                                                                                                                                                              |
| (True,[1,8,4]) (True,[8,6]) | (True,[9,8])    | (True,[9,8])  | Tricky example because it shows that the borrow list should be created along with the operation. At first, the subtraction of 8 by 8 wouldn't need to borrow 1 from the decimal house on the left, but since 4<6 and the operation starts on the right, we end up having to borrow 1 from 8 in 184 and our subtraction of 8 by 8 becomes 7 by 8. In this example, it becomes clear that mid-operation there might be a new need of borrowing 1 from the left. |


### mulBN

| Test                      | Expected Output | Output          | Importance                                                     |
|---------------------------|-----------------|-----------------|----------------------------------------------------------------|
| (True,[1]) (True,[0])     | (True,[0])      | (True,[0])      | Base case that checks for the zero property of multiplication. |
| (True,[5]) (False,[7,0])  | (False,[3,5,0]) | (False,[3,5,0]) | Check if the sign of the output is correct.                    |
| (False,[5]) (False,[7,0]) | (True,[3,5,0])  | (True,[3,5,0])  | Check if the sign of the output is correct.                    |
| (True,[1,8,4]) (True,[1]) | (True,[1,8,4])  | (True,[1,8,4])  | Check if identity property is maintained                       |


### divBN

| Test                       | Expected Output              | Output                       | Importance                                                                                     |
|----------------------------|------------------------------|------------------------------|------------------------------------------------------------------------------------------------|
| (True,[0]) (True,[1, 0])   | ((True, [0]), (True, [0]))   | ((True, [0]), (True, [0]))   | Case to check if the division of any number by 0 is still 0, with no remainder.                |
| (True,[5]) (True,[7,0])    | ((True, [0]), (True, [5]))   | ((True, [0]), (True, [5]))   | Check if the quotient and remainder are correct, when the divisor is larger than the dividend. |
| (True,[7, 0]) (True,[7,0]) | ((True, [1]), (True, [0]))   | ((True, [1]), (True, [0]))   | Check if the division of a number for itself is correct.                                       |
| (True,[8,2]) (True,[5])    | ((True, [1,6]), (True, [2])) | ((True, [1,6]), (True, [2])) | Test if the quotient and remainder are correct in a regular division.                          |


# Functions

## On Fib.hs

- fibRec: Determines the nth Fibonacci number through the traditional recursive approach.

- fibLista: Determines the nth Fibonacci number using a finite list to hold partial results of calculations and with a dynamic programming approach.

- fibListaInfinita: Determines the nth Fibonacci number using an infinite list and the same dynamic approach, but taking advantage of Haskell's lazy evaluation features.

- fibRecBN: Implements the fibRec function, with it's recursive approach, using exclusively BigNumbers, along with operations exclusive to BigNumbers.

- fibListaBN: Implements the fibLista function and its underlying approach using exclusively BigNumbers, along with operations unique to BigNumbers.

- fibListaInfinitaBN: Implements the fibListaInfinita function, along with it's lazy evaluation advantage, using exclusively BigNumbers and their operations.

## On BigNumber.hs

- scanner: Converts a valid string into BigNumber format, taking into account the sign. Also, it eliminates some unnecessary left zeroes, in the case of not fully correct input.

- output: Converts a BigNumber into a string, taking into account it's sign as well as removing any zeroes on the left that may result from bad input.

- somaBN: Determines the sum of two BigNumbers with the help of somaBNAux. This function really only prepares the input for proper handling, reversing the list into a much easier to handle format, with units in the first place.

- somaBNAux: Helps with the calculation of the BigNumbers. Determines if it is easier to actually sum the numbers, or if it is more efficient to subtract them (like it happens in the case of opposite signs on the numbers).

- regularSum: Determines the sign of the final result, attending to the arithmetic properties of addition. Also, it determines the larger number so that the smaller one is padded with zeroes until the lists are of the same length, as a way to reduce the need to increase list lengths in the function where the calculations are done, and the larger one gets a left zero added, in case the result needs a new digit.

- regularSumAux: Computes the actual sum of the two numbers, in absolute values. As the sign is already handled by the regularSum function, this one only needs to worry about the digits of the numbers. It works by recursively adding the digits and the carry, storing the result in an accumulator, until the lists (which are of the same size) become empty.

- negativeSum: Passes control onto the subtraction functions, as according to arithmetic properties, the sum of two numbers with opposite signs is the same as subtracting the positive one for the absolute value of the negative one.

- subBN: Determines the sum of two BigNumbers with the help of subBNAux. Like somaBN, this only prepares the input for proper handling, reversing its digits so that units are at the start of the list.

- subBNAux: This function figures out if it is easier to perform an actual subtraction of the numbers or an addition, according to the arithmetic properties of subtraction.

- regularSub: This function is only called when the signs are the same, and so it determines the sign of the result based on which number is the largest. Also, it changes the order of the results so that the larger one is passed to the next function first, as a way to keep the calculations simpler. Finally, it pads the smaller number with zeroes so that it matches the length of the bigger one, much like what is done in regularSum.

- regularSubAux: Calculates the actual subtraction of the numbers, in absolute value. It assumes the first value passed is larger, so the functions calling it must handle it that happen. If all is well, computes the value much like in the regularSumAux function, the only difference being that instead of carrying the 1, we borrow from the next digit, with the result being held in an accumulator until the lists are empty.

- mulBN: Multiplies two BigNumbers. Much like the somaBN and subBN functions already seen, all it does is prepare the input for proper handling, reversing the digits lists.

- mulBNAux: Determines the sign of the resulting BigNumber, based on the sign of both operands, then passes them on into the actual multiplication part, in absolute value (forcing them to be true). This is one of two auxiliary functions that passes all the BigNumber instead of only its digits, as it uses the adding and subtracting functions described above as helpers.

- multiply: Adds together all the partial sums of the multiplication, giving the final result as an already properly formatted BigNumber.

- breakIntoParts: This function disassembles the multiplication into a series of sums. Each partial sum is the result of recursively adding the first number to itself x times, with x being the smallest digit at that time (since it works recursively, it will start with the units, then tens, then hundreds, etc...). Besides this, an offset of zeroes is added, corresponding to the place that the digit x occupies on the original number (for example, multiplying x by 342 is the same as x * 2 * 10^0 + x * 4 * 10^1 + x * 3 * 10^2).

- addPart: Adds a number to itself, n times. This is a helper function to the breakIntoParts, making the code more modular and allowing it to be used somewhere else, in case it is necessary.

- divBN: Divides two numbers, determining both the quotient and the remainder of the division. It, once again, uses an auxiliary function to determine this, only preparing the input for proper use.

- divBNAux: Computes the division, by subtracting the dividend to itself until the result is negative, whilst at the same time adding one to the quotient, and subtracting the divisor to the remainder, so that it keeps updating as the dividend diminishes.

- safeDivBN: This function operates much in the same way as the divBN function, but has an additional safety check for division with 0. To do this, it uses the Maybe Monad as a way to divert possible errors at runtime. When a division by 0 is attempted, the Nothing result is given, otherwise it can safely compute it, passing the control onto the divBN function.

## On Utils.hs

- xor: Calculates the Exclusive or operation of mathematical logic.

- gt: Determines if the first BigNumber is bigger than the second, taking into account the sign.

- eq: Determines if two BigNumbers are equal, taking into account the sign.

- stuffZeroes: Creates a list of len zeroes.

- first: Returns the first element of a quadruple.

- second: Returns the second element of a quadruple.

- third: Returns the third element of a quadruple.

- fourth: Returns the fourth element of a quadruple.

## Strategies

### scanner

It was decided to separate negative and positive numbers, in order to parse properly the string when converting (through the fuction "map") each char into an integer. That way, our function has a case where the string starts with the char "-", in which the Big Number is negative, and another where it's positive and doesn't have the minus sign.

### output
By checking if the first element of the tuple that constitutes our Big Number is true or false, we know its sign. After that, it is easier to convert it into a string, by placing '-' on the output before turning each element of the digits list into a string and concatinating them.

### somaBN
This function uses four other auxiliary functions, so that all the operations that a normal sum incorporates are covered and the steps for the resolution aren't illegible. The first important detail is reversing the list of digits, which is the job of the first function called. Afterwards, we needed to distinguish the operations through the signs, and later through the magnitudes of the numbers. That way, it is possible to calculate the sign of the result and which type of operation will be required. <br>
In short, treat a sum between two positive numbers as a regular positive sum; between two negative numbers as a regular positive sum with a negative sign; and lastly, the ones with opposite signs as negative sums (subtractions). <br>
Finally, for the addition itself, it was important to have in mind the ocasions in which adding two digits would have a result greater than 9 and the possibility of one of the numbers being smaller in length.

### subBN

### mulBN

### divBN

---

## Question 4:
- **Function fibRec :: Int -> Int** accepts up to value 40 with output 102334155, 207.78 seconds elapsed and usage of 97,131,015,400 bytes. Due to a huge time overhead, no larger values where tested.
- **Function fibLista :: Int -> Int** accepts up to value 92 with output 7540113804746346429, 0.01 seconds elapsed, usage of 132,968 bytes and no overflow. All inputs greater than 92 cause overflow.
- **Function fibListaInfinita :: Int -> Int** accepts up to value 92 with output 7540113804746346429, 0.00 seconds elapsed, usage of 83,416 bytes and no overflow. All inputs greater than 92 cause overflow.

- **Function fibRec :: Integer -> Integer** accepts up to value 40 with output 102334155, 367.86 seconds elapsed and usage of 96,119,078,984 bytes.
- **Function fibLista :: Integer -> Integer** accepts up to value 100000 with output 2.6*10^20898, 257.73 seconds elapsed and usage of 523,370,656 bytes. No overflow with the values tested, but the greater they are, the longer it takes for the function to calculate the result.
- **Function fibListaInfinita :: Integer -> Integer** accepts up to value 2000000 with the expected output, 127.60 seconds elapsed and usage of 176,154,768,536 bytes. 

- **Function fibRecBN :: Big Number -> Big Number** accepts up to value 35 with output (True,[9,2,2,7,4,6,5]), 877.50 seconds elapsed and usage of 189,399,738,336 bytes.
- **Function fibListaBN :: Big Number -> Big Number** accepts up to value 10000 with output 

(True,[3,3,6,4,4,7,6,4,8,7,6,4,3,1,7,8,3,2,6,6,6,2,1,6,1,2,0,0,5,1,0,7,5,4,3,3,1,0,3,0,2,1,4,8,4,6,0,6,8,0,0,6,3,9,0,6,5,6,4,7,6,9,9,7,4,6,8,0,0,8,1,4,4,2,1,6,6,6,6,2,3,6,8,1,5,5,5,9,5,5,1,3,6,3,3,7,3,4,0,2,5,5,8,2,0,6,5,3,3,2,6,8,0,8,3,6,1,5,9,3,7,3,7,3,4,7,9,0,4,8,3,8,6,5,2,6,8,2,6,3,0,4,0,8,9,2,4,6,3,0,5,6,4,3,1,8,8,7,3,5,4,5,4,4,3,6,9,5,5,9,8,2,7,4,9,1,6,0,6,6,0,2,0,9,9,8,8,4,1,8,3,9,3,3,8,6,4,6,5,2,7,3,1,3,0,0,0,8,8,8,3,0,2,6,9,2,3,5,6,7,3,6,1,3,1,3,5,1,1,7,5,7,9,2,9,7,4,3,7,8,5,4,4,1,3,7,5,2,1,3,0,5,2,0,5,0,4,3,4,7,7,0,1,6,0,2,2,6,4,7,5,8,3,1,8,9,0,6,5,2,7,8,9,0,8,5,5,1,5,4,3,6,6,1,5,9,5,8,2,9,8,7,2,7,9,6,8,2,9,8,7,5,1,0,6,3,1,2,0,0,5,7,5,4,2,8,7,8,3,4,5,3,2,1,5,5,1,5,1,0,3,8,7,0,8,1,8,2,9,8,9,6,9,7,9,1,6,1,3,1,2,7,8,5,6,2,6,5,0,3,3,1,9,5,4,8,7,1,4,0,2,1,4,2,8,7,5,3,2,6,9,8,1,8,7,9,6,2,0,4,6,9,3,6,0,9,7,8,7,9,9,0,0,3,5,0,9,6,2,3,0,2,2,9,1,0,2,6,3,6,8,1,3,1,4,9,3,1,9,5,2,7,5,6,3,0,2,2,7,8,3,7,6,2,8,4,4,1,5,4,0,3,6,0,5,8,4,4,0,2,5,7,2,1,1,4,3,3,4,9,6,1,1,8,0,0,2,3,0,9,1,2,0,8,2,8,7,0,4,6,0,8,8,9,2,3,9,6,2,3,2,8,8,3,5,4,6,1,5,0,5,7,7,6,5,8,3,2,7,1,2,5,2,5,4,6,0,9,3,5,9,1,1,2,8,2,0,3,9,2,5,2,8,5,3,9,3,4,3,4,6,2,0,9,0,4,2,4,5,2,4,8,9,2,9,4,0,3,9,0,1,7,0,6,2,3,3,8,8,8,9,9,1,0,8,5,8,4,1,0,6,5,1,8,3,1,7,3,3,6,0,4,3,7,4,7,0,7,3,7,9,0,8,5,5,2,6,3,1,7,6,4,3,2,5,7,3,3,9,9,3,7,1,2,8,7,1,9,3,7,5,8,7,7,4,6,8,9,7,4,7,9,9,2,6,3,0,5,8,3,7,0,6,5,7,4,2,8,3,0,1,6,1,6,3,7,4,0,8,9,6,9,1,7,8,4,2,6,3,7,8,6,2,4,2,1,2,8,3,5,2,5,8,1,1,2,8,2,0,5,1,6,3,7,0,2,9,8,0,8,9,3,3,2,0,9,9,9,0,5,7,0,7,9,2,0,0,6,4,3,6,7,4,2,6,2,0,2,3,8,9,7,8,3,1,1,1,4,7,0,0,5,4,0,7,4,9,9,8,4,5,9,2,5,0,3,6,0,6,3,3,5,6,0,9,3,3,8,8,3,8,3,1,9,2,3,3,8,6,7,8,3,0,5,6,1,3,6,4,3,5,3,5,1,8,9,2,1,3,3,2,7,9,7,3,2,9,0,8,1,3,3,7,3,2,6,4,2,6,5,2,6,3,3,9,8,9,7,6,3,9,2,2,7,2,3,4,0,7,8,8,2,9,2,8,1,7,7,9,5,3,5,8,0,5,7,0,9,9,3,6,9,1,0,4,9,1,7,5,4,7,0,8,0,8,9,3,1,8,4,1,0,5,6,1,4,6,3,2,2,3,3,8,2,1,7,4,6,5,6,3,7,3,2,1,2,4,8,2,2,6,3,8,3,0,9,2,1,0,3,2,9,7,7,0,1,6,4,8,0,5,4,7,2,6,2,4,3,8,4,2,3,7,4,8,6,2,4,1,1,4,5,3,0,9,3,8,1,2,2,0,6,5,6,4,9,1,4,0,3,2,7,5,1,0,8,6,6,4,3,3,9,4,5,1,7,5,1,2,1,6,1,5,2,6,5,4,5,3,6,1,3,3,3,1,1,1,3,1,4,0,4,2,4,3,6,8,5,4,8,0,5,1,0,6,7,6,5,8,4,3,4,9,3,5,2,3,8,3,6,9,5,9,6,5,3,4,2,8,0,7,1,7,6,8,7,7,5,3,2,8,3,4,8,2,3,4,3,4,5,5,5,7,3,6,6,7,1,9,7,3,1,3,9,2,7,4,6,2,7,3,6,2,9,1,0,8,2,1,0,6,7,9,2,8,0,7,8,4,7,1,8,0,3,5,3,2,9,1,3,1,1,7,6,7,7,8,9,2,4,6,5,9,0,8,9,9,3,8,6,3,5,4,5,9,3,2,7,8,9,4,5,2,3,7,7,7,6,7,4,4,0,6,1,9,2,2,4,0,3,3,7,6,3,8,6,7,4,0,0,4,0,2,1,3,3,0,3,4,3,2,9,7,4,9,6,9,0,2,0,2,8,3,2,8,1,4,5,9,3,3,4,1,8,8,2,6,8,1,7,6,8,3,8,9,3,0,7,2,0,0,3,6,3,4,7,9,5,6,2,3,1,1,7,1,0,3,1,0,1,2,9,1,9,5,3,1,6,9,7,9,4,6,0,7,6,3,2,7,3,7,5,8,9,2,5,3,5,3,0,7,7,2,5,5,2,3,7,5,9,4,3,7,8,8,4,3,4,5,0,4,0,6,7,7,1,5,5,5,5,7,7,9,0,5,6,4,5,0,4,4,3,0,1,6,6,4,0,1,1,9,4,6,2,5,8,0,9,7,2,2,1,6,7,2,9,7,5,8,6,1,5,0,2,6,9,6,8,4,4,3,1,4,6,9,5,2,0,3,4,6,1,4,9,3,2,2,9,1,1,0,5,9,7,0,6,7,6,2,4,3,2,6,8,5,1,5,9,9,2,8,3,4,7,0,9,8,9,1,2,8,4,7,0,6,7,4,0,8,6,2,0,0,8,5,8,7,1,3,5,0,1,6,2,6,0,3,1,2,0,7,1,9,0,3,1,7,2,0,8,6,0,9,4,0,8,1,2,9,8,3,2,1,5,8,1,0,7,7,2,8,2,0,7,6,3,5,3,1,8,6,6,2,4,6,1,1,2,7,8,2,4,5,5,3,7,2,0,8,5,3,2,3,6,5,3,0,5,7,7,5,9,5,6,4,3,0,0,7,2,5,1,7,7,4,4,3,1,5,0,5,1,5,3,9,6,0,0,9,0,5,1,6,8,6,0,3,2,2,0,3,4,9,1,6,3,2,2,2,6,4,0,8,8,5,2,4,8,8,5,2,4,3,3,1,5,8,0,5,1,5,3,4,8,4,9,6,2,2,4,3,4,8,4,8,2,9,9,3,8,0,9,0,5,0,7,0,4,8,3,4,8,2,4,4,9,3,2,7,4,5,3,7,3,2,6,2,4,5,6,7,7,5,5,8,7,9,0,8,9,1,8,7,1,9,0,8,0,3,6,6,2,0,5,8,0,0,9,5,9,4,7,4,3,1,5,0,0,5,2,4,0,2,5,3,2,7,0,9,7,4,6,9,9,5,3,1,8,7,7,0,7,2,4,3,7,6,8,2,5,9,0,7,4,1,9,9,3,9,6,3,2,2,6,5,9,8,4,1,4,7,4,9,8,1,9,3,6,0,9,2,8,5,2,2,3,9,4,5,0,3,9,7,0,7,1,6,5,4,4,3,1,5,6,4,2,1,3,2,8,1,5,7,6,8,8,9,0,8,0,5,8,7,8,3,1,8,3,4,0,4,9,1,7,4,3,4,5,5,6,2,7,0,5,2,0,2,2,3,5,6,4,8,4,6,4,9,5,1,9,6,1,1,2,4,6,0,2,6,8,3,1,3,9,7,0,9,7,5,0,6,9,3,8,2,6,4,8,7,0,6,6,1,3,2,6,4,5,0,7,6,6,5,0,7,4,6,1,1,5,1,2,6,7,7,5,2,2,7,4,8,6,2,1,5,9,8,6,4,2,5,3,0,7,1,1,2,9,8,4,4,1,1,8,2,6,2,2,6,6,1,0,5,7,1,6,3,5,1,5,0,6,9,2,6,0,0,2,9,8,6,1,7,0,4,9,4,5,4,2,5,0,4,7,4,9,1,3,7,8,1,1,5,1,5,4,1,3,9,9,4,1,5,5,0,6,7,1,2,5,6,2,7,1,1,9,7,1,3,3,2,5,2,7,6,3,6,3,1,9,3,9,6,0,6,9,0,2,8,9,5,6,5,0,2,8,8,2,6,8,6,0,8,3,6,2,2,4,1,0,8,2,0,5,0,5,6,2,4,3,0,7,0,1,7,9,4,9,7,6,1,7,1,1,2,1,2,3,3,0,6,6,0,7,3,3,1,0,0,5,9,9,4,7,3,6,6,8,7,5]) 

258.22 seconds elapsed and usage of 624,753,842,200 bytes.
- **Function fibListaInfinitaBN :: Big Number -> Big Number** accepts up to value 10000 with output

(True,[3,3,6,4,4,7,6,4,8,7,6,4,3,1,7,8,3,2,6,6,6,2,1,6,1,2,0,0,5,1,0,7,5,4,3,3,1,0,3,0,2,1,4,8,4,6,0,6,8,0,0,6,3,9,0,6,5,6,4,7,6,9,9,7,4,6,8,0,0,8,1,4,4,2,1,6,6,6,6,2,3,6,8,1,5,5,5,9,5,5,1,3,6,3,3,7,3,4,0,2,5,5,8,2,0,6,5,3,3,2,6,8,0,8,3,6,1,5,9,3,7,3,7,3,4,7,9,0,4,8,3,8,6,5,2,6,8,2,6,3,0,4,0,8,9,2,4,6,3,0,5,6,4,3,1,8,8,7,3,5,4,5,4,4,3,6,9,5,5,9,8,2,7,4,9,1,6,0,6,6,0,2,0,9,9,8,8,4,1,8,3,9,3,3,8,6,4,6,5,2,7,3,1,3,0,0,0,8,8,8,3,0,2,6,9,2,3,5,6,7,3,6,1,3,1,3,5,1,1,7,5,7,9,2,9,7,4,3,7,8,5,4,4,1,3,7,5,2,1,3,0,5,2,0,5,0,4,3,4,7,7,0,1,6,0,2,2,6,4,7,5,8,3,1,8,9,0,6,5,2,7,8,9,0,8,5,5,1,5,4,3,6,6,1,5,9,5,8,2,9,8,7,2,7,9,6,8,2,9,8,7,5,1,0,6,3,1,2,0,0,5,7,5,4,2,8,7,8,3,4,5,3,2,1,5,5,1,5,1,0,3,8,7,0,8,1,8,2,9,8,9,6,9,7,9,1,6,1,3,1,2,7,8,5,6,2,6,5,0,3,3,1,9,5,4,8,7,1,4,0,2,1,4,2,8,7,5,3,2,6,9,8,1,8,7,9,6,2,0,4,6,9,3,6,0,9,7,8,7,9,9,0,0,3,5,0,9,6,2,3,0,2,2,9,1,0,2,6,3,6,8,1,3,1,4,9,3,1,9,5,2,7,5,6,3,0,2,2,7,8,3,7,6,2,8,4,4,1,5,4,0,3,6,0,5,8,4,4,0,2,5,7,2,1,1,4,3,3,4,9,6,1,1,8,0,0,2,3,0,9,1,2,0,8,2,8,7,0,4,6,0,8,8,9,2,3,9,6,2,3,2,8,8,3,5,4,6,1,5,0,5,7,7,6,5,8,3,2,7,1,2,5,2,5,4,6,0,9,3,5,9,1,1,2,8,2,0,3,9,2,5,2,8,5,3,9,3,4,3,4,6,2,0,9,0,4,2,4,5,2,4,8,9,2,9,4,0,3,9,0,1,7,0,6,2,3,3,8,8,8,9,9,1,0,8,5,8,4,1,0,6,5,1,8,3,1,7,3,3,6,0,4,3,7,4,7,0,7,3,7,9,0,8,5,5,2,6,3,1,7,6,4,3,2,5,7,3,3,9,9,3,7,1,2,8,7,1,9,3,7,5,8,7,7,4,6,8,9,7,4,7,9,9,2,6,3,0,5,8,3,7,0,6,5,7,4,2,8,3,0,1,6,1,6,3,7,4,0,8,9,6,9,1,7,8,4,2,6,3,7,8,6,2,4,2,1,2,8,3,5,2,5,8,1,1,2,8,2,0,5,1,6,3,7,0,2,9,8,0,8,9,3,3,2,0,9,9,9,0,5,7,0,7,9,2,0,0,6,4,3,6,7,4,2,6,2,0,2,3,8,9,7,8,3,1,1,1,4,7,0,0,5,4,0,7,4,9,9,8,4,5,9,2,5,0,3,6,0,6,3,3,5,6,0,9,3,3,8,8,3,8,3,1,9,2,3,3,8,6,7,8,3,0,5,6,1,3,6,4,3,5,3,5,1,8,9,2,1,3,3,2,7,9,7,3,2,9,0,8,1,3,3,7,3,2,6,4,2,6,5,2,6,3,3,9,8,9,7,6,3,9,2,2,7,2,3,4,0,7,8,8,2,9,2,8,1,7,7,9,5,3,5,8,0,5,7,0,9,9,3,6,9,1,0,4,9,1,7,5,4,7,0,8,0,8,9,3,1,8,4,1,0,5,6,1,4,6,3,2,2,3,3,8,2,1,7,4,6,5,6,3,7,3,2,1,2,4,8,2,2,6,3,8,3,0,9,2,1,0,3,2,9,7,7,0,1,6,4,8,0,5,4,7,2,6,2,4,3,8,4,2,3,7,4,8,6,2,4,1,1,4,5,3,0,9,3,8,1,2,2,0,6,5,6,4,9,1,4,0,3,2,7,5,1,0,8,6,6,4,3,3,9,4,5,1,7,5,1,2,1,6,1,5,2,6,5,4,5,3,6,1,3,3,3,1,1,1,3,1,4,0,4,2,4,3,6,8,5,4,8,0,5,1,0,6,7,6,5,8,4,3,4,9,3,5,2,3,8,3,6,9,5,9,6,5,3,4,2,8,0,7,1,7,6,8,7,7,5,3,2,8,3,4,8,2,3,4,3,4,5,5,5,7,3,6,6,7,1,9,7,3,1,3,9,2,7,4,6,2,7,3,6,2,9,1,0,8,2,1,0,6,7,9,2,8,0,7,8,4,7,1,8,0,3,5,3,2,9,1,3,1,1,7,6,7,7,8,9,2,4,6,5,9,0,8,9,9,3,8,6,3,5,4,5,9,3,2,7,8,9,4,5,2,3,7,7,7,6,7,4,4,0,6,1,9,2,2,4,0,3,3,7,6,3,8,6,7,4,0,0,4,0,2,1,3,3,0,3,4,3,2,9,7,4,9,6,9,0,2,0,2,8,3,2,8,1,4,5,9,3,3,4,1,8,8,2,6,8,1,7,6,8,3,8,9,3,0,7,2,0,0,3,6,3,4,7,9,5,6,2,3,1,1,7,1,0,3,1,0,1,2,9,1,9,5,3,1,6,9,7,9,4,6,0,7,6,3,2,7,3,7,5,8,9,2,5,3,5,3,0,7,7,2,5,5,2,3,7,5,9,4,3,7,8,8,4,3,4,5,0,4,0,6,7,7,1,5,5,5,5,7,7,9,0,5,6,4,5,0,4,4,3,0,1,6,6,4,0,1,1,9,4,6,2,5,8,0,9,7,2,2,1,6,7,2,9,7,5,8,6,1,5,0,2,6,9,6,8,4,4,3,1,4,6,9,5,2,0,3,4,6,1,4,9,3,2,2,9,1,1,0,5,9,7,0,6,7,6,2,4,3,2,6,8,5,1,5,9,9,2,8,3,4,7,0,9,8,9,1,2,8,4,7,0,6,7,4,0,8,6,2,0,0,8,5,8,7,1,3,5,0,1,6,2,6,0,3,1,2,0,7,1,9,0,3,1,7,2,0,8,6,0,9,4,0,8,1,2,9,8,3,2,1,5,8,1,0,7,7,2,8,2,0,7,6,3,5,3,1,8,6,6,2,4,6,1,1,2,7,8,2,4,5,5,3,7,2,0,8,5,3,2,3,6,5,3,0,5,7,7,5,9,5,6,4,3,0,0,7,2,5,1,7,7,4,4,3,1,5,0,5,1,5,3,9,6,0,0,9,0,5,1,6,8,6,0,3,2,2,0,3,4,9,1,6,3,2,2,2,6,4,0,8,8,5,2,4,8,8,5,2,4,3,3,1,5,8,0,5,1,5,3,4,8,4,9,6,2,2,4,3,4,8,4,8,2,9,9,3,8,0,9,0,5,0,7,0,4,8,3,4,8,2,4,4,9,3,2,7,4,5,3,7,3,2,6,2,4,5,6,7,7,5,5,8,7,9,0,8,9,1,8,7,1,9,0,8,0,3,6,6,2,0,5,8,0,0,9,5,9,4,7,4,3,1,5,0,0,5,2,4,0,2,5,3,2,7,0,9,7,4,6,9,9,5,3,1,8,7,7,0,7,2,4,3,7,6,8,2,5,9,0,7,4,1,9,9,3,9,6,3,2,2,6,5,9,8,4,1,4,7,4,9,8,1,9,3,6,0,9,2,8,5,2,2,3,9,4,5,0,3,9,7,0,7,1,6,5,4,4,3,1,5,6,4,2,1,3,2,8,1,5,7,6,8,8,9,0,8,0,5,8,7,8,3,1,8,3,4,0,4,9,1,7,4,3,4,5,5,6,2,7,0,5,2,0,2,2,3,5,6,4,8,4,6,4,9,5,1,9,6,1,1,2,4,6,0,2,6,8,3,1,3,9,7,0,9,7,5,0,6,9,3,8,2,6,4,8,7,0,6,6,1,3,2,6,4,5,0,7,6,6,5,0,7,4,6,1,1,5,1,2,6,7,7,5,2,2,7,4,8,6,2,1,5,9,8,6,4,2,5,3,0,7,1,1,2,9,8,4,4,1,1,8,2,6,2,2,6,6,1,0,5,7,1,6,3,5,1,5,0,6,9,2,6,0,0,2,9,8,6,1,7,0,4,9,4,5,4,2,5,0,4,7,4,9,1,3,7,8,1,1,5,1,5,4,1,3,9,9,4,1,5,5,0,6,7,1,2,5,6,2,7,1,1,9,7,1,3,3,2,5,2,7,6,3,6,3,1,9,3,9,6,0,6,9,0,2,8,9,5,6,5,0,2,8,8,2,6,8,6,0,8,3,6,2,2,4,1,0,8,2,0,5,0,5,6,2,4,3,0,7,0,1,7,9,4,9,7,6,1,7,1,1,2,1,2,3,3,0,6,6,0,7,3,3,1,0,0,5,9,9,4,7,3,6,6,8,7,5]) 

268.44 seconds elapsed and usage of 621,970,070,488 bytes.
