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


%
% Question 6: List Manipulation
%

% a)
invert([], []).
invert([H | T], List) :-
    invert(T, List1),
    append(List1, [H], List).

% b)
del_one(_, [], []).
del_one(H, [H | T], T).
del_one(Elem, [H | T], [H | List ]) :-
    del_one(Elem, T, List),
    Elem \= H.

% c)
del_all(_, [], []).
del_all(H, [H | T], List) :-
    del_all(H, T, List).
del_all(Elem, [H | T], [H | Res]) :-
    del_all(Elem, T, Res).

% d)
del_all_list([], List1, List1).
del_all_list(_, [], []).
del_all_list([Elim | Rest], L, List) :-
    del_all(Elim, L, List1),
    del_all_list(Rest, List1, List).

% e)
del_dups_aux(X, [X | _]).
del_dups_aux(X, [_ | T]) :-
    del_dups_aux(X, T).
notmember(_, []).
notmember(X, [H | T]) :-
    X \= H,
    notmember(X, T).
del_dups([], []).
del_dups([H | T], [H | List]) :-
    notmember(H, T),
    del_dups(T, List).
del_dups([H | T], List) :-
    del_dups_aux(H, T),
    del_dups(T, List).
