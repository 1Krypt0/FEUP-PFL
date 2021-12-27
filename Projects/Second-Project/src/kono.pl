:- include('board.pl').
:- include('game.pl').
:- include('utils.pl').
:- include('view.pl').

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
