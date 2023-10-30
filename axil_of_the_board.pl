:- use_module(library(lists)).

next_position(Board,Column_Number,_,_,-1,-1):-
    length(Board,Size),
    Size < Column_Number.

next_position(Board,Column_Number,Line_number,Visited,Result_col,Result_line):-
    nth0(Column_Number,Board,Col),
    length(Col,Size),
    Line_number =:= Size,
    Tmp_col is Column_Number + 1,
    next_position(Board,Tmp_col,0,Visited,Result_col,Result_line).

next_position(Board,Column_Number,Line_number,Visited,Result_col,Result_line):-
    nth0(Column_Number,Board,Col),
    length(Col,Size_line),
    Line_number < Size_line,
    Newline is Line_number + 1,
    nth0(Newline,Board,Place),
    Place \= -1,
    member((Column_Number,Newline),Visited),
    next_position(Board,Column_Number,Newline,Visited,Result_col,Result_line).

next_position(Board,Column_Number,Line_number,Visited,Column_Number,Newline):-
    nth0(Column_Number,Board,Col),
    length(Col,Size_line),
    Line_number < Size_line,
    Newline is Line_number + 1,
    nth0(Newline,Board,Place),
    Place \= -1,
    \+ member((Column_Number,Newline),Visited).


%se a matrix ja estiver na ultima coluna
can_not_Go_Front(Size,Line):-
    NewSize is Size * 2,
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
    TmpSize is Size - 1,
    can_not_Go_Front(TmpSize,Line),!.

%se o diamante ja se tiver a diminuir nao vai haver se a linha for igual ao size front_right so front_left

get_front_right(Size,Line,Column,null):-
    TmpSize is Size - 1,
    TmpSize=<Line,
    Tmp is TmpSize * 2 - Line,
    write(Tmp),
    Tmp =:= Column,!.


get_front_right(Size,Line,Column,RColumn-RLine):-
    TmpSize is Size - 1,
    Line=<TmpSize,
    RColumn is Column,
    RLine is Line + 1.

get_front_right(Size,Line,Column,RColumn-RLine):-
    TmpSize is Size - 1,
    TmpSize<Line ,
    RColumn is Column + 1,
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
    Column is TmpSize * 2 - Line,!.

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