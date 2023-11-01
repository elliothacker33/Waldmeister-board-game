box_char(horizontal, 0x2500).
box_char(vertical, 0x2502).
box_char(top_left, 0x250C).
box_char(top_right, 0x2510).
box_char(bottom_left, 0x2514).
box_char(bottom_right, 0x2518).
box_char(connector, 0x2534).
box_char(connector2, 0x252C).


/* waldmeister_logo/0 is a predicate that is responsible for showing the waldmeister logo in ASCII ART */
waldmeister_logo:-
    format('~*c', [12, 32]),
    format('\e[38;5;208m~w\e[0m', [' ##      ##    ##    ##    ##    ###       ##     ##   ####   #   ###   #####  ####   ###   ']),
    print_newline(1),
    format('~*c', [12, 32]),
    format('\e[38;5;208m~w\e[0m', ['  ##   ## ##  ##   ##  ##  ##    #  #    ####   ####   # __   |    #  #   #    # __   #  #  ']),
    print_newline(1),
    format('~*c', [12, 32]),
    format('\e[38;5;208m~w\e[0m', ['   ## ##  ## ##    ######  ##    #   #  ##  ## ##  ##  #      |  # ##     #    #      # ##  ']),
    print_newline(1),
    format('~*c', [12, 32]),
    format('\e[38;5;208m~w\e[0m', ['    ##      ##     ##  ##  ##### ####  #    ##     #   ####   |  ###      #    ####   ##  # ']),
    print_newline(1).

display_aux_options_vertical(V):-
    print_newline(1),
    format('~*c', [40, 32]),
    format('~c',[V]),
    format('~*c', [35, 32]),
    format('~c',[V]),
    print_newline(1).
display_aux_options_first_line(TL,H,TR):-
     format('~*c', [40, 32]),
     format('~c',[TL]),
     format('~*c', [35, H]),
     format('~c',[TR]).
display_aux_options_last_line(BL,H,BR):-
    format('~*c', [40, 32]),
    format('~c',[BL]),
    format('~*c', [35, H]),
    format('~c',[BR]).
display_choose(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('    Choose your option from 1-6    '),
    format('~c',[V]).
display_option_1(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['1']),
    write(' Human/Human             '),
    format('~c',[V]).

display_option_2(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['2']),
    write(' Human/PC                '),
    format('~c',[V]).
display_option_3(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['3']),
    write(' PC/PC                   '),
    format('~c',[V]).
display_option_4(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['4']),
    write(' Instructions            '),
    format('~c',[V]).
display_option_5(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['5']),
    write(' Credits                 '),
    format('~c',[V]).

display_option_6(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['6']),
    write(' Quit                    '),
    format('~c',[V]).

/* clear/0 is a predicate that is responsible to clear the screen */
clear:-
   write('\e[H\e[2J\n\n').

/* print_newline/1 is a predicate that prints N times the newline*/
print_newline(0):-!.
print_newline(N):-
    N1 is N-1,
    print_newline(N1),
    nl.

/* print_options/2 is a predicate that prints the main menu option */
print_options:-
    box_char(horizontal,H),
    box_char(vertical,V),
    box_char(top_right,TR),
    box_char(top_left,TL),
    box_char(bottom_right,BR),
    box_char(bottom_left,BL),
    display_aux_options_first_line(TL,H,TR),
    display_aux_options_vertical(V),
    display_choose(V),
    display_aux_options_vertical(V),
    display_option_1(V),
    display_aux_options_vertical(V),
    display_option_2(V),
    display_aux_options_vertical(V),
    display_option_3(V),
    display_aux_options_vertical(V),
    display_option_4(V),
    display_aux_options_vertical(V),
    display_option_5(V),
    display_aux_options_vertical(V),
    display_option_6(V),
    display_aux_options_vertical(V),
    display_aux_options_last_line(BL,H,BR).




/*repeat_ask_difficulty/1 is a predicate that keeps asking difficulty if the values are not in the range specified*/
repeat_ask_difficulty(Difficulty):-
    askDifficulty(Difficulty),
    print_newline(2),
    (Difficulty == 1 ; Difficulty == 2), !.

repeat_ask_difficulty(Difficulty):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid difficulty. Please enter 1 or 2.\e[0m', []),
    print_newline(2),
    repeat_ask_difficulty(difficulty).

/* askDifficulty/1 asks for a game difficulty input */ 
askDifficulty(Y):-
    format('~*c', [45, 32]),
    write('1- PC Easy mode, 2- PC Hard mode'),
    print_newline(2),
    format('~*c', [45, 32]),
    write('Insert PC Difficulty: '),
    read(Y).

/*repeat_ask_goal/1 is a predicate that keeps asking difficulty if the values are not in the range specified*/
repeat_ask_goal(Goal,Name):-
    askGoal(Goal,Name),
    print_newline(2),
    (Goal == 1 ; Goal == 2), !.

repeat_ask_goal(Goal,Name):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid goal. Please enter 1 or 2.\e[0m', []),
    print_newline(2),
    repeat_ask_goal(Goal,Name).

/* askGoal/1 asks for a goal input */ 
askGoal(Goal,Name):- 
    format('~*c', [40, 32]),
    write('1- Play for Colors 2- Play for Heights'),
    print_newline(2),
    format('~*c', [45, 32]),
    write(Name),
    write(' please insert your goal : '),
    read(Goal).

/* askName/1 asks for a name input */ /*  Make this accept UpperCase */
askName(Name):-
    format('~*c', [45, 32]),
    write('Insert your name: '),
    read(Name).

/*repeat_ask_option/1 is a predicate that keeps asking difficulty if the values are not in the range specified*/
repeat_ask_option(Option):-
    askOption(Option),
    print_newline(2),
    (Option >=1 , Option =< 6), !,
    handle_option(Option).

repeat_ask_option(Option):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid option. Please enter 1-6 number.\e[0m', []),
    print_newline(2),
    repeat_ask_option(Option).

/* askOption/1 asks for an option input */ 
askOption(Option):-
    format('~*c', [45, 32]),
    write('Insert option from 1-6: '),
    read(Option).
    

/* handle_option/1 is a predicate that shows the respective functionalities for each menu */
handle_option(1):-
    askName(Name1),
    print_newline(1),
    askName(Name2),
    print_newline(2),
    repeat_ask_goal(Goal,Name1),
    print_newline(1),
    initial_state_size(1,InitialState),
    !,
    (Goal == 1 ->
        play_game(InitialState, (1, Name1, Goal), (2, Name2, 2))
    ;
        play_game(InitialState, (1, Name1, Goal), (2, Name2, 1))
    ),
    view_main_menu.

    

handle_option(2):-
    askName(Name1),
    repeat_ask_goal(Goal),
    repeat_ask_difficulty(Difficulty),
    (Goal == 1 -> 
    play_game(InitialState,(1,Name1,Goal),(2,Difficulty,2))
    ;
    play_game(InitialState,(1,Name1,2),(2,Difficulty,Goal))),
    view_main_menu. 

handle_option(3):-
    repeat_ask_difficulty(Difficulty1),
    repeat_ask_difficulty(Difficulty2),
    play_game(InitialState,(1,Difficulty1,1),(2,Difficulty2,2)),
    view_main_menu.

handle_option(4):-
    instructions,view_main_menu.

handle_option(5):-
    credits,view_main_menu.

handle_option(6):-
    halt.

/* view_main_menu/1 shows the main menu to the user */
view_main_menu:-
    clear,
    waldmeister_logo,
    print_newline(1),
    print_options,
    print_newline(3),
    !,
    repeat_ask_option(Option).

