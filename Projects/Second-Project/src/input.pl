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
read_direction(Direction, PositionMoves, DirectionMoves) :-
    repeat,
    write('-> Enter Direction\n0 - NW\t1 - NE\t2 - SW\t3 - SE\nOption: '),
    read_number(Direction),
    (
        validate_direction(Direction, PositionMoves, DirectionMoves), !
        ;
        write('Invalid direction! Cannot move in that direction!\n'), fail
    ), !.

/**
 * Reads a move from input
 */
read_move(Board, Player, [NRow, NColumn, Direction, NStacks, Stacks]) :-
    write('========================================================================='), nl,
    write('                        Selecting a stack to move                        '), nl,
    write('-------------------------------------------------------------------------'), nl,
    read_position(Board, Player, NRow, NColumn, PositionMoves), !,
    read_direction(Direction, PositionMoves, DirectionMoves), !,
    read_substack_divisions(NStacks, Stacks, DirectionMoves), !.


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
validate_direction(Direction, PositionMoves, DirectionMoves) :-
    direction(Direction, _, _), !,
    bagof(
        Stacks,
        Direction ^ NStacks ^
        (
            member([Direction, NStacks, Stacks], PositionMoves)
        ),
        DirectionMoves
    ),
    length(DirectionMoves, NMoves), !,
    NMoves > 0.


/**
 * Checks if a position is valid or not
 */
validate_position(Board, RowLetter, Row, Column) :-
    letter(Row, RowLetter), !,
    valid_position(Board, [Row, Column], Piece),
    Piece =:= 0.
