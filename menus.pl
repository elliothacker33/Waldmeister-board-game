box_char(horizontal, 0x2500).
box_char(vertical, 0x2502).
box_char(top_left, 0x250C).
box_char(top_right, 0x2510).
box_char(bottom_left, 0x2514).
box_char(bottom_right, 0x2518).

/* waldmeister_logo/0 is a predicate that is responsible for showing the waldmeister logo in ASCII ART */
waldmeister_logo:-
center_text(' ',12),
format('\e[38;5;208m~w\e[0m', [' ##      ##    ##    ##    ##    ###       ##     ##   ####   #   ###   #####  ####   ###   ']),
print_newline(1),
center_text(' ',12),
format('\e[38;5;208m~w\e[0m', ['  ##   ## ##  ##   ##  ##  ##    #  #    ####   ####   # __   |    #  #   #    # __   #  #  ']),
print_newline(1),
center_text(' ',12),
format('\e[38;5;208m~w\e[0m', ['   ## ##  ## ##    ######  ##    #   #  ##  ## ##  ##  #      |  # ##     #    #      # ##  ']),
print_newline(1),
center_text(' ',12),
format('\e[38;5;208m~w\e[0m', ['    ##      ##     ##  ##  ##### ####  #    ##     #   ####   |  ###      #    ####   ##  # ']),
print_newline(1).

/* clear/0 is a predicate that is responsible to clear the screen */
clear:-
   write('\e[H\e[2J\n\n').

/* print_newline/1 is a predicate that prints N times the newline*/
print_newline(0):-!.
print_newline(N):-
    N1 is N-1,
    print_newline(N1),
    nl.
/* center_text/2 is a predicate that prints the character Ch, N times */
center_text(_,0):-!.
center_text(Ch,N):-
    N1 is N-1,
    center_text(Ch,N1),
    write(Ch).

/* print_options/2 is a predicate that prints the main menu option */
print_options:-
    center_text(' ',40),
    box_char(horizontal,H),
    box_char(vertical,V),
    box_char(top_right,TR),
    box_char(top_left,TL),
    box_char(bottom_right,BR),
    box_char(bottom_left,BL),
    format('~c',[TL]),
    format('~*c', [35, H]),
    format('~c',[TR]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    center_text(' ',35),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    write('    Choose your option from 1-6    '),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    center_text(' ',35),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['1']),
    write(' Human/Human             '),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    center_text(' ',35),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['2']),
    write(' Human/PC                '),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    center_text(' ',35),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['3']),
    write(' PC/PC                   '),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    center_text(' ',35),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['4']),
    write(' Instructions            '),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    center_text(' ',35),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['5']),
    write(' Credits                 '),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    center_text(' ',35),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    write('         '),
    format('\e[38;5;208m~w\e[0m',['6']),
    write(' Quit                    '),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[V]),
    center_text(' ',35),
    format('~c',[V]),
    print_newline(1),
    center_text(' ',40),
    format('~c',[BL]),
    format('~*c', [35, H]),
    format('~c',[BR]).


/*repeat_ask_difficulty/1 is a predicate that keeps asking difficulty if the values are not in the range specified*/
repeat_ask_difficulty(Difficulty):-
    askDifficulty(Difficulty),
    print_newline(2),
    (Difficulty == 1 ; Difficulty == 2), !.

repeat_ask_difficulty(Difficulty):-
    center_text(' ',40),
    format('\e[47m\e[31mERROR: Invalid difficulty. Please enter 1 or 2.\e[0m', []),
    print_newline(2),
    repeat_ask_difficulty(difficulty).

/* askDifficulty/1 asks for a game difficulty input */ 
askDifficulty(Y):-
    center_text(' ',45),
    write('1- PC Easy mode, 2- PC Hard mode'),
    print_newline(2),
    center_text(' ',45),
    write('Insert PC Difficulty: '),
    read(Y).

/*repeat_ask_goal/1 is a predicate that keeps asking difficulty if the values are not in the range specified*/
repeat_ask_goal(Goal,Name):-
    askGoal(Goal,Name),
    print_newline(2),
    (Goal == 1 ; Goal == 2), !.

repeat_ask_goal(Goal,Name):-
    center_text(' ',40),
    format('\e[47m\e[31mERROR: Invalid goal. Please enter 1 or 2.\e[0m', []),
    print_newline(2),
    repeat_ask_goal(Goal,Name).

/* askGoal/1 asks for a goal input */ 
askGoal(Goal,Name):- 
    center_text(' ',40),
    write('1- Play for Colors 2- Play for Heights'),
    print_newline(2),
    center_text(' ',45),
    write(Name),
    write(' please insert your goal : '),
    read(Goal).

/* askName/1 asks for a name input */ /*  Make this accept UpperCase */
askName(Name):-
    center_text(' ',45),
    write('Insert your name: '),
    read(Name).

/*repeat_ask_option/1 is a predicate that keeps asking difficulty if the values are not in the range specified*/
repeat_ask_option(Option):-
    askOption(Option),
    print_newline(2),
    (Option >=1 , Option =< 6), !,
    handle_option(Option).

repeat_ask_option(Option):-
    center_text(' ',40),
    format('\e[47m\e[31mERROR: Invalid option. Please enter 1-6 number.\e[0m', []),
    print_newline(2),
    repeat_ask_option(Option).

/* askOption/1 asks for an option input */ 
askOption(Option):-
    center_text(' ',45),
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
    !,
    (Goal == 1 ->
        play_game_Initial(InitalState, (1, Name1, Goal), (2, Name2, 2))
    ;
        play_game_Initial(InitalState, (1, Name1, Goal), (2, Name2, 1))
    ),
    view_main_menu.

    

handle_option(2):-
    askName(Name1),
    repeat_ask_goal(Goal),
    repeat_ask_difficulty(Difficulty),
    (Goal == 1 -> 
    start_game(initial,(Name1,Goal),(Difficulty,2))
    ;
    start_game(initial,(Name1,2),(Difficulty,1))),
    view_main_menu. 

handle_option(3):-
    repeat_ask_difficulty(Difficulty1),
    repeat_ask_difficulty(Difficulty2),
    start_game(initial,(Difficulty1,1),(Difficulty2,2)),
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

