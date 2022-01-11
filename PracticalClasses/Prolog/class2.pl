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

%
% Question 5: Recursion on Lists
%

% a)
list_size([], 0).
list_size([_ | T], Size) :-
    list_size(T, Size1),
    Size is Size1 + 1.

% b)
list_sum([], 0).
list_sum([H | T], Sum) :-
    list_sum(T, Sum1),
    Sum is Sum1 + H.

% c)
list_prod([], 1).
list_prod([H | T], Prod) :-
    list_prod(T, Prod1),
    Prod is Prod1 * H.

% d)
count(_, [], 0).
count(H, [H | T], Count) :-
    count(H, T, Count1),
    Count is Count1 + 1.
count(Elem, [H | T], Count):-
    count(Elem, T, Count),
    Elem \= H.
