%
% Question 1: Recursion
%

% a) Implement the predicate fatorial(+N, ?F), that calculates the factorial of
%    a number N.
fatorial(0, 1).
fatorial(N, F) :- N > 0,
                  N1 is N-1,
                  fatorial(N1, F1),
                  F is F1*N.

% b) Implement the preficate somaRec(+N, ?Sum), that calculates the recursive
%    sum of the number of 1 to N.
somaRec(0, 0).
somaRec(1, 1).
somaRec(N, Sum) :- N > 1,
                   N1 is N-1,
                   somaRec(N1, Sum1),
                   Sum is Sum1+N.

% c) Implement the predicate fibonacci(+N, ?F), that calculates the Nth
%    Fibonnaci number.
fibonnaci(0, 0).
fibonnaci(1, 1).
fibonnaci(N, F) :- N > 1,
                   N1 is N-1,
                   N2 is N-2,
                   fibonnaci(N1, F1),
                   fibonnaci(N2, F2),
                   F is F1+F2.

% d) Implement the predicate isPrime(-X), that determines if X is a prime
%    number. Remember that a number is prime if it is only divisible by
%    himself and 1.
divisible(X, 1).
divisible(X, D) :- X mod D =:= 0.
