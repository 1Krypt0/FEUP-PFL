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

playPvP :-
    initial(Board),
    display_game(Board, 1),
    playPvP(Board, 1, _).

playPvP(Board, Player, Result) :-
    read_move(Board, Player, Move),
    move(Board, Player, Move, NewBoard), !,
    next_player(Player, NextPlayer),
    display_game(NewBoard, NextPlayer), !,
    (
        game_over(NewBoard, Result),
        dif(Result, -1),
        announce(Result, Player),
        pause
        ;
        playPvP(NewBoard, NextPlayer, Result)
    ).
