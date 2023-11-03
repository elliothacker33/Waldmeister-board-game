generate_matrix(Size,Matrix):-
    generate_matrix_aux(Size,1,[],Matrix).

generate_matrix_aux(Size,Current_colomn,Matrix,Matrix):-
    Tmp is Size * 2,
    Current_colomn =:= Tmp.

generate_matrix_aux(Size,Current_colomn,Matrix,Result):-
    Tmp is Size * 2,
    Current_colomn < Tmp,
    generate_line_aux(Size,Current_colomn,Line),
    Current_colomn1 is Current_colomn + 1,
    generate_matrix_aux(Size,Current_colomn1,[Line | Matrix],Result).

add_PlaceHolders(1,Line,[ -1 |Line]).

add_PlaceHolders(Number,Line,Result):-
    Number > 1,
    Number1 is Number - 1,
    add_PlaceHolders(Number1,[-1  | Line],Result).


generate_line_aux(Size,Column_Number,Line):-
    Size > Column_Number,
    generate_line(Column_Number,Line).

generate_line_aux(Size,Column_Number,Line):-
    Size =< Column_Number,
    Tmp is 2 * Size,
    Number_Of_Pieces_tmp is Tmp - Column_Number,
    Number_Of_Pieces is Number_Of_Pieces_tmp ,
    generate_line(Number_Of_Pieces,Line).


generate_line(Number_Of_Pieces,Line):-
    add_PlaceHolders(Number_Of_Pieces,[],Line).

get_size(Matrix,Result):-
    length(Matrix,Number),
    Result is round(( Number+ 1)/2).

initial_state(Size,InitialState):-
        generate_matrix(Size,Matrix),
        append([Matrix],[[(1-1,3),(1-2,3),(1-3,3),(2-1,3),(2-2,3),(2-3,3),(3-1,3),(3-2,3),(3-3,3)]],Temp),
        append(Temp,[[(1-1,3),(1-2,3),(1-3,3),(2-1,3),(2-2,3),(2-3,3),(3-1,3),(3-2,3),(3-3,3)]],Temp1),
        append(Temp1,[54],Temp2),
        append(Temp2,[1],InitialState).


%teste
/*teste:-draw_matrix([[0,0,0,0,0,0,0,-1],[0,0,0,0,0,0,-1,0,-1],[0,0,0,0,0,-1,0,-1,0,-1],[0,0,0,0,-1,0,-1,0,-1,0,-1],[0,0,0,-1,0,-1,0,-1,0,-1,0,-1],
    [0,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[0,-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[0,-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],
[0,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[0,0,0,-1,0,-1,0,-1,0,-1,0,-1],[0,0,0,0,-1,0,-1,0,-1,0,-1],[0,0,0,0,0,-1,0,-1,0,-1],[0,0,0,0,0,0,-1,0,-1],[0,0,0,0,0,0,0,-1]]).*/
/*
screenCords_to_Cords(Line-Column,Size,TmpLine-TmpCol):-
    Line =< Size,
    TmpSize is Size - Line + 1,
    TmpCol is Column - TmpSize,
    TmpLine is Line - 1.

screenCords_to_Cords(Line-Column,Size,TmpLine-TmpCol):-
     Size<Line,
    TmpSize is Line - Size + 1,
    TmpCol is Column - TmpSize,
    TmpLine is Line - 1.*/
    


