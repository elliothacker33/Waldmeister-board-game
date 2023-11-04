/*
   receives a Size and Returns a Board with the biggest column of size Size
*/
% generate_matrix(+Size,-Matrix)
generate_matrix(Size,Matrix):-
    generate_matrix_aux(Size,1,[],Matrix).

/*
   axiliary function for generate_matrix that uses logic to make the size required
*/
% generate_matrix_aux(+Size,-Matrix)
generate_matrix_aux(Size,Current_colomn,Matrix,Matrix):-
    Tmp is Size * 2,
    Current_colomn =:= Tmp.

generate_matrix_aux(Size,Current_colomn,Matrix,Result):-
    Tmp is Size * 2,
    Current_colomn < Tmp,
    generate_line_aux(Size,Current_colomn,Line),
    Current_colomn1 is Current_colomn + 1,
    generate_matrix_aux(Size,Current_colomn1,[Line | Matrix],Result).
/*
   the Number is the index of the number in the line and the result is the line
*/
% add_PlaceHolders(+Number,+Line,-Result)

add_PlaceHolders(1,Line,[ -1 |Line]).

add_PlaceHolders(Number,Line,Result):-
    Number > 1,
    Number1 is Number - 1,
    add_PlaceHolders(Number1,[-1  | Line],Result).

/*
   generates a line given a size and a column number
*/
% generate_line_aux(+Size,+Column_Number,-Line)
generate_line_aux(Size,Column_Number,Line):-
    Size > Column_Number,
    generate_line(Column_Number,Line).

generate_line_aux(Size,Column_Number,Line):-
    Size =< Column_Number,
    Tmp is 2 * Size,
    Number_Of_Pieces_tmp is Tmp - Column_Number,
    Number_Of_Pieces is Number_Of_Pieces_tmp ,
    generate_line(Number_Of_Pieces,Line).

/*
   function that can be used to change the way we generate the line
*/
% generate_line(+Number_Of_Pieces,-Line)
generate_line(Number_Of_Pieces,Line):-
    add_PlaceHolders(Number_Of_Pieces,[],Line).

/*
   receives a board and returns the size of the biggest column
*/
% get_size(+Matrix,-Result)
get_size(Matrix,Result):-
    length(Matrix,Number),
    Result is round(( Number+ 1)/2).
/*
   given a size of the board it returns a gamestate
*/
% initial_state(+Size,-InitialState)
initial_state(Size,InitialState):-
        generate_matrix(Size,Matrix),
        append([Matrix],[[(1-1,3),(1-2,3),(1-3,3),(2-1,3),(2-2,3),(2-3,3),(3-1,3),(3-2,3),(3-3,3)]],Temp),
        append(Temp,[[(1-1,3),(1-2,3),(1-3,3),(2-1,3),(2-2,3),(2-3,3),(3-1,3),(3-2,3),(3-3,3)]],Temp1),
        append(Temp1,[54],Temp2),
        append(Temp2,[1],InitialState).



    


