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


