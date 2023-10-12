/* waldmeister_logo/0 is a predicate that is responsible for showing the waldmeister logo in ASCII ART */
waldmeister_logo:-
write(' ##      ##    ##    ##    ##    ###       ##     ##   ####   #   ###   #####  ####   ###       \n'),
write('  ##   ## ##  ##   ##  ##  ##    #  #    ####   ####   # __   |    #  #   #    # __   #  #      \n'),
write('   ## ##  ## ##    ######  ##    #   #  ##  ## ##  ##  #      |  # ##     #    #      # ##       \n '),
write('    ##      ##     ##  ##  ##### ####  #    ##     #   ####   |  ###      #    ####   ##  #  \n').

clear:- write('\33\[2J'). /* This predicate clears the terminal view for better UX. */
 
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

% Define a predicate to print all type_of_game options with formatting.
print_type_of_game_options :-
    findall(X, (type_of_game(Id, X), format('~w: ~w~n', [Id, X])), GameOptions).

% Define a predicate to print all helps options with formatting.
print_helps_options :-
    findall(Y, (helps(Id, Y), format('~w: ~w~n', [Id, Y])), MenuOptions).

% Define a predicate to print all options.
print_options :-
    print_type_of_game_options,
    print_helps_options.


handle_option(1) :-
    view_main_menu.

handle_option(2) :-
    view_main_menu.

handle_option(3) :-
    view_main_menu.

handle_option(4) :-
    view_main_menu.

handle_option(5) :-
    view_main_menu.

handle_option(6) :-
    view_main_menu.

handle_option(_Other):-
    write('\nERROR: that option does not exist.\n\n'),
    write('Insert option from 1-6: \n'),
    get_option(Option),
    handle_option(Option).
get_option(Option):-
    get_char(Input),
    get_char(_),
    char_to_number(Input,Option).
view_main_menu :-
    nl,
    waldmeister_logo,
    nl,
    write('Available Options\n'),
    print_options, % Use option_main_menu to print options
    nl,
    write('Insert option from 1-6: \n'),
    get_option(Option),
    handle_option(Option).

