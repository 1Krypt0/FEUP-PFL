choose_move(Board, Player, 1, Move) :-
    get_player_moves(Board, Player, Moves),
    write(Moves),
    choose_random_move(Moves, Move), !.

choose_move(Board, Player, 2, Move) :- !.

choose_random_move(Moves, Move) :-
    length(Moves, Length),
    random(0, Length, Index),
    nth0(Index, Moves, Move).
