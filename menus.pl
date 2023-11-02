% READY FOR FINAL REVIEW



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


display_difficulty_title(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('      Choose the AI difficulty     '),
    format('~c',[V]).

display_difficulty_1(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['1']),
    write(' Easy                    '),
    format('~c',[V]).
display_difficulty_2(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['2']),
    write(' Hard                    '),
    format('~c',[V]).

print_difficulty_menu:-
    box_char(horizontal,H),
    box_char(vertical,V),
    box_char(top_right,TR),
    box_char(top_left,TL),
    box_char(bottom_right,BR),
    box_char(bottom_left,BL),
    display_aux_options_first_line(TL,H,TR),
    display_aux_options_vertical(V),
    display_difficulty_title(V),
    display_aux_options_vertical(V),
    display_difficulty_1(V),
    display_aux_options_vertical(V),
    display_difficulty_2(V),
    display_aux_options_vertical(V),
    display_aux_options_last_line(BL,H,BR).

display_goal_title(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('      Player 1 choose your goal    '),
    format('~c',[V]).

display_goal_1(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['1']),
    write(' Heights                 '),
    format('~c',[V]).
display_goal_2(V):-
    format('~*c', [40, 32]),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['2']),
    write(' Colors                  '),
    format('~c',[V]).
print_goal_menu:-
    box_char(horizontal,H),
    box_char(vertical,V),
    box_char(top_right,TR),
    box_char(top_left,TL),
    box_char(bottom_right,BR),
    box_char(bottom_left,BL),
    display_aux_options_first_line(TL,H,TR),
    display_aux_options_vertical(V),
    display_goal_title(V),
    display_aux_options_vertical(V),
    display_goal_1(V),
    display_aux_options_vertical(V),
    display_goal_2(V),
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
    print_newline(2),
    format('~*c', [45, 32]),
    write('Insert AI Difficulty: '),
    read(Y).

/*repeat_ask_goal/1 is a predicate that keeps asking difficulty if the values are not in the range specified*/
repeat_ask_goal(Goal):-
    askGoal(Goal),
    print_newline(2),
    (Goal == 1 ; Goal == 2), !.

repeat_ask_goal(Goal):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid goal. Please enter 1 or 2.\e[0m', []),
    print_newline(2),
    repeat_ask_goal(Goal).

/* askGoal/1 asks for a goal input */ 
askGoal(Goal):- 
    format('~*c', [45, 32]),
    write(' Insert your goal : '),
    read(Goal).

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
    
repeat_ask_size(Size):-
    askSize(Size),
    print_newline(2),
    (Size >= 8 ), !.

repeat_ask_size(Size):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid option. Please enter 1-6 number.\e[0m', []),
    print_newline(2),
    repeat_ask_size(Size).

/* askOption/1 asks for an option input */ 
askSize(Size):-
    format('~*c', [45, 32]),
    write('Insert size (8 is default): '),
    read(Size).
    

/* handle_option/1 is a predicate that shows the respective functionalities for each menu */
handle_option(1):-
    print_goal_menu,
    print_newline(2),
    repeat_ask_goal(Goal),
    print_newline(1),
    repeat_ask_size(Size),
    clear,
    initial_state(Size,InitialState),
    !,
    (Goal == 1 ->
        play_game(InitialState, (1,-1, Goal), (2,-1, 2))
    ;
        play_game(InitialState, (1,-1,Goal), (2,-1, 1))
    ),
    view_main_menu
.

    
/* DONE */
handle_option(2):-
    print_goal_menu,
    print_newline(2),
    repeat_ask_goal(Goal),
    print_newline(2),
    print_difficulty_menu,
    print_newline(2),
    repeat_ask_difficulty(Difficulty),
    print_newline(2),
    repeat_ask_size(Size),
    clear,
    initial_state(Size,InitialState),

    (Goal == 1 -> 
    play_game(InitialState,(1,-1,Goal),(2,Difficulty,2))
    ;
    play_game(InitialState,(1,-1,2),(2,Difficulty,Goal))),
    view_main_menu
. 
/* DONE */
handle_option(3):-
    print_difficulty_menu,
    print_newline(2),
    repeat_ask_difficulty(Difficulty1),
    print_difficulty_menu,
    print_newline(2),
    repeat_ask_difficulty(Difficulty2),
    repeat_ask_size(Size),
    clear,
    initial_state(Size,InitialState),
    play_game(InitialState,(1,Difficulty1,1),(2,Difficulty2,2)),
    view_main_menu.

/*DONE*/
handle_option(4):-
    instructions,view_main_menu.
/*DONE*/
handle_option(5):-
    credits,view_main_menu.
/* DONE*/
handle_option(6):-
    halt.


/* DONE */
/* view_main_menu/1 shows the main menu to the user */
view_main_menu:-
    clear,
    waldmeister_logo,
    print_newline(1),
    print_options,
    print_newline(3),
    !,
    repeat_ask_option(Option).

