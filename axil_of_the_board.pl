:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(aggregate)).
:- use_module(library(random)).






winner(Board, Winner) :-
    start_color_bfs(Board,MaxColor),
    start_height_bfs(Board,MaxHeight),
    getWinner(MaxColor,MaxHeight,Winner).

getWinner(MaxColor,MaxHeight,'Height'):- MaxColor < MaxHeight.
getWinner(MaxColor,MaxHeight,'Color'):- MaxHeight < MaxColor .
getWinner(MaxColor,MaxHeight,'Tie'):- MaxHeight =:= MaxColor .

getPiece(Board, Line-Col, Piece) :-
    nth0( Line,Board,Line_pieces),
    nth0(Col, Line_pieces, Piece).

get_Height(Height-_,Height).
get_Color(_-Color,Color).

%calcula o numero maximo de pecas com a mesma cor proximas umas das outras
bot_move([Board | RestGameState],'Height',Trees,BotMov):-
    get_size(Board,Size),write('start_color_bfs\n'),
    get_free_trees_in_board(0,0,Board,Board,TreesInBoard),write(TreesInBoard),write('start_color_bfs\n'),
    findall(Score-((Tree,OldCords),NewCords,NewTree), (
    %selecionar uma arvore que se pode mexer e vê se os movimentos validos e 
        member(OldCords,TreesInBoard),getPiece(Board,OldCords,Tree),write(OldCords),valid_moves([Board | RestGameState],OldCords,ValidMoves),
        write(ValidMoves),member(NewCords,ValidMoves),write('try to move\n'),move([Board | RestGameState],( (Tree ,OldCords),NewCords),[BoardUpdated | _])
        ,write('found start pieces\n'),member(NewTree,Trees),move([BoardUpdated | RestGameState],( (NewTree , -1),OldCords),[BoardUpdated1 | _]),
    height_bfs(BoardUpdated1,Size,Score)),MaxMoves),
    sort(MaxMoves,SortedMoves),
    last(SortedMoves,MaxScore-BotMov),%por random aqui
    write(MaxScore)
    .


start_color_bfs(Board,Max):-
    get_size(Board,Size),
    %write('start_color_bfs\n'),
    color_bfs(Board,Size,[],1,0,Max1),
    %write('LightGreen:'),
    %write(Max1),
    %write('\n'),
    color_bfs(Board,Size,[],2,0,Max2),
    %write('MediumLight:'),
    %write(Max2),
    %write('\n'),
    color_bfs(Board,Size,[],3,0,Max3),
    %write('MaxLight:'),
    %write(Max3),
    %write('\n'),
    Max is Max1 + Max2 + Max3.

color_bfs(Board,_,Visited,Color,CurrMax,CurrMax):-
    next_position_color(Board,Visited,Color,Cord),
    Cord == null.

color_bfs(Board,Size,Visited,Color,CurrMax,Max):-
    next_position_color(Board,Visited,Color,Cord),
    Cord \= null,
    color_bfs_aux(Board,Size,[Cord],Visited,NewVisited,Color,0,TmpMax),
    (TmpMax < CurrMax ->
        color_bfs(Board,Size,NewVisited,Color,CurrMax,Max);
        color_bfs(Board,Size,NewVisited,Color,TmpMax,Max)
    ).

color_bfs_aux(_,_,[],Visited,Visited,_,Max,Max).

color_bfs_aux(Board,Size,[Line-Col |  Rest],Visited,NewVisited,Color,Current_Max,Max):-
    findall(Cords, (getPositionNear(Size,Line,Col,Cords), Cords\= null,\+ member(Cords,Visited),\+ member(Cords,Rest), getPiece(Board,Cords,_Height-Color)),
    New_Cords),
    append(Rest,New_Cords,New_queue),
    NewMax is Current_Max + 1,
    color_bfs_aux(Board,Size,New_queue,[Line-Col | Visited],NewVisited,Color,NewMax,Max).


%calcula o numero maximo de Pecas com a mesma altura proximas umas das outras
start_height_bfs(Board,Max):-
    get_size(Board,Size),
    height_bfs(Board,Size,[],1,0,Max1),
    %write('Small:'),
    %write(Max1),
    %write('\n'),
    height_bfs(Board,Size,[],2,0,Max2),
    %write('Medium:'),
    %write(Max2),
    %write('\n'),
    height_bfs(Board,Size,[],3,0,Max3),
    %write('Max:'),
    %write(Max3),
    %write('\n'),
    Max is Max1 + Max2 + Max3.

height_bfs(Board,_,Visited,Height,CurrMax,CurrMax):-
    next_position_height(Board,Visited,Height,Cord),
    Cord == null.

height_bfs(Board,Size,Visited,Height,CurrMax,Max):-
    next_position_height(Board,Visited,Height,Cord),
    Cord \= null,
    height_bfs_aux(Board,Size,[Cord],Visited,NewVisited,Height,0,TmpMax),
    (TmpMax < CurrMax ->
        height_bfs(Board,Size,NewVisited,Height,CurrMax,Max);
        height_bfs(Board,Size,NewVisited,Height,TmpMax,Max)
    ).
height_bfs_aux(_,_,[],Visited,Visited,_,Max,Max).

height_bfs_aux(Board,Size,[Line-Col |  Rest],Visited,NewVisited,Height,Current_Max,Max):-
    findall(Cords, (getPositionNear(Size,Line,Col,Cords), Cords\= null,\+ member(Cords,Visited),\+ member(Cords,Rest), getPiece(Board,Cords,Height-_Color)),
    New_Cords),
    append(Rest,New_Cords,New_queue),
    NewMax is Current_Max + 1,
    height_bfs_aux(Board,Size,New_queue,[Line-Col | Visited],NewVisited,Height,NewMax,Max).


%gets a position in the near the position

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

next_position_height(Board, Visited,Height, Nline-Ncol) :-
    nth0(Nline, Board, Col),
    length(Col, Ncols),
    TmpNcols is Ncols - 1,
    between(0, TmpNcols, Ncol),
    \+ member(Nline-Ncol, Visited),
    getPiece(Board, Nline-Ncol, Height-_),!.
next_position_height(_, _, _,null).

next_position_color(Board, Visited,Color, Nline-Ncol) :-
    nth0(Nline, Board, Col),
    length(Col, Ncols),
    TmpNcols is Ncols - 1,
    between(0, TmpNcols, Ncol),
    \+ member(Nline-Ncol, Visited),
    getPiece(Board, Nline-Ncol, _-Color),!.

next_position_color(_, _, _,null).




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

get_front_left(Size,Line,Column,RLine-RColumn):-
    TmpSize is Size - 1,
    TmpSize=<Line,
    RColumn is Column - 1,
    RLine is Line + 1.

get_front_left(Size,Line,Column,RLine-Column):-
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


get_front_right(Size,Line,Column,RLine-RColumn):-
    TmpSize is Size - 1,
    Line=<TmpSize,
    RColumn is Column+ 1,
    RLine is Line + 1.

get_front_right(Size,Line,Column,RLine-RColumn):-
    TmpSize is Size - 1,
    TmpSize<Line ,
    RColumn is Column ,
    RLine is Line + 1.

%get left --------------------------------------------------------------------------------------------

get_left(_,_,Col,null):-
    Col =:= 0,!.

get_left(_,Line,Column,Line-RColumn):-  
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

get_right(_,Line,Column,Line-RColumn):-
    RColumn is Column + 1.
%get back_left --------------------------------------------------------------------------------------------
get_back_left(_,Line,_,null):-
    Line =:= 0,!.

get_back_left(Size,Line,0,null):-
    TmpSize is Size - 1,
    Line=< TmpSize ,!.

get_back_left(Size,Line,Column,RLine-RColumn):-
    TmpSize is Size - 1,
    Line=<TmpSize,
    RLine is Line - 1,
    RColumn is Column - 1.

get_back_left(Size,Line,Column,RLine-RColumn):-
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

get_back_right(Size,Line,Column,RLine-RColumn):-
    TmpSize is Size - 1,
    TmpSize =< Line,
    RColumn is Column + 1,
    RLine is Line - 1.


get_back_right(Size,Line,Column,RLine-RColumn):-
    TmpSize is Size - 1,
    Line < TmpSize,
    RColumn is Column,
    RLine is Line - 1.