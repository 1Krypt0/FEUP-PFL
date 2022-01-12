/**
 * Main menu
 */
menu :-
    repeat,
    display_main_menu,
    read_number(Option),
    separator,
    choose_menu_option(Option).


/**
 * Main menu options
 * 0 - Exit
 * 1 - Player vs Player (pvp)
 * 2 - Player vs Computer (pvc)
 * 3 - Computer vs Computer (cvc)
 */
choose_menu_option(0).
choose_menu_option(1) :- display_pvp_title, playPvP, !, fail.
choose_menu_option(2) :- pvc_menu, nl, !, fail.
choose_menu_option(_) :- write('                             Invalid Option!'), nl, !, fail.


/**
 * Player vs Computer Menu
 * Chooses a difficulty and plays against a bot
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


/**
 * Read a difficulty
 */
readBotDifficulty(Difficulty) :-
    repeat,
    display_difficulty_menu,
    read_number(Difficulty),
    separator,
    choose_difficulty_option(Difficulty).


/**
 * Bot difficulty options
 * 0 - Back
 * 1 - Easy (Random)
 * 2 - Hard (Greedy)
 */
choose_difficulty_option(0).
choose_difficulty_option(1).
choose_difficulty_option(2).
choose_difficulty_option(_) :- write('                             Invalid Option!'), nl, !, fail.


/**
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
    write('                                 0. Exit                                 '), nl,
    separator, write('                               Option: ').


/**
 * Displays Player vs Computer header
 */
display_pvc_menu :-
    nl, write('                            Player vs Computer                           '), nl, nl.


/**
 * Displays menu to choose bot difficulty
 */
display_difficulty_menu :-
    write('                          Choose Bot Difficulty                          '), nl, nl,
    write('                                 1. Easy                                 '), nl,
    write('                                 2. Hard                                 '), nl, nl,
    write('                                 0. Back                                 '), nl,
    separator, write('                               Option: ').


/**
 * Displays Player vs Player title
 */
display_pvp_title :- separator, write('                             Player vs Player'), nl, separator.


/**
 * Displays Player vs Computer title
 */
display_pvc_title(1) :- separator, write('                                   Easy'), nl, separator.
display_pvc_title(2) :- separator, write('                                   Hard'), nl, separator.
