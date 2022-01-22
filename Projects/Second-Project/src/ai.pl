
/** 
 * choose_move(+GameState, +Player, +Level, -Move)
 * Returns a random move for a specific player given the current board and the level of the AI.
 */
choose_move(Board, Player, 1, Move) :-
    get_player_moves(Board, Player, Moves),
    write(Moves),
    choose_random_move(Moves, Move), !.

choose_move(Board, Player, 2, Move) :-
    get_player_moves(Board, Player, AllMoves),
    write(AllMoves),
    choose_greedy_move(Board, Player, AllMoves, _, TempMove),
    length(TempMove, Length),
    (
        Length =:= 0 ->
        choose_withdraw(Board, Player, Move)
        ;
        Move = TempMove
    ), !.

/** 
 * choose_random_move(+Moves, -Move)
 * Chooses a random move given a list of possible moves.
 */
choose_random_move(Moves, Move) :-
    length(Moves, Length),
    random(0, Length, Index),
    nth0(Index, Moves, Move).

/** 
 * choose_greedy_move(+Board, +Player, +Moves, -GoodMoves, -TempMove)
 * Chooses a random move given a list of possible good ones (moves that approximate the player 
 * of the other end of the board and don't block pieces).
 */
choose_greedy_move(_, _, [], GoodMoves, TempMove) :- 
    write(GoodMoves),
    choose_random_move(GoodMoves, TempMove), !.

choose_greedy_move(Board, 2, [Candidate|Rest], GoodMoves, TempMove) :-
    write(Candidate),
    (
        nth0(2, Candidate, 2) ->
        (
            nth0(0, Candidate, 2) ->
            simulate_play(Board, 2, Candidate, GoodMoves, NewMoves)
            ;
            append(GoodMoves, [Candidate], NewMoves)
        )
        ;
        nth0(2, Candidate, 3) ->
        (
            nth0(0, Candidate, 2) ->
            simulate_play(Board, 2, Candidate, GoodMoves, NewMoves)
            ;
            append(GoodMoves, [Candidate], NewMoves)
        )
        ;
        NewMoves = GoodMoves
    ),
    choose_greedy_move(Board, 2, Rest, NewMoves, TempMove), !.

choose_greedy_move(Board, 1, [Candidate|Rest], GoodMoves, TempMove) :-
    (
        nth0(2, Candidate, 0) ->
        (
            nth0(0, Candidate, 2) ->
            simulate_play(Board, 1, Candidate, GoodMoves, NewMoves)
            ;
            append(GoodMoves, [Candidate], NewMoves)
        )
        ;
        nth0(2, Candidate, 1) ->
        (
            nth0(0, Candidate, 2) ->
            simulate_play(Board, 1, Candidate, GoodMoves, NewMoves)
            ;
            append(GoodMoves, [Candidate], NewMoves)
        )
        ;
        NewMoves = GoodMoves
    ),
    choose_greedy_move(Board, 1, Rest, NewMoves, TempMove), !.

/** 
 * choose_withdraw(+Board, +Player, -Move)
 * Chooses a random move if greedy approach failed (no good move was found).
 */
choose_withdraw(Board, Player, Move) :-
    get_player_moves(Board, Player, Moves),
    choose_random_move(Moves, Move).

/** 
 * simulate_play(+Board, +Player, +Play, -GoodMoves, -NewMoves)
 * Simulates a play that could block pieces before adding it to the list of GoodMoves.
 */
simulate_play(Board, Player, [Row,Column,Direction], GoodMoves, NewMoves) :-
    direction(Direction, RowIncrement, ColumnIncrement),
    DestinationRow is Row + RowIncrement,
    DestinationColumn is Column + ColumnIncrement,
    set_piece(Board, [Row, Column], 0, ResultBoard),
    set_piece(ResultBoard, [DestinationRow, DestinationColumn], Player, NewBoard),
    check_blocked_pieces(NewBoard, [Row,Column,Direction], Player, GoodMoves, NewMoves), !.

/** 
 * check_blocked_pieces(+NewBoard, +Play, +Player, -GoodMoves, -NewMoves)
 * Checks if a certain move would block any opponent's piece on important positions of the board, 
 * using the modified board after the hypothetical play.
 */
check_blocked_pieces(Board, [Row,Column,Direction], Player, GoodMoves, NewMoves) :-
    (
        Player =:= 1 ->
        CheckRow is Row-2
        ;
        CheckRow is Row+2
    ),
    direction(Direction, _, ColumnIncrement),
    (
        ColumnIncrement =:= -1 ->
        CheckRight is Column,
        CheckLeft is Column - 2
        ;
        CheckRight is Column + 2,
        CheckLeft is Column
    ),
    next_player(Player, NextPlayer),

    (
        valid_column(Board, CheckRow, CheckLeft),
        get_piece(Board, [CheckRow, CheckLeft], LeftPiece),
        (
            dif(LeftPiece, NextPlayer) ->
            append(GoodMoves, [[Row,Column,Direction]], NewMoves)
            ;
            NewMoves = GoodMoves
        )
        ;
        valid_column(Board, CheckRow, CheckRight),
        get_piece(Board, [CheckRow, CheckLeft], RightPiece),
        (
            dif(RightPiece, NextPlayer) ->
            append(GoodMoves, [[Row,Column,Direction]], NewMoves)
            ;
            NewMoves = GoodMoves
        )
        ;
        NewMoves = GoodMoves
    ), !.
    
