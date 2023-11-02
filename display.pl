print_list([]).
print_list([H-C | Rest]) :-
    write(H-C), nl,
    print_list(Rest).

print_valid_moves([]).
print_valid_moves([X-Y|H]):-
        format('~w-~w ',[X,Y]),
        print_valid_moves(H).




initial_state(Size,InitialState):-
        generate_matrix(Size,Matrix),
        append([Matrix],[[(1-1,3),(1-2,3),(1-3,3),(2-1,3),(2-2,3),(2-3,3),(3-1,3),(3-2,3),(3-3,3)]],Temp),
        append(Temp,[[(1-1,3),(1-2,3),(1-3,3),(2-1,3),(2-2,3),(2-3,3),(3-1,3),(3-2,3),(3-3,3)]],Temp1),
        append(Temp1,[54],Temp2),
        append(Temp2,[1],InitialState).
        
        
        
        display_game([Board,Trees1,Trees2,_,_]):-
        draw_matrix(Board),
        write('\n\nPlayer 1: small    Medium  big\n'),
        member((1-3,Ls),Trees1),member((2-3,Lm),Trees1),member((3-3,Lb),Trees1),
        format('Ligth Green:  ~w    ~w       ~w ~n',[Ls,Lm,Lb]),
        member((1-2,Ms),Trees1),member((2-2,Mm),Trees1),member((3-2,Mb),Trees1),
        format('Medium Green: ~w    ~w       ~w ~n',[Ms,Mm,Mb]),
        member((1-1,Ds),Trees1),member((2-1,Dm),Trees1),member((3-1,Db),Trees1),
        format('Dark Green:   ~w    ~w       ~w ~n',[Ds,Dm,Db]),
        write('\n\nPlayer 2: small    Medium  big\n'),
        member((1-3,Ls2),Trees2),member((2-3,Lm2),Trees2),member((3-3,Lb2),Trees2),
        format('Ligth Green:  ~w    ~w       ~w ~n',[Ls2,Lm2,Lb2]),
        member((1-2,Ms2),Trees2),member((2-2,Mm2),Trees2),member((3-2,Mb2),Trees2),
        format('Medium Green: ~w    ~w       ~w ~n',[Ms2,Mm2,Mb2]),
        member((1-1,Ds2),Trees2),member((2-1,Dm2),Trees2),member((3-1,Db2),Trees2),
        format('Dark Green:   ~w    ~w       ~w ~n',[Ds2,Dm2,Db2])
        .
        
        
        
        
        
        
        
        
        add_blancks(0,Result,Result).
        add_blancks(Blanks,Column,Result):-
        append([0],Column,NewColumn),
        NewBlanks is Blanks - 1,
        add_blancks(NewBlanks,NewColumn,Result).
        
        draw_matrix([]).
        draw_matrix(Matrix):-
        get_size(Matrix,Size),
        draw_First_Line(Size,0),
        write('\nL\n'),
        draw_matrix_aux(Size,1,Matrix).
        
        draw_First_Line(Size,Current_colomn):-
        Tmp is Size*2 ,
        Current_colomn =:= Tmp.
        
        draw_First_Line(Size,0):-
        write('\nC  '),
        draw_First_Line(Size,1).
        
        draw_First_Line(Size,Current_colomn):-
        Current_colomn < Size*2,
        Current_colomn < 10,
        New_Current_colomn is Current_colomn + 1,
        write('  '),
        write(Current_colomn),
        draw_First_Line(Size,New_Current_colomn).
        
        draw_First_Line(Size,Current_colomn):-
        Current_colomn < Size*2,
        10 =< Current_colomn ,
        New_Current_colomn is Current_colomn + 1,
        write(' '),
        write(Current_colomn),
        draw_First_Line(Size,New_Current_colomn).
        
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
        
        draw_line([]):-
        write('\n').
        
        draw_line([Head | Tail]):-
        number(Head),!,
        write(Head),
        draw_line( Tail).
        draw_line([Head | Tail]):-
        format(Head,[]),
        draw_line( Tail).
        
        draw_line_with_pieces([],Lines,Lines).
        
        draw_line_with_pieces([Head | Tail],Lines,Result):-
        draw_Piece(Head,Lines,NewLines),
        draw_line_with_pieces( Tail,NewLines,Result).
        
        
        draw_Piece(-1,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
                append(Tail1,['    _ '],NewTail1),
                append(Tail2,['   / \\'],NewTail2),
                append(Tail3,['   \\_/'],NewTail3).
        draw_Piece(1-1,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
                append(Tail1,['    _ '],NewTail1),
                append(Tail2,['   /\x25b3\\\\'],NewTail2),
                append(Tail3,['   \\_/'],NewTail3).
        draw_Piece(2-1,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
                append(Tail1,['    _ '],NewTail1),
                append(Tail2,['   /\x25ed\\\\'],NewTail2),
                append(Tail3,['   \\_/'],NewTail3).
        draw_Piece(3-1,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
                append(Tail1,['    _ '],NewTail1),
                append(Tail2,['   /\x25b2\\\\'],NewTail2),
                append(Tail3,['   \\_/'],NewTail3).
        draw_Piece(1-2,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
                append(Tail1,['    _ '],NewTail1),
                append(Tail2,['   /\x25b3\\\\'],NewTail2),
                append(Tail3,['   \\\x25b3\/'],NewTail3).
        draw_Piece(2-2,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
                append(Tail1,['    _ '],NewTail1),
                append(Tail2,['   /\x25ed\\\\'],NewTail2),
                append(Tail3,['   \\\x25ed\/'],NewTail3).
        draw_Piece(3-2,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
                append(Tail1,['    _ '],NewTail1),
                append(Tail2,['   /\x25b2\\\\'],NewTail2),
                append(Tail3,['   \\\x25b2\/'],NewTail3).
        draw_Piece(1-3,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
                append(Tail1,['    \x25b3\ '],NewTail1),
                append(Tail2,['   /\x25b3\\\\'],NewTail2),
                append(Tail3,['   \\\x25b3\/'],NewTail3).
        draw_Piece(2-3,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
                append(Tail1,['    \x25ed\ '],NewTail1),
                append(Tail2,['   /\x25ed\\\\'],NewTail2),
                append(Tail3,['   \\\x25ed\/'],NewTail3).
        draw_Piece(3-3,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
                append(Tail1,['    \x25b2\ '],NewTail1),
                append(Tail2,['   /\x25b2\\\\'],NewTail2),
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
