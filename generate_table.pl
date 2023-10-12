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


add_Blanck(0,Line,Line).

add_Blanck(Number,Line,Result):-
    Number > 0,
    Number1 is Number - 1,
    add_Blanck(Number1,[0 | Line],Result).


add_PlaceHolders(1,Line,[ -1 |Line]).

add_PlaceHolders(Number,Line,Result):-
    Number > 1,
    Number1 is Number - 1,
    add_PlaceHolders(Number1,[0,-1  | Line],Result).


generate_line_aux(Size,Column_Number,Line):-
    Size > Column_Number,
    generate_line(Size,Column_Number,Line).

generate_line_aux(Size,Column_Number,Line):-
    Size =< Column_Number,
    Tmp is 2 * Size,
    Number_Of_Pieces_tmp is Tmp - Column_Number,
    Number_Of_Pieces is Number_Of_Pieces_tmp ,
    generate_line(Size,Number_Of_Pieces,Line).


generate_line(Size,Number_Of_Pieces,Line):-
    Number is Size - Number_Of_Pieces,
    add_Blanck(Number , [] ,LineTmp),
    add_PlaceHolders(Number_Of_Pieces,LineTmp,LineTmp1),
    add_Blanck(Number , LineTmp1 ,Line).

%teste
/*teste:-draw_matrix([[0,0,0,0,0,0,0,-1],[0,0,0,0,0,0,-1,0,-1],[0,0,0,0,0,-1,0,-1,0,-1],[0,0,0,0,-1,0,-1,0,-1,0,-1],[0,0,0,-1,0,-1,0,-1,0,-1,0,-1],
    [0,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[0,-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[0,-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],
[0,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[0,0,0,-1,0,-1,0,-1,0,-1,0,-1],[0,0,0,0,-1,0,-1,0,-1,0,-1],[0,0,0,0,0,-1,0,-1,0,-1],[0,0,0,0,0,0,-1,0,-1],[0,0,0,0,0,0,0,-1]]).*/

teste_generate_matrix(Value):-
    generate_matrix(Value,Matrix),
    draw_matrix(Matrix).