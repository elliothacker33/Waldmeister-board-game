:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(aggregate)).

winner(Board,Size, Winner) :-
    start_color_bfs(Board,Size,MaxColor),
    start_height_bfs(Board,Size,MaxHeight),
    (MaxColor < MaxHeight ->
        Winner = 'Height' ;
        Winner = 'Color' 
    ).


getPiece(Board, Col-Line, Piece) :-
    nth0( Line,Board,Line_pieces),
    nth0(Col, Line_pieces, Piece).

get_Height((_,Height),Height).
get_Color((Color,_),Color).

%calcula o numero maximo de pecas com a mesma cor proximas umas das outras

start_color_bfs(Board,Size,Max):-
    Visited = [],
    color_bfs(Board,Size,Visited,0,Max).

color_bfs(Board,_,Visited,CurrMax,CurrMax):-
    next_position(Board,Visited,Cord),
    Cord == null.

color_bfs(Board,Size,Visited,CurrMax,Max):-
    next_position(Board,Visited,Cord),
    Cord \= null,
    getPiece(Board,Cord,(Color,_Height)),
    color_bfs_aux(Board,Size,[Cord],Visited,NewVisited,Color,0,TmpMax),
    (TmpMax < CurrMax ->
        color_bfs(Board,Size,NewVisited,CurrMax,Max);
        color_bfs(Board,Size,NewVisited,TmpMax,Max)
    ).

color_bfs_aux(_,_,[],Visited,Visited,_,Max,Max).

color_bfs_aux(Board,Size,[Col-Line |  Rest],Visited,NewVisited,Color,Current_Max,Max):-
    findall(Cords, (getPositionNear(Size,Line,Col,Cords), Cords\= null,\+ member(Cords,Visited),\+ member(Cords,Rest), getPiece(Board,Cords,(Color,_Height))),
    New_Cords),
    append(Rest,New_Cords,New_queue),
    NewMax is Current_Max + 1,
    color_bfs_aux(Board,Size,New_queue,[Col-Line | Visited],NewVisited,Color,NewMax,Max).


%calcula o numero maximo de Pecas com a mesma altura proximas umas das outras
start_height_bfs(Board,Size,Max):-
    Visited = [],
    height_bfs(Board,Size,Visited,0,Max).

height_bfs(Board,_,Visited,CurrMax,CurrMax):-
    next_position(Board,Visited,Cord),
    Cord == null.

height_bfs(Board,Size,Visited,CurrMax,Max):-
    next_position(Board,Visited,Cord),
    Cord \= null,
    getPiece(Board,Cord,(_Color,Height)),
    height_bfs_aux(Board,Size,[Cord],Visited,NewVisited,Height,0,TmpMax),
    (TmpMax < CurrMax ->
        height_bfs(Board,Size,NewVisited,CurrMax,Max);
        height_bfs(Board,Size,NewVisited,TmpMax,Max)
    ).
height_bfs_aux(_,_,[],Visited,Visited,_,Max,Max).

height_bfs_aux(Board,Size,[Col-Line |  Rest],Visited,NewVisited,Height,Current_Max,Max):-
    findall(Cords, (getPositionNear(Size,Line,Col,Cords), Cords\= null,\+ member(Cords,Visited),\+ member(Cords,Rest), getPiece(Board,Cords,(_Color,Height))),
    New_Cords),
    append(Rest,New_Cords,New_queue),
    NewMax is Current_Max + 1,
    height_bfs_aux(Board,Size,New_queue,[Col-Line | Visited],NewVisited,Height,NewMax,Max).



%gets a random position in the board

getPositionNear(Size,Line,Col,Cords):-
    get_back_left(Size,Line,Col,Cords),
    Cords \= null.
getPositionNear(Size,Line,Col,Cords):-
    get_front_left(Size,Line,Col,Cords),
    Cords \= null.

getPositionNear(Size,Line,Col,Cords):-
    get_front_right(Size,Line,Col,Cords),
    Cords \= null.

getPositionNear(Size,Line,Col,Cords):-
    get_left(Size,Line,Col,Cords),
    Cords \= null.

getPositionNear(Size,Line,Col,Cords):-
    get_right(Size,Line,Col,Cords),
    Cords \= null.

getPositionNear(Size,Line,Col,Cords):-
    get_back_right(Size,Line,Col,Cords),
    Cords \= null.
getPositionNear(_,_,_,_):-fail.


%finds the next position that is not visited and isnt empty

next_position(Board, Visited, Ncol-Nline) :-
    nth0(Nline, Board, Col),
    length(Col, Ncols),
    TmpNcols is Ncols - 1,
    between(0, TmpNcols, Ncol),
    \+ member(Ncol-Nline, Visited),
    getPiece(Board, Ncol-Nline, Piece),
    \+ number(Piece),!.
next_position(_, _, null).






%se a matrix ja estiver na ultima coluna
can_not_Go_Front(Size,Line):-
    TmpSize is Size - 1,
    NewSize is TmpSize * 2 + 1,
    NewSize =<Line .

%se a matrix quiser ir para traz mas ja esta na primeira coluna


%se o diamante ja se tiver a diminuir nao vai haver front_left so front_right
get_front_left(Size,Line,_,null):-
    can_not_Go_Front(Size,Line),!.

get_front_left(Size,Line,0,null):-
    TmpSize is Size - 1,
    TmpSize=<Line,!.

get_front_left(Size,Line,Column,RColumn-RLine):-
    TmpSize is Size - 1,
    TmpSize=<Line,
    RColumn is Column - 1,
    RLine is Line + 1.

get_front_left(Size,Line,Column,Column-RLine):-
    TmpSize is Size - 1,
    Line<TmpSize,
    RLine is Line + 1.

%front_right --------------------------------------------------------------------------------------------
get_front_right(Size,Line,_,null):-
    can_not_Go_Front(Size,Line),!.

%se o diamante ja se tiver a diminuir nao vai haver se a linha for igual ao size front_right so front_left

get_front_right(Size,Line,Column,null):-
    TmpSize is Size - 1,
    TmpSize=<Line,
    Tmp is TmpSize * 2 - Line + 1,
    Tmp =:= Column,!.


get_front_right(Size,Line,Column,RColumn-RLine):-
    TmpSize is Size - 1,
    Line=<TmpSize,
    RColumn is Column+ 1,
    RLine is Line + 1.

get_front_right(Size,Line,Column,RColumn-RLine):-
    TmpSize is Size - 1,
    TmpSize<Line ,
    RColumn is Column ,
    RLine is Line + 1.

%get left --------------------------------------------------------------------------------------------

get_left(_,_,Col,null):-
    Col =:= 0,!.

get_left(_,Line,Column,RColumn-Line):-  
    RColumn is Column - 1.

%get right --------------------------------------------------------------------------------------------
get_right(Size,Line,Column,null):-
    TmpSize is Size - 1,
    TmpSize<Line,
    Tmp is TmpSize * 2 - Line +1,
    Column =:= Tmp,!.

get_right(Size,Line,Line,null):-
    TmpSize is Size - 1,
    Line =< TmpSize,!.

get_right(_,Line,Column,RColumn-Line):-
    RColumn is Column + 1.
%get back_left --------------------------------------------------------------------------------------------
get_back_left(_,Line,_,null):-
    Line =:= 0,!.

get_back_left(Size,Line,0,null):-
    TmpSize is Size - 1,
    Line=< TmpSize ,!.

get_back_left(Size,Line,Column,RColumn-RLine):-
    TmpSize is Size - 1,
    Line=<TmpSize,
    RLine is Line - 1,
    RColumn is Column - 1.

get_back_left(Size,Line,Column,RColumn-RLine):-
    TmpSize is Size - 1,
    TmpSize < Line,
    RLine is Line - 1,
    RColumn is Column.


%get back_right --------------------------------------------------------------------------------------------
get_back_right(_,Line,_,null):-
    Line =:= 0,!.

get_back_right(Size,Line,Line,null):-
    TmpSize is Size - 1,
    Line =< TmpSize,!.

get_back_right(Size,Line,Column,RColumn-RLine):-
    TmpSize is Size - 1,
    TmpSize =< Line,
    RColumn is Column + 1,
    RLine is Line - 1.


get_back_right(Size,Line,Column,RColumn-RLine):-
    TmpSize is Size - 1,
    Line < TmpSize,
    RColumn is Column,
    RLine is Line - 1.