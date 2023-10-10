/* waldmeister_logo/0 is a predicate that is responsible for showing the waldmeister logo in ASCII ART */
waldmeister_logo:-
write(' ##      ##    ##    ##    ##    ###       ##     ##   ####   #   ###   #####  ####   ###       \n'),
write('  ##   ## ##  ##   ##  ##  ##    #  #    ####   ####   # __   |    #  #   #    # __   #  #      \n'),
write('   ## ##  ## ##    ######  ##    #   #  ##  ## ##  ##  #      |  # ##     #    #      # ##       \n '),
write('    ##      ##     ##  ##  ##### ####  #    ##     #   ####   |  ###      #    ####   ##  #  \n').

clear:- write('\33\[2J'). /* This predicate clears the terminal view for better UX. */

start_main_menu:-clear,	waldmeister_logo,view_main_menu. % add repeat

/* Both difficulties for Human/PC game */
difficulty(1,'Easy').
difficulty(2,'Hard').

/* type_of_game/2 is a predicate that shows the types of games that can be played in the game */
type_of_game('1','Human/Human').
type_of_game('2','Human/PC').
type_of_game('3','PC/PC').

helps('4','Instructions').
helps('5','Credits').
helps('6','Quit').

% Define game options and menu options separately.
game_option(X, Y) :- type_of_game(X, Y).
menu_option(X, Y) :- helps(X, Y).

% Combine game options and menu options into a single list.
option_main_menu(X, OptionText) :- all_options(Options), member(X-OptionText, Options).

view_main_menu :-
    clear,
    waldmeister_logo,
    write('Available Options:\n'),
    option_main_menu(X, OptionText), % Use option_main_menu to print options
    nl,
    format('~w. ~w~n', [X, OptionText]),
    nl,% Format and print the option
    get_option(Option),
    nl,
    handle_option(Option).

get_option(Option):-get_char(Option).

handle_option(Option) :-
    (Option >= '1', Option =< '3' ->
        start_game(Option)
    ; Option >= '4', Option =< '6' ->
	view_main_menu % change this line.
    ;
        view_main_menu
    ).



	
