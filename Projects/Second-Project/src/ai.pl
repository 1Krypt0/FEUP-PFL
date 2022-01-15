choose_move(Board, Player, 1, Move) :-
    get_player_moves(Board, Player, Moves),
    write(Moves),
    choose_random_move(Moves, Move), !.

choose_move(Board, Player, 2, Move) :-
    get_player_moves(Board, Player, AllMoves),
    write(AllMoves),
    choose_greedy_move(Player, AllMoves, GoodMoves, TempMove),
    length(TempMove, Length),
    (
        Length =:= 0 ->
        get_player_moves(Board, Player, Moves),
        length(Moves, NewLength),
        random(0, NewLength, Index),
        nth0(Index, Moves, Move)
        ;
        Move = TempMove
    ), !.

choose_random_move(Moves, Move) :-
    length(Moves, Length),
    random(0, Length, Index),
    nth0(Index, Moves, Move).

choose_greedy_move(_, [], GoodMoves, TempMove) :- 
    write(GoodMoves),
    choose_random_move(GoodMoves, TempMove), !.

choose_greedy_move(Player, [Candidate|Rest], GoodMoves, TempMove) :-
    (   
        nth0(2, Candidate, 2), Player =:= 2->
        append(GoodMoves, [Candidate], NewMoves)
        ;
        nth0(2, Candidate, 3), Player =:= 2->
        append(GoodMoves, [Candidate], NewMoves)
        ;
        nth0(2, Candidate, 0), Player =:= 1->
        append(GoodMoves, [Candidate], NewMoves)
        ;
        nth0(2, Candidate, 1), Player =:= 1->
        append(GoodMoves, [Candidate], NewMoves)
        ;
        NewMoves = GoodMoves
    ),
    choose_greedy_move(Player, Rest, NewMoves, TempMove), !.