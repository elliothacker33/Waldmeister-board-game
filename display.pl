

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
                append(Tail2,['   /\x25b3\\\'],NewTail2),
                append(Tail3,['   \\_/'],NewTail3).
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


  
