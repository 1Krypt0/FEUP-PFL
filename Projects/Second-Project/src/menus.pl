/*
* menu
*
* Launches the Main Menu
*/
menu :-
    repeat,
    display_main_menu,
    read_number(Option),
    separator,
    choose_menu_option(Option).


/*
* choose_menu_option(+Option)
*
* Chooses menu based on option entered
*
* Main menu options
* 0 - Exit
* 1 - Player vs Player (pvp)
* 2 - Player vs Computer (pvc)
* 3 - Computer vs Computer (cvc)
*/
choose_menu_option(0).
choose_menu_option(1) :- display_pvp_title, playPvP, !, fail.
choose_menu_option(2) :- pvc_menu, nl, !, fail.
choose_menu_option(3) :- cvc_menu, nl, !, fail.
choose_menu_option(_) :- write('                             Invalid Option!'), nl, !, fail.


/*
* pvc_menu
*
* Launches Player vs Computer Menu
* Chooses a difficulty and starts to play against a bot
*/
pvc_menu :-
    display_pvc_menu,
    readBotDifficulty(Bot),
    (
        Bot = 0
        ;
        display_pvc_title(Bot),
        playPvC(Bot)
    ).

/*
* cvc_menu
*
* Launches Computer vs Computer Menu
* Chooses the difficulties and starts to play a bot against bot game
*/
cvc_menu :-
    display_cvc_menu,
    readBotDifficulty(Bot1),
    (
        Bot1 = 0
        ;
        readBotDifficulty(Bot2),
        (
            Bot2 = 0
            ;
            display_cvc_title(Bot1-Bot2),
            playCvC(Bot1, Bot2)
        )
    ).


/*
*readBotDifficulty(-Difficulty)
*
* Read a difficulty from the input
*/
readBotDifficulty(Difficulty) :-
    repeat,
    display_difficulty_menu,
    read_number(Difficulty),
    separator,
    choose_difficulty_option(Difficulty).


/*
* choose_difficulty_option(+Difficulty)
*
* Validates the difficulty options
*
* Bot difficulty options
* 0 - Back
* 1 - Easy (Random)
* 2 - Hard (Greedy)
*/
choose_difficulty_option(0).
choose_difficulty_option(1).
choose_difficulty_option(2).
choose_difficulty_option(_) :- write('                             Invalid Option!'), nl, !, fail.


/*
* display_main_menu
*
* Displays the main menu
*/
display_main_menu :-
    separator, nl,
    write('                         ____  __.                     '), nl,
    write('                        |    |/ _|____   ____   ____    '), nl,
    write('                        |       </  _ \\ /    \\ /  _ \\   '), nl,
    write('                        |    |  (  <_> )   |  (  <_> )  '), nl,
    write('                        |____|__ \\____/|___|  /\\____/   '), nl,
    write('                                \\/          \\/          '), nl, nl,
    write('                           1. Player vs Player                           '), nl,
    write('                          2. Player vs Computer                          '), nl,
    write('                         3. Computer vs Computer                         '), nl,
    write('                                 0. Exit                                 '), nl,
    separator, write('                               Option: ').


/*
* display_pvc_menu
*
* Displays Player vs Computer header
*/
display_pvc_menu :-
    nl, write('                            Player vs Computer                           '), nl, nl.


/*
* display_cvc_menu
*
* Displays Computer vs Computer header
*/
display_cvc_menu :-
    nl, write('                           Computer vs Computer                          '), nl, nl.


/*
* display_difficulty_menu
*
* Displays menu to choose bot difficulty
*/
display_difficulty_menu :-
    write('                          Choose Bot Difficulty                          '), nl, nl,
    write('                                 1. Easy                                 '), nl,
    write('                                 2. Hard                                 '), nl, nl,
    write('                                 0. Back                                 '), nl,
    separator, write('                               Option: ').


/*
* display_pvp_title
*
* Displays Player vs Player title
*/
display_pvp_title :- separator, write('                             Player vs Player'), nl, separator.


/*
* display_cvc_title(+Bot1Option, +Bot2Option)
*
* Displays Computer vs Computer options
*/
display_cvc_title(1-1) :- separator, write('                               Easy vs Easy'), nl, separator.
display_cvc_title(1-2) :- separator, write('                               Easy vs Hard'), nl, separator.
display_cvc_title(2-1) :- separator, write('                               Hard vs Easy'), nl, separator.
display_cvc_title(2-2) :- separator, write('                               Hard vs Hard'), nl, separator.
