:- include('board.pl').
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
*  game_over(+Board, -Result)
*
*  Checks if a game is won by comparing to the two possible final states
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
