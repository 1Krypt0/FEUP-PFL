get_player(1, 1).
get_player(2, 2).

/**
 * Direction Map
 * North West - 0
 * North East - 1
 * South West - 2
 * South East - 3
 * direction(DirectionID, RowIncrement, ColumnIncrement)
 */
direction(0, -1, -1).
direction(1, -1, 1).
direction(2, 1, -1).
direction(3, 1, 1).

directions([[-1, -1], [-1, 1], [1, -1], [1, 1]]).

/**
 * Check if row is valid on the board
 */
valid_row(Board, NRow) :-
    NRow >= 0,
    length(Board, NRows),
    NRow < NRows.


/**
 * Checks if column is valid on the board
 */
valid_column(Board, NRow, NColumn) :-
    NColumn >= 0,
    get_row(Board, NRow, Row),
    length(Row, NCols),
    NColumn < NCols.


/**
 * Checks if the position is valid on the board
 */
valid_position(Board, Player, [NRow, NColumn], Piece) :-
    valid_row(Board, NRow),
    valid_column(Board, NRow, NColumn),
    get_piece(Board, [NRow, NColumn], Piece),
    Piece =:= Player.

valid_position(Board, [NRow, NColumn], Piece) :-
    valid_row(Board, NRow),
    valid_column(Board, NRow, NColumn),
    get_piece(Board, [NRow, NColumn], Piece).



/**
*
*  get_piece(+Board, +[Row, Column], -Piece)
*
*  Gets the piece from Board at position specified by the [Row, Column] coordinates
*/
get_piece(Board, [NRow, NColumn], Piece) :-
    get_row(Board, NRow, Row),
    get_value(Row, NColumn, Piece).

/**
*
*  get_row(+Board, +NRow, -Row)
*
*  Gets the nth Row from Board, where N is given by NRow
*/
get_row([Current | _ ], 0, Current).
get_row([_ | Rest], NRow, Row) :-
    NRow > 0,
    N is NRow - 1,
    get_row(Rest, N, Row).

/**
*
*  get_value(+Row, +NCol, -Value)
*
*  Gets the nth value from Row, where N is given by NCol
*/
get_value([CurrentValue | _ ], 0, CurrentValue).
get_value([ _ | Rest ], NCol, Value) :-
    NCol > 0,
    N is NCol - 1,
    get_value(Rest, N, Value).

/**
*
*  set_piece(+Board, +Position, +Value, -NewBoard)
*
*  Sets the state in Position of Board to be Value, returning the new state of the board.
*/
set_piece(Board, Position, Value, NewBoard) :-
    length(Board, NRows),
    set_piece(Board, Position, Value, NRows, 0, [], NewBoard).

set_piece(_, _, _, NRows, NRows, NewBoard, NewBoard):- !.
set_piece([Row | Rest], [NRow, NCol], Value, Nrows, NRow, Acc, NewBoard) :-
    length(Row, NCols),
    set_row(Row, NCol, Value, NCols, 0, [], NewRow),
    NextRow is NRow + 1,
    append(Acc, [NewRow], NewAcc),
    set_piece(Rest, [NRow, NCol], Value, Nrows, NextRow, NewAcc, NewBoard).

set_piece([Row | Rest], [NRow, NCol], Value, NRows, CurrentRow, Acc, NewBoard) :-
    NextRow is CurrentRow + 1,
    append(Acc, [Row], NewAcc),
    set_piece(Rest, [NRow, NCol], Value, NRows, NextRow, NewAcc, NewBoard).

/**
*
*  set_row(+Row, +NCol, +Value, +NCols, +NCol, +Acc, -NewRow)
*
*  Rewrites the row and changes the value at NCol to Value, returning the new row through NewRow
*/
set_row(_, _, _, NCols, NCols, NewRow, NewRow) :- !.

set_row([_ | Rest], NCol, NewValue, NCols, NCol, Acc, NewRow) :-
    NextCol is NCol + 1,
    append(Acc, [NewValue], NewAcc), !,
    set_row(Rest, NCol, NewValue, NCols, NextCol, NewAcc, NewRow).

set_row([Value | Rest], NCol, NewValue, NCols, CurrentCol, Acc, NewRow) :-
    NextCol is CurrentCol + 1,
    append(Acc, [Value], NewAcc), !,
    set_row(Rest, NCol, NewValue, NCols, NextCol, NewAcc, NewRow).


get_player_piece_positions(Board, Player, Positions) :-
    get_player_piece_positions(Board, Player, [0, 0], [], Positions).

get_player_piece_positions(_, _, [5, _], Positions, Positions).

get_player_piece_positions(Board, Player, [Row, Column], Acc, Positions) :-
    get_piece(Board, [Row, Column], Piece),
    (
        get_player(Piece, Player),
        append(Acc, [[Row, Column]], NewAcc)
        ;
        NewAcc = Acc
    ),
    NewColumn is Column + 1,
    get_player_piece_positions(Board, Player, [Row, NewColumn], NewAcc, Positions).


get_player_piece_positions(Board, Player, [Row, Column], Acc, Positions) :-
    Column < 6,
    NewRow is Row + 1,
    NewColumn is 0,
    get_player_piece_positions(Board, Player, [NewRow, NewColumn], Acc, Positions).

get_empty_positions(Board, Positions) :-
    get_empty_positions(Board, [0, 0], [], Positions).

get_empty_positions(_, [5, _], Positions, Positions).

get_empty_positions(Board, [Row, Column], Acc, Positions) :-
    get_piece(Board, [Row, Column], Piece),
    (
        Piece =:= 0,
        append(Acc, [[Row, Column]], NewAcc)
        ;
        NewAcc = Acc
    ),
    NewColumn is Column + 1,
    get_empty_positions(Board, [Row, NewColumn], NewAcc, Positions).

get_empty_positions(Board, [Row, Column], Acc, Positions) :-
    Column < 6,
    NewRow is Row + 1,
    NewColumn is 0,
    get_empty_positions(Board, [NewRow, NewColumn], Acc, Positions).

/**
 * Get player stacks adjacent to stack on board
 */
get_empty_adjacents(Board, Position, Adjacents) :-
    directions(Directions),
    get_empty_adjacents(Board, Position, Directions, [], Adjacents), !.

get_empty_adjacents(_, _, [], Adjacents, Adjacents) :- !.
get_empty_adjacents(Board, [Row, Column], [[RowInc, ColInc] | Rest], Acc, Adjacents) :-
    NewRow is Row + RowInc,
    NewCol is Column + ColInc, !,
    (
        valid_position(Board, [NewRow, NewCol], Piece),
        Piece =:= 0,
        append(Acc, [[NewRow, NewCol]], NewAcc)
        ;
        NewAcc = Acc
    ),
    get_empty_adjacents(Board, [Row, Column], Rest, NewAcc, Adjacents), !.

get_all_moves(Board, Position, Adjacents) :-
    directions(Directions),
    get_all_moves(Board, Position, Directions, [], Adjacents), !.

get_all_moves(_, _, [], Adjacents, Adjacents) :- !.
get_all_moves(Board, [Row, Column], [[RowInc, ColInc] | Rest], Acc, Adjacents) :-
    NewRow is Row + RowInc,
    NewCol is Column + ColInc, !,
    direction(Dir, RowInc, ColInc),
    (
        valid_position(Board, [NewRow, NewCol], Piece),
        Piece =:= 0,
        append(Acc, [[Row, Column, Dir]], NewAcc)
        ;
        NewAcc = Acc
    ),
    get_all_moves(Board, [Row, Column], Rest, NewAcc, Adjacents), !.
