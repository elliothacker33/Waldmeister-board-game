/* 
    it prints the board and other inportant information
*/
% display_game(+Gamestate)
display_game([Board,Trees1,Trees2,Amount,Turn]):-
    draw_matrix(Board),
    write('\n\nPlayer 1: small    Medium  big\n'),
    member((1-1,Ls),Trees1),member((2-1,Lm),Trees1),member((3-1,Lb),Trees1),
    format('Ligth Green:  ~w    ~w       ~w ~n',[Ls,Lm,Lb]),
    member((1-2,Ms),Trees1),member((2-2,Mm),Trees1),member((3-2,Mb),Trees1),
    format('Medium Green: ~w    ~w       ~w ~n',[Ms,Mm,Mb]),
    member((1-3,Ds),Trees1),member((2-3,Dm),Trees1),member((3-3,Db),Trees1),
    format('Dark Green:   ~w    ~w       ~w ~n',[Ds,Dm,Db]),
    write('\n\nPlayer 2: small    Medium  big\n'),
    member((1-1,Ls2),Trees2),member((2-1,Lm2),Trees2),member((3-1,Lb2),Trees2),
    format('Ligth Green:  ~w    ~w       ~w ~n',[Ls2,Lm2,Lb2]),
    member((1-2,Ms2),Trees2),member((2-2,Mm2),Trees2),member((3-2,Mb2),Trees2),
    format('Medium Green: ~w    ~w       ~w ~n',[Ms2,Mm2,Mb2]),
    member((1-3,Ds2),Trees2),member((2-3,Dm2),Trees2),member((3-3,Db2),Trees2),
    format('Dark Green:   ~w    ~w       ~w ~n~n',[Ds2,Dm2,Db2]),
    (Amount = 0 ->
        format('Game Ended.~n~n',[])
        ;
        format('Player ~w is playing !!.~n~n',[Turn])
    )
.
/* 
    it prints the wining player and the points
*/
% display_Winner(+Goal,+Player,+PointsHeight,+PointsColor)   
display_Winner(1,Player,PointsHeight,PointsColor):-
    format('Player ~w won playing for heights with ~w points vs ~w',[Player,PointsHeight,PointsColor])
.

display_Winner(2,Player,PointsHeight,PointsColor):-
    format('Player ~w won playing for colors with ~w points vs ~w',[Player,PointsColor,PointsHeight])
.


display_Winner(0,_,_,_):- 
    write('Draw : Both players scored the same ')
.

        
        
/* 
    this function is responsible to fill the matrix with 0 that represents filler places so that the board is alligned
*/
% add_blancks(+Blanks,Column,Result)
add_blancks(0,Result,Result).
add_blancks(Blanks,Column,Result):-
    append([0],Column,NewColumn),
    NewBlanks is Blanks - 1,
    add_blancks(NewBlanks,NewColumn,Result).
/* 
    this function is responsible to draw the board 
*/
% draw_matrix(+Matrix)  
draw_matrix([]).
draw_matrix(Matrix):-
    get_size(Matrix,Size),
    write('\nL\n'),
    draw_matrix_aux(Size,1,Matrix).
        

/* 
    this function is and axiliary function to draw the board
*/
% draw_matrix_aux(+Size,+NColumn,+Matrix)        
draw_matrix_aux(_,_,[]).
        
draw_matrix_aux(Size,NColumn,[Head | Tail]):-
    NColumn =< Size,
    Blanks is Size - NColumn,
    NColumn1 is NColumn + 1,
    draw_matrix_aux2(NColumn,Blanks,Head),
    draw_matrix_aux(Size,NColumn1,Tail).
        
draw_matrix_aux(Size,NColumn,[Head | Tail]):-
    NColumn > Size,
    Blanks is NColumn - Size,
    NColumn1 is NColumn + 1,
    draw_matrix_aux2(NColumn,Blanks,Head),
    draw_matrix_aux(Size,NColumn1,Tail).
/* 
    this function is and a second axiliary function to draw the board used to process the board with filler 
    places and use 3 diferent lists because each piece is composed by 3 lines
*/
% draw_matrix_aux2(+Size,+NColumn,+Line)  
draw_matrix_aux2(NColumn,Blanks,Head):-
    NColumn < 10,
    add_blancks(Blanks,Head,NewHead),
    draw_line_with_pieces(NewHead,[[],[],[]],[Line1,Line2,Line3]),
    append([' '],Line1,NewLine1),
    append([NColumn],Line2,NewLine2),
    append([' '],Line3,NewLine3),
    draw_line(NewLine1),
    draw_line(NewLine2),
    draw_line(NewLine3),write('\n').
        
draw_matrix_aux2(NColumn,Blanks,Head):-
    10 =< NColumn,
    add_blancks(Blanks,Head,NewHead),
    draw_line_with_pieces(NewHead,[[],[],[]],[Line1,Line2,Line3]),
    append(['  '],Line1,NewLine1),
    append([NColumn],Line2,NewLine2),
    append(['  '],Line3,NewLine3),
    draw_line(NewLine1),
    draw_line(NewLine2),
    draw_line(NewLine3),write('\n').
/* 
    this function is used to draw each line of the auxiliary lines used to draw the board
*/
% draw_line(+Line) 
draw_line([]):-
        write('\n').

draw_line([Head | Tail]):-
    number(Head),!,
    write(Head),
    draw_line(Tail).

draw_line([Head | Tail]):-
    format(Head,[]),
    draw_line(Tail).
/* 
    this function is used to draw each call the draw_piece function that is responsible to draw each piece and 
    transform into a list of lines that represents each line of the piece
*/
% draw_line([Head | Tail],Lines,Result) 
draw_line_with_pieces([],Lines,Lines).
        
draw_line_with_pieces([Head | Tail],Lines,Result):-
    draw_Piece(Head,Lines,NewLines),
    draw_line_with_pieces( Tail,NewLines,Result).
        
/* 
    this function is used to draw each diferent piece
*/
% draw_Piece(+Type,[+Tail1,+Tail2,+Tail3],[-NewTail1,-NewTail2,-NewTail3])
draw_Piece(-1,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    _ '],NewTail1),
    append(Tail2,['   / \\'],NewTail2),
    append(Tail3,['   \\_/'],NewTail3).

draw_Piece(1-1,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    _ '],NewTail1),
    append(Tail2,['   /\x25b3\\\'],NewTail2),
    append(Tail3,['   \\_/'],NewTail3)
.

draw_Piece(2-1,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    _ '],NewTail1),
    append(Tail2,['   /\x25ed\\\'],NewTail2),
    append(Tail3,['   \\_/'],NewTail3).

draw_Piece(3-1,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    _ '],NewTail1),
    append(Tail2,['   /\x25b2\\\'],NewTail2),
    append(Tail3,['   \\_/'],NewTail3).

draw_Piece(1-2,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    _ '],NewTail1),
    append(Tail2,['   /\x25b3\\\'],NewTail2),
    append(Tail3,['   \\\x25b3\/'],NewTail3).

draw_Piece(2-2,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    _ '],NewTail1),
    append(Tail2,['   /\x25ed\\\'],NewTail2),
    append(Tail3,['   \\\x25ed\/'],NewTail3).

draw_Piece(3-2,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    _ '],NewTail1),
    append(Tail2,['   /\x25b2\\\'],NewTail2),
    append(Tail3,['   \\\x25b2\/'],NewTail3).

draw_Piece(1-3,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    \x25b3\ '],NewTail1),
    append(Tail2,['   /\x25b3\\\'],NewTail2),
    append(Tail3,['   \\\x25b3\/'],NewTail3).

draw_Piece(2-3,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    \x25ed\ '],NewTail1),
    append(Tail2,['   /\x25ed\\\'],NewTail2),
    append(Tail3,['   \\\x25ed\/'],NewTail3).

draw_Piece(3-3,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    \x25b2\ '],NewTail1),
    append(Tail2,['   /\x25b2\\\'],NewTail2),
    append(Tail3,['   \\\x25b2\/'],NewTail3).
        
draw_Piece(0,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['   '],NewTail1),
    append(Tail2,['   '],NewTail2),
    append(Tail3,['   '],NewTail3).






/* Menu Display */ 

box_char(horizontal, 0x2500).
box_char(vertical, 0x2502).
box_char(top_left, 0x250C).
box_char(top_right, 0x2510).
box_char(bottom_left, 0x2514).
box_char(bottom_right, 0x2518).
box_char(connector, 0x2534).
box_char(connector2, 0x252C).


/* waldmeister_logo/0 is a predicate that is responsible for showing the waldmeister logo in ASCII ART */
display_waldmeister_logo:-

    format('~w', [' ##      ##    ##    ##    ##    ###       ##     ##   ####   #   ###   #####  ####   ###   ']),
    print_newline(1),
    format('~w', ['  ##   ## ##  ##   ##  ##  ##    #  #    ####   ####   # __   |    #  #   #    # __   #  #  ']),
    print_newline(1),
    format('~w', ['   ## ##  ## ##    ######  ##    #   #  ##  ## ##  ##  #      |  # ##     #    #      # ##  ']),
    print_newline(1),
    format('~w', ['    ##      ##     ##  ##  ##### ####  #    ##     #   ####   |  ###      #    ####   ##  # ']),
    print_newline(1).

display_aux_options_vertical(V):-
    print_newline(1),
    format('~c',[V]),
    format('~*c', [35, 32]),
    format('~c',[V]),
    print_newline(1).
display_aux_options_first_line(TL,H,TR):-
     format('~c',[TL]),
     format('~*c', [35, H]),
     format('~c',[TR]).
display_aux_options_last_line(BL,H,BR):-
    format('~c',[BL]),
    format('~*c', [35, H]),
    format('~c',[BR]).
display_choose(V):-
    format('~c',[V]),
    write('    Choose your option from 1-6    '),
    format('~c',[V]).




display_option_1(V):-

    format('~c',[V]),
    write('         '),
    format('~w',['1']),
    write(' Human/Human             '),
    format('~c',[V]).

display_option_2(V):-
    format('~c',[V]),
    write('         '),
    format('~w',['2']),
    write(' Human/AI                '),
    format('~c',[V]).
display_option_3(V):-
    format('~c',[V]),
    write('         '),
    format('~w',['3']),
    write(' AI/AI                   '),
    format('~c',[V]).
display_option_4(V):-
    format('~c',[V]),
    write('         '),
    format('~w',['4']),
    write(' Instructions            '),
    format('~c',[V]).
display_option_5(V):-
    format('~c',[V]),
    write('         '),
    format('~w',['5']),
    write(' Credits                 '),
    format('~c',[V]).

display_option_6(V):-
    format('~c',[V]),
    write('         '),
    format('~w',['6']),
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
display_options:-
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
    format('~c',[V]),
    write('      Choose the AI difficulty     '),
    format('~c',[V]).

display_difficulty_1(V):-
    format('~c',[V]),
    write('         '),
    format('~w',['1']),
    write(' Easy                    '),
    format('~c',[V]).
display_difficulty_2(V):-
    format('~c',[V]),
    write('         '),
    format('~w',['2']),
    write(' Hard                    '),
    format('~c',[V]).

display_difficulty_menu:-
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
    format('~c',[V]),
    write('      Player 1 choose your goal    '),
    format('~c',[V]).

display_goal_1(V):-
    format('~c',[V]),
    write('         '),
    format('~w',['1']),
    write(' Heights                 '),
    format('~c',[V]).

display_goal_2(V):-
    format('~c',[V]),
    write('         '),
    format('~w',['2']),
    write(' Colors                  '),
    format('~c',[V]).

display_goal_menu:-
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



/*  
 display_main_menu is a predicate that shows main menu of Waldmeister Game
*/
% display_main_menu/0

display_main_menu:-
    clear,
    display_waldmeister_logo,
    print_newline(1),
    display_options,
    print_newline(3),
    repeat_ask_option(Option),
    !
.

/*
 display_instructions predicate is responsible to show instructions.
*/
% display_instructions/0

display_instructions:-
    write('The waldmeister game is played with the following set of rules.'),
    print_newline(1),
    write('1- Each player has 27 trees (3 of each type Height-Colors)'),
    print_newline(1),
    write('2- One player will play for heights team and the other for colors team'),
    print_newline(1),
    write('3- In the first play the first player takes one of his trees and put it in the board in place X'),
    print_newline(1),
    write('4- Then, the second player moves the tree player one played and put it in place Y (valid moves)'),
    print_newline(1),
    write('5- After that second player moves one of his trees to the place X'),
    print_newline(1),
    write('6- After this first player plays and choose one tree in the board (position K) and put it in position Z'),
    print_newline(1),
    write('7- After this first player chooses a tree that is not on the board and put it in position K'),
    print_newline(2),
    write('A free tree is a tree that can move to other places (has >=1 valid moves)'),
    print_newline(2),
    write('In the end, all trees on the board the points are checked for heights and colors'),
    print_newline(1),
    write('A cluster is a group of pieces of the same height or color that are adjacent or connected without being separated by pieces of different color, height, or empty spaces.'),
    print_newline(1),
    write('To win the sum of your best clusters (light-green,medium-green,dark-green) must be higher than the sum of 3 best heights or the opposite for other player')
.



/*
 display_credits predicate is responsible to show credits.
*/
% display_credits/0

display_credits:-
    write('Team members: '),
    print_newline(1),
    write('1 --> Tomas Pereira'),
    print_newline(1),
    write('2 --> Tomas Sarmento'),
    print_newline(3),
    write('FEUP - Faculty of Engineering of the University of Porto'),
    print_newline(2),
    write('Sicstus prolog 4.18 was the only tool used in game development'),
    print_newline(1),
    write('For more information go to our github --> https://github.com/elliothacker33/Waldmeister-board-game'),
    print_newline(1),
    write('Version 1.0 of Waldmeister board game')
.