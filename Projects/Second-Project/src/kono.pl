:- include('game.pl').
:- include('input.pl').
:- include('menus.pl').
:- include('utils.pl').
:- include('view.pl').
:- include('board.pl').

play :-
    menu.

/**
* Initial board configuration
*/
initial([
    [2, 2, 2, 2, 2],
    [2, 0, 0, 0, 2],
    [0, 0, 0, 0, 0],
    [1, 0, 0, 0, 1],
    [1, 1, 1, 1, 1]
]).
