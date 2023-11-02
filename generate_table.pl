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
    
    get_size(Matrix,Result):-
        length(Matrix,Number),
        Result is round(( Number+ 1)/2).

testing:-
    Board = [[1-2],
    [1-2, 2-3],
    [3-1, 2-2, 3-2],
    [1-3, 1-1, 3-1, 3-3],
    [-1, -1, -1, -1, -1],
    [-1, -1, 1-1, -1, 1-1, -1],
    [-1, -1, 1-2, -1, -1, -1, -1],
    [-1, -1, 1-2, -1, -1, -1, -1, -1],
    [-1, -1, 1-2, -1, -1, -1, -1],
    [-1, -1, 1-3, -1, -1, -1],
    [-1, -1, -1, -1, -1],
    [-1, -1, -1, -1],
    [-1, -1, -1],
    [-1, -1],
    [-1]
    ],
    get_size(Board,Size),
    Tmp_size is Size - 1,
    MaxLine is Tmp_size * 2 + 1,
    findall(L-C, (between(0,MaxLine,L),((L=< Tmp_size,between(0,L,C)) ; (Tmp_size<L,Tmp_L is Tmp_size*2 - L,between(0,Tmp_L,C)))),TreesInBoard),write(TreesInBoard).

testing_height(Max):-
    Matrix = [[1-2],
    [1-2, 2-3],
    [3-1, 2-2, 3-2],
    [1-3, 1-1, 3-1, 3-3],
    [-1, -1, -1, -1, -1],
    [-1, -1, 1-1, -1, 1-1, -1],
    [-1, -1, 1-2, -1, -1, -1, -1],
    [-1, -1, 1-3, -1, -1, -1],
    [-1, -1, -1, -1, -1],
    [-1, -1, -1, -1],
    [-1, -1, -1],
    [-1, -1],
    [-1]
    ],draw_matrix(Matrix),
    count_height_values(
        Matrix,Max).
testing_bot:-
    Matrix = [[1-2],
    [1-2, 2-3],
    [3-1, 2-2, 3-2],
    [1-3, 1-1, 3-1, 3-3],
    [-1, -1, -1, -1, -1],
    [-1, -1, 1-1, -1, 1-1, -1],
    [-1, -1, 1-2, -1, -1, -1, -1],
    [-1, -1, 1-2, -1, -1, -1, -1, -1],
    [-1, -1, 1-2, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1],
    [-1, -1, -1, -1],
    [-1, -1, -1],
    [-1, -1],
    [-1]
    ],draw_matrix(Matrix),%valid_moves([Matrix,_,_,_,_],9-2,ValidMoves),write(ValidMoves).
    write('ok'),
    initial_state(8,[Board,Trees1,Trees2,Amout,Turn]),write('initial_state'),
    bot_move([Matrix ,Trees1,Trees2,24,Turn],'Height',Trees1,Mov),write('done'),
    write(Mov).



    testing_winner(Winner):-
        winner(
        [[1-2],
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
        ],Winner).

testing_color(Max):-
    Matrix = [[1-2],
    [1-2, 2-3],
    [3-1, 2-2, 3-2],
    [1-3, 1-1, 3-1, 3-3],
    [-1, -1, -1, -1, -1],
    [-1, -1, 1-1, -1, 1-1, -1],
    [-1, -1, 1-2, -1, -1, -1, -1],
    [-1, -1, 1-3, -1, -1, -1],
    [-1, -1, -1, -1, -1],
    [-1, -1, -1, -1],
    [-1, -1, -1],
    [-1, -1],
    [-1]
    ],draw_matrix(Matrix),
    count_color_values(Matrix,Max).


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
            [[1-2],
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
            ],R).