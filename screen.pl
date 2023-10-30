%convert symbols in the matrix to the screen
draw_Piece(-1,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    _ '],NewTail1),
    append(Tail2,['   / \\'],NewTail2),
    append(Tail3,['   \\_/'],NewTail3).
draw_Piece(1,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['    _ '],NewTail1),
    append(Tail2,['   / L'],NewTail2),
    append(Tail3,['   H_/'],NewTail3).

draw_Piece(0,[Tail1,Tail2,Tail3],[NewTail1,NewTail2,NewTail3]):-
    append(Tail1,['   '],NewTail1),
    append(Tail2,['   '],NewTail2),
    append(Tail3,['   '],NewTail3).

add_blancks(0,Result,Result).
add_blancks(Blanks,Column,Result):-
    append([0],Column,NewColumn),
    NewBlanks is Blanks - 1,
    add_blancks(NewBlanks,NewColumn,Result).

draw_matrix(_,[]).
draw_matrix(Size,Matrix):-
    draw_First_Line(Size,0),
    write('\nL\n'),
    draw_matrix_aux(Size,1,Matrix).

draw_First_Line(Size,Current_colomn):-
    Tmp is Size*2 ,
    Current_colomn =:= Tmp.

draw_First_Line(Size,0):-
    write('C  '),
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
    draw_line(NewLine3).

draw_matrix_aux2(NColumn,Blanks,Head):-
    10 =< NColumn,
    add_blancks(Blanks,Head,NewHead),
    draw_line_with_pieces(NewHead,[[],[],[]],[Line1,Line2,Line3]),
    append(['  '],Line1,NewLine1),
    append([NColumn],Line2,NewLine2),
    append(['  '],Line3,NewLine3),
    draw_line(NewLine1),
    draw_line(NewLine2),
    draw_line(NewLine3).

draw_line([]):-
    write('\n').

draw_line([Head | Tail]):-
    write(Head),
    draw_line( Tail).

draw_line_with_pieces([],Lines,Lines).

draw_line_with_pieces([Head | Tail],Lines,Result):-
    draw_Piece(Head,Lines,NewLines),
    draw_line_with_pieces( Tail,NewLines,Result).