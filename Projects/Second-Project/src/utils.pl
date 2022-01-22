/*
* letter(?Number, ?Letter)
*
* Maps integers to chars
*/
letter(0, 'A').
letter(1, 'B').
letter(2, 'C').
letter(3, 'D').
letter(4, 'E').
letter(5, 'F').
letter(6, 'G').
letter(7, 'H').
letter(8, 'I').
letter(9, 'J').
letter(10, 'K').
letter(11, 'L').
letter(12, 'M').
letter(13, 'N').
letter(14, 'O').
letter(15, 'P').
letter(16, 'Q').
letter(17, 'R').
letter(18, 'S').
letter(19, 'T').
letter(20, 'U').
letter(21, 'V').
letter(22, 'W').
letter(23, 'X').
letter(24, 'Y').
letter(25, 'Z').

/*
* mymember(+Value, +List)
*
* Determines if Value belongs to List
*/
mymember(X,[X|_]).
mymember(X,[_|T]) :- mymember(X,T).

/*
* not(Value)
*
* Negates the output of A
*/
not(A) :- \+ call(A).

/*
* set(+List, -Set)
*
* Converts a List into a Set by removing duplicates
*/
set([],[]).
set([H|T],[H|Out]) :-
    not(mymember(H,T)),
    set(T,Out).
set([H|T],Out) :-
    mymember(H,T),
    set(T,Out).
