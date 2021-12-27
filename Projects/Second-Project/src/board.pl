get_piece(Board, [NRow, NColumn], Piece) :-
    get_row(Board, NRow, Row),
    get_value(Row, NColumn, Piece).

get_row([Current | _ ], 0, Current).
get_row([_ | Rest], NRow, Row) :-
    NRow > 0,
    N is NRow - 1,
    get_row(Rest, N, Row).

get_value([CurrentValue | _ ], 0, CurrentValue).
get_value([ _ | Rest ], NCol, Value) :-
    NCol > 0,
    N is NCol - 1,
    get_value(Rest, N, Value).
