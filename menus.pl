/* waldmeister_logo/0 is a predicate that is responsible for showing the waldmeister logo in ASCII ART */
waldmeister_logo:-
write(' ##      ##    ##    ##    ##    ###       ##     ##   ####   #   ###   #####  ####   ###       \n'),
write('  ##   ## ##  ##   ##  ##  ##    #  #    ####   ####   # __   |    #  #   #    # __   #  #      \n'),
write('   ## ##  ## ##    ######  ##    #   #  ##  ## ##  ##  #      |  # ##     #    #      # ##       \n '),
write('    ##      ##     ##  ##  ##### ####  #    ##     #   ####   |  ###      #    ####   ##  #  \n').

clear:- write('\33\[2J'). /* This predicate clears the terminal view for better UX. */

start_main_menu:-clear,	waldmeister_logo,view_main_menu. % add repeat
<<<<<<< HEAD
/*
option_main_menu('1',"Human/Human"):- .
option_main_menu('2',"Human/PC"):- .
option_main_menu('3',"PC/PC"):-.
option_main_menu('4',"Instructions"):-.
option_main_menu('5',"Credits"):-.
option_main_menu('6',"Quit"):-.
*/
view_main_menu:-clear,
	waldmeister_logo,
	write("1. Human/Human\n"),
	write("2. Human/PC\n"),
	write("3. PC/PC\n"),
	write("4. Instructions\n"),
	write("5. Credits\n"),
	write("6. Quit\n"),
	get_option(Option),
	handle_option(Option).

get_option(Option):-get_char(Option).
handle_option(_):-view_main_menu.
/*
handle_option('1'):-.
handle_option('2'):-.
handle_option('3'):-.
handle_option('4'):-.
handle_option('5'):-.
handle_option('6'):-.
*/
=======

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



>>>>>>> 031157edd2efe2d1a981c62bb9e16eddb15a32ac
	
