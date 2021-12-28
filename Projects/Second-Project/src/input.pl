/**
 * Reads a number from input (0-9)
 */
read_number(Number) :-
    get_code(Code), skip_line,
    Code >= 48, Code < 58,
    Number is Code - 48.


/**
 * Reads a letter from input (a-Z)
 */
read_char(Char) :-
    get_code(Code), skip_line,
    UppercaseCode is Code /\ \(32),
    UppercaseCode >= 65, UppercaseCode < 91,
    char_code(Char, UppercaseCode).

/**
 * Reads a valid position from input
 */
read_position(Board, Player, Row, Column, Moves) :-
    repeat,
    write('-> Enter Row (A-E): '),
    read_char(RowLetter),
    write('-> Enter Column (0-4): '),
    read_number(Column),
    (
        validate_position(Board, Player, RowLetter, Row, Column)
        ;
        write('Invalid position!\nPlease choose again:\n'), fail
    ),
    (
        get_empty_adjacents(Board, [Row, Column], Moves),
        length(Moves, NMoves),
        NMoves > 0, !
        ;
        write('There are no available moves for this piece! '), fail
    ), !.

/**
 * Reads a direction from input
 */
read_direction(Direction, CurrentPos, PossibleMoves) :-
    repeat,
    write('-> Enter Direction\n0 - NW\t1 - NE\t2 - SW\t3 - SE\nOption: '),
    read_number(Direction),
    (
        validate_direction(Direction, CurrentPos, PossibleMoves), !
        ;
        write('Invalid direction! Cannot move in that direction!\n'), fail
    ), !.

/**
 * Reads a move from input
 */
read_move(Board, Player, [NRow, NColumn, Direction ]) :-
    write('========================================================================='), nl,
    write('                        Selecting a cube to move                        '), nl,
    write('-------------------------------------------------------------------------'), nl,
    read_position(Board, Player, NRow, NColumn, PositionMoves), !,
    read_direction(Direction, [NRow, NColumn], PositionMoves), !.


/**
 * Reads a placing from input
 */
read_placing(Board, [NRow, NColumn]) :-
    write('========================================================================='), nl,
    write('                        Selecting a cell to place                        '), nl,
    write('-------------------------------------------------------------------------'), nl,
    read_empty_position(Board, NRow, NColumn),
    write('========================================================================='), nl, nl, !.


/**
 * Checks if a direction is valid or not according to the available moves
 */
validate_direction(Direction, [CurrentRow, CurrentCol], PositionMoves) :-
    direction(Direction, RowIncrement, ColumnIncrement),
    DestinationRow is CurrentRow + RowIncrement,
    DestinationColumn is CurrentCol + ColumnIncrement,
    member([DestinationRow, DestinationColumn], PositionMoves).

/**
 * Checks if a position is valid or not
 */
validate_position(Board, Player, RowLetter, Row, Column) :-
    letter(Row, RowLetter), !,
    valid_position(Board, Player, [Row, Column], Piece),
    Piece =:= Player.

/**
 * Announce the winner
 */
announce(1, Player) :-
    next_player(Player, Next),
    clear,
    separator, nl,
    format('                              Player ~d Won                             ', Next), nl, nl,
    separator.

announce(2, Player) :-
    next_player(Player, Next),
    clear,
    separator, nl,
    format('                              Player ~d Won                             ', Next), nl, nl,
    separator.

announce(0, _) :-
    clear,
    separator, nl,
    write("                              It's a Draw                             "), nl, nl,
    separator.
