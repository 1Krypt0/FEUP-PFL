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
    game_over(Board, Result),
    dif(Result, -1), !,
    announce(Result, Player),
    pause.

playPvP(Board, Player, Result) :-
    read_move(Board, Player, Move),
    move(Board, Player, Move, NewBoard), !,
    next_player(Player, NextPlayer),
    display_game(NewBoard, NextPlayer), !,
    playPvP(NewBoard, NextPlayer, Result).

playPvC(Bot) :-
    initial(Board),
    display_game(Board, 1),
    playPvC(Board, Bot, 1, _).

playPvC(Board, Bot, Player, Result) :-
    game_over(Board, Result),
    dif(Result, -1), !,
    announce(Result, Player),
    pause.

playPvC(Board, Bot, Player, Result) :-
    (
        Player = 1,
        read_move(Board, Player, Move)
        ;
        choose_move(Board, Player, Bot, Move)
    ),
    move(Board, Player, Move, NewBoard), !,
    next_player(Player, NextPlayer),
    display_game(NewBoard, NextPlayer), !,
    playPvC(NewBoard, Bot, NextPlayer, Result).
