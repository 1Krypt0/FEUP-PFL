/*
* separator
*
* Write a separation line
*/
separator :- write('========================================================================='), nl.


/*
* clear
*
* Clear the console
*/
clear :- write('\33\[2J').

/*
* pause
*
* Creates a Press enter to continue action
*/
pause :- write('Press enter to continue... '), skip_line.

/*
* player_symbol(?PlayerInteger, ?PlayerChar)
*
* Converts the player number to a character
*/
player_symbol(0, '0').
player_symbol(1, '1').
player_symbol(2, '2').

/*
* print_column_numbers
*
*  Prints the column numbers
*/
print_column_numbers :-
    clear,
    write('         0   1   2   3   4'), nl, !.


/*
* display_game(+Board, +Player)
*
*  Displays the current game state
*/
display_game(Board, Player) :-
    print_column_numbers, nl,
    print_board(Board, 0), nl,
    print_player_turn(Player), nl, nl.

/*
* print_board(+Board, +Row)
*
*  Displays the board and the row letter
*/
print_board([], _) :-
    print_spacing(7),
    print_divisor.
print_board([Line | Rest], Row) :-
    print_line(Line, Row),  nl,
    NextRow is Row + 1,
    print_board(Rest, NextRow).

/*
* print_line(+Line, +Row)
*
* Prints a line of the board
*/
print_line(Line, Row) :-
    letter(Row, Symbol),
    print_spacing(7),
    print_divisor, nl,
    write(Symbol),
    print_spacing(6),
    print_cells(Line).

/*
* print_divisor
*
* Prints a divisor between the different rows
*/
print_divisor :-
    write(' --- --- --- --- ---').

/*
* print_cells(+Row)
*
* Prints the cells from a Row
*/
print_cells([]) :-
    write('|').
print_cells([Cell | Rest]) :-
    player_symbol(Cell, PlayerSymbol),
    write('|'), format(' ~w~|~`0t ', PlayerSymbol),
    print_cells(Rest).

/*
* print_spacing(+Amount)
*
* Prints Amount spaces, to evenly spread the board
*/
print_spacing(0) :- !.
print_spacing(Length) :-
    Length > 0, NewLength is Length - 1, write(' '), !,
    print_spacing(NewLength).

/*
* print_player_turn(+Player)
*
* Prints the current Player to the game interface
*/
print_player_turn(Player) :-
    write( '   /=============================\\'), nl,
    format('   |        Player ~d Turn        |', Player), nl,
    write( '   \\=============================/').
