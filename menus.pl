
/*
 repeat_ask_difficulty asks for user input until difficulty is valid.
*/
% repeat_ask_difficulty(-Difficulty) 

repeat_ask_difficulty(Difficulty):-
    askDifficulty(Difficulty),
    print_newline(2),
    (Difficulty == 1 ; Difficulty == 2), !
.

repeat_ask_difficulty(Difficulty):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid difficulty. Please enter 1 or 2.\e[0m', []),
    print_newline(2),
    repeat_ask_difficulty(Difficulty)
.

/* 
This predicate is responsible for interacting with the user to input the AI difficulty level.  
*/ 
% askDifficulty(-Difficulty)

askDifficulty(Difficulty):-
    print_newline(2),
    format('~*c', [45, 32]),
    write('Insert AI Difficulty: '),
    read(Difficulty)
.


/*
repeat_ask_goals asks for user input until Goal is valid
*/
% repeat_ask_goal(-Goal)

repeat_ask_goal(Goal):-
    askGoal(Goal),
    print_newline(2),
    (Goal == 1 ; Goal == 2), !
.

repeat_ask_goal(Goal):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid goal. Please enter 1 or 2.\e[0m', []),
    print_newline(2),
    repeat_ask_goal(Goal)
.

/* 
askGoal is a predicate interacts with the user to input a goal
*/ 
% askGoal(-Goal)

askGoal(Goal):- 
    format('~*c', [45, 32]),
    write(' Insert your goal : '),
    read(Goal)
.

/*
repeat_ask_option asks for user input until option is valid
*/
% repeat_ask_option(-Option)

repeat_ask_option(Option):-
    askOption(Option),
    print_newline(2),
    (Option >=1 , Option =< 6), !,
    handle_option(Option)
.

repeat_ask_option(Option):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid option. Please enter 1-6 number.\e[0m', []),
    print_newline(2),
    repeat_ask_option(Option)
.

/* 
askOption is a predicate interacts with the user to input a option
*/ 
% askOption(-Option)

askOption(Option):-
    format('~*c', [45, 32]),
    write('Insert option from 1-6: '),
    read(Option)
.

/*
repeat_ask_size asks for user input until size is valid
*/
% repeat_ask_size(-Size)

repeat_ask_size(Size):-
    askSize(Size),
    print_newline(2),
    (Size >= 2 ), !
.

repeat_ask_size(Size):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid option. Please enter a number >= 2 .\e[0m', []),
    print_newline(2),
    repeat_ask_size(Size)
.

/* 
askSize is a predicate that  interacts with the user to input a Size
*/ 
% askSize(-Size)

askSize(Size):-
    format('~*c', [45, 32]),
    write('Insert size (8 is default): '),
    read(Size)
.
    

/* 
handle_option is a predicate that interacts with the user to input a Option

Args :
     - 1- Human/Human
     - 2- Human/AI
     - 3- AI/AI
     - 4- Instructions
     - 5- Credits
     - 6- Quit
*/ 
% handle_option(+Option)

handle_option(1):-
    display_goal_menu,
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
    display_main_menu
.

handle_option(2):-
    display_goal_menu,
    print_newline(2),
    repeat_ask_goal(Goal),
    print_newline(2),
    display_difficulty_menu,
    print_newline(2),
    repeat_ask_difficulty(Difficulty),
    print_newline(2),
    repeat_ask_size(Size),
    initial_state(Size,InitialState),

    (Goal == 1 -> 
    play_game(InitialState,(1,-1,Goal),(2,Difficulty,2))
    ;
    play_game(InitialState,(1,-1,2),(2,Difficulty,Goal))),
    clear,
    display_main_menu
. 

handle_option(3):-
    display_difficulty_menu,
    print_newline(2),
    repeat_ask_difficulty(Difficulty1),
    display_difficulty_menu,
    print_newline(2),
    repeat_ask_difficulty(Difficulty2),
    repeat_ask_size(Size),
    clear,
    initial_state(Size,InitialState),
    play_game(InitialState,(1,Difficulty1,1),(2,Difficulty2,2)),
    display_main_menu
.

handle_option(4):-
    instructions,display_main_menu
.

handle_option(5):-
    credits,display_main_menu
.

handle_option(6):-
    halt
.



