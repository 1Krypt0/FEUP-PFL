:- include('utils.pl').
/**
 * Write a separation line
 */
separator :- write('========================================================================='), nl.


/**
 * Clear the console
 */
clear :- write('\33\[2J').

/**
 * Press enter to continue
 */
pause :- write('Press enter to continue... '), skip_line.

/**
 *  Symbol of the player
 *  player_symbol/2
 *  player_symbol(Player, ?Symbol)
 *
 *  Player      Player Identifier
 *  Symbol      Symbol associated with the player
 */
player_symbol(0, '0').
player_symbol(1, '1').
player_symbol(2, '2').

/**
 *  Print Column Numbers
 */
print_column_numbers :-
    clear,
    write('        0   1   2   3   4'), nl, !.


/**
 *  Displays the game
 */
display_game(Board, Player) :-
    print_column_numbers, nl,
    print_board(Board, 0), nl,
    print_player_turn(Player), nl, nl.

/**
 *  Displays the top line of the board board
 */
print_board([], _) :-
    print_spacing(7),
    print_divisor.
print_board([Line | Rest], Row) :-
    print_line(Line, Row),  nl,
    NextRow is Row + 1,
    print_board(Rest, NextRow).

/**
 * Prints a line of the board
 */
print_line(Line, Row) :-
    letter(Row, Symbol),
    print_spacing(7),
    print_divisor, nl,
    write(Symbol),
    print_spacing(6),
    print_cells(Line).

print_divisor :-
    write(' --- --- --- --- ---').

/**
 *  Prints the cell's content
 *  print_cell/1
 *  print_cell(Cell)
 *
 *  Cell        Cell to be displayed
 */
print_cells([]) :-
    write('|').

print_cells([Cell | Rest]) :-
    player_symbol(Cell, PlayerSymbol),
    write('|'), format(' ~w~|~`0t ', PlayerSymbol),
    print_cells(Rest).


/**
 *  Prints N white spaces
 *  print_spacing/1
 *  print_spacing(Length)
 *
 *  Length      Number of white spaces to print
 */
print_spacing(0) :- !.

print_spacing(Length) :-
    Length > 0, NewLength is Length - 1, write(' '), !,
    print_spacing(NewLength).



print_player_turn(Player) :-
    write( '   /=============================\\'), nl,
    format('   |        Player ~d Turn        |', Player), nl,
    write( '   \\=============================/').
