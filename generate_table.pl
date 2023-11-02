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

%teste
/*teste:-draw_matrix([[0,0,0,0,0,0,0,-1],[0,0,0,0,0,0,-1,0,-1],[0,0,0,0,0,-1,0,-1,0,-1],[0,0,0,0,-1,0,-1,0,-1,0,-1],[0,0,0,-1,0,-1,0,-1,0,-1,0,-1],
    [0,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[0,-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[0,-1,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],
[0,0,-1,0,-1,0,-1,0,-1,0,-1,0,-1],[0,0,0,-1,0,-1,0,-1,0,-1,0,-1],[0,0,0,0,-1,0,-1,0,-1,0,-1],[0,0,0,0,0,-1,0,-1,0,-1],[0,0,0,0,0,0,-1,0,-1],[0,0,0,0,0,0,0,-1]]).*/

get_size(Matrix,Result):-
    length(Matrix,Number),
    Result is round(( Number+ 1)/2).

testing_height(Max):-
    start_height_bfs(
    [[(1,2)],
    [(1,2), (2,3)],
    [(3,1), (2,2), (3,2)],
    [(1,3), (1,1), (3,1), (3,3)],
    [-1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1],
    [-1, -1, -1, -1],
    [-1, -1, -1],
    [-1, -1],
    [-1]
    ],Max).

    testing_winner(Winner):-
        winner(
        [[(1,2)],
        [(1,2), (2,3)],
        [(3,1), (2,2), (3,2)],
        [(1,3), (1,1), (3,1), (3,3)],
        [-1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1],
        [-1, -1, -1, -1],
        [-1, -1, -1],
        [-1, -1],
        [-1]
        ],Winner).

testing_color(Max):-
    start_color_bfs(
    [[(1,2)],
    [(1,2), (2,3)],
    [(3,1), (2,2), (3,2)],
    [(1,3), (1,1), (3,1), (3,3)],
    [-1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1],
    [-1, -1, -1, -1],
    [-1, -1, -1],
    [-1, -1],
    [-1]
    ],Max).


teste_generate_matrix(Value):-
    generate_matrix(Value,_Matrix),
    draw_matrix(        
        [
        [-1],
        [1-2, 2-3],
        [3-1, 2-2, 3-2],
        [1-3, 1-1, 3-1, 3-3],
        [-1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1],
        [-1, -1, -1, -1],
        [-1, -1, -1],
        [-1, -1],
        [-1]
        ]).
    teste(R):-
        get_size(        
            [
            [(1,2)],
            [(1,2), (2,3)],
            [(3,1), (2,2), (3,2)],
            [(1,3), (1,1), (3,1), (3,3)],
            [-1, -1, -1, -1, -1],
            [-1, -1, -1, -1, -1, -1],
            [-1, -1, -1, -1, -1, -1, -1],
            [-1, -1, -1, -1, -1, -1],
            [-1, -1, -1, -1, -1],
            [-1, -1, -1, -1],
            [-1, -1, -1],
            [-1, -1],
            [-1]
            ],R).