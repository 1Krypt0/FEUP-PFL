/**
*  next_player(+CurrentPlayer, -NextPlayer)
*
*  Determines the next player
*/
next_player(1, 2).
next_player(2, 1).

/**
*  valid_moves(+Board, +Player, -Moves)
*  Determines the valid moves Player can execute on Board
*/
validate_move(Board, [Row, Column, Direction], Player) :-
    get_piece(Board, [Row, Column], Piece),
    Piece =:= Player,
    direction(Direction, RowIncrement, ColumnIncrement),
    DestinationRow is Row + RowIncrement,
    DestinationColumn is Column + ColumnIncrement,
    valid_position(Board, [DestinationRow, DestinationColumn], DestinationPiece),
    DestinationPiece =:= 0.

/*
* move(+Board, +Player, [+Row, +Column, +Direction], -NewBoard)
*
* Moves a piece from Player in Board, At the Row and Column, in the Direction
* given, returning the new state of the board.
*/
move(Board, Player, [Row, Column, Direction], NewBoard) :-
    validate_move(Board, [Row, Column, Direction], Player),
    get_piece(Board, [Row, Column], Piece),
    direction(Direction, RowIncrement, ColumnIncrement),
    DestinationRow is Row + RowIncrement,
    DestinationColumn is Column + ColumnIncrement,
    set_piece(Board, [Row, Column], 0, ResultBoard),
    set_piece(ResultBoard, [DestinationRow, DestinationColumn], Piece, NewBoard).

/*
* get_valid_moves(+Board, +Player, -Moves)
*
* Retrieves the valid moves for Player
*/
get_valid_moves(Board, Player, Moves) :-
    get_player_piece_positions(Board, Player, Positions),
    get_valid_moves(Board, Positions, [], Moves).
get_valid_moves(_, [], NewAcc, NewAcc).
get_valid_moves(Board, [Piece | Rest], Acc, Moves) :-
    get_empty_adjacents(Board, Piece, Adjacents),
    append(Acc, Adjacents, NewAcc),
    get_valid_moves(Board, Rest, NewAcc, Moves).

/*
* get_player_moves(+Board, +Player, -Moves)
*
* Returns all moves available to Player
*/
get_player_moves(Board, Player, Moves) :-
    get_player_piece_positions(Board, Player, Positions),
    get_player_moves(Board, Positions, [], Moves).
get_player_moves(_, [], NewAcc, NewAcc).
get_player_moves(Board, [Piece | Rest], Acc, Moves) :-
    get_all_moves(Board, Piece, Adjacents),
    append(Acc, Adjacents, NewAcc),
    get_player_moves(Board, Rest, NewAcc, Moves).

/*
*  game_over(+Board, -Result)
*
*  Checks if a game is won by comparing the three possible final states
*/
game_over([
    [1, 1, 1, 1, 1],
    [1, _, _, _, 1],
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _]
], 1).
game_over([
    [_, _, _, _, _],
    [_, _, _, _, _],
    [_, _, _, _, _],
    [2, _, _, _, 2],
    [2, 2, 2, 2, 2]
], 2).
game_over(Board, 0) :-
    game_over_player_one(Board, Result1),
    game_over_player_two(Board, Result2),
    Result1 =:= 0,
    Result2 =:= 0.

game_over_player_one(Board, Result) :-
    get_valid_moves(Board, 1, X), !,
    length(X, Result).

game_over_player_two(Board, Result) :-
    get_valid_moves(Board, 2, X), !,
    length(X, Result).
