



game_over([Board| _Rest],Winner):-
    winner(Board, Winner).

/*
   recebe um Board que avalia e devolve o vencedor Cores ou Alturas
*/
% winner(+Board,-winner)
winner(Board, Winner) :-
    count_color_values(Board,MaxColor),
    count_height_values(Board,MaxHeight),
    getWinner(MaxColor,MaxHeight,Winner).

getWinner(MaxColor,MaxHeight,1):- MaxColor < MaxHeight.% height won
getWinner(MaxColor,MaxHeight,2):- MaxHeight < MaxColor .% color won
getWinner(MaxColor,MaxHeight,0):- MaxHeight =:= MaxColor .% draw

/*
   recebe um Board que avalia , uma posição para devolver a tree que la esta ou -1 se nao estiver la nenhuma arvore
*/
% getPiece(+ Board, +Cords, -Piece)
getPiece(Board, Line-Col, Piece) :-
    nth0( Line,Board,Line_pieces),
    nth0(Col, Line_pieces, Piece).

get_Height(Height-_,Height).
get_Color(_-Color,Color).


/*
   recebe um Board que avalia devolve os pontos do jogador por cores
*/
% count_color_values(+Board,-Max)

count_color_values(Board,Max):-
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

/*
   uma função que atravez de chamadas recurssivas calcula o numero de peças do aglomerado maior de uma certa cor que é recebida como input Color no Board recebido
*/
% count_color_values( +Board,+Size,+Visited,+Color,+CurrMax,-Max)
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

/*
  Função que utiliza Bfs para calcular o numero de peças do aglomerado maior de uma certa cor que é recebida  como input Color no Board recebido e a 
  peça inicial é recebida para começar o bfs esta função é o bfs em si
*/
% color_bfs_aux( +Board,+Size,+Visited,-NewVisited,+Color,+CurrMax,-Max)

color_bfs_aux(_,_,[],Visited,Visited,_,Max,Max).

color_bfs_aux(Board,Size,[Line-Col |  Rest],Visited,NewVisited,Color,Current_Max,Max):-
    findall(Cords, (getPositionNear(Size,Line,Col,Cords), Cords\= null,\+ member(Cords,Visited),\+ member(Cords,Rest), getPiece(Board,Cords,_Height-Color)),
    New_Cords),
    append(Rest,New_Cords,New_queue),
    NewMax is Current_Max + 1,
    color_bfs_aux(Board,Size,New_queue,[Line-Col | Visited],NewVisited,Color,NewMax,Max).

/*
   recebe um Board que avalia devolve os pontos do jogador por alturas
*/
% count_color_values(+Board,-Max)
count_height_values(Board,Max):-
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
/*
   uma função que atravez de chamadas recurssivas calcula o numero de peças do aglomerado maior de uma certa height que é recebida como input height no Board recebido
*/
% count_color_values( +Board,+Size,+Visited,+Color,+CurrMax,-Max)


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

/*
  Função que utiliza Bfs para calcular o numero de peças do aglomerado maior de uma certa heigth que é recebida  como input Color no Board recebido e a 
  peça inicial é recebida para começar o bfs esta função é o bfs em si
*/
% color_bfs_aux( +Board,+Size,+Visited,-NewVisited,+Height,+CurrMax,-Max)
height_bfs_aux(_,_,[],Visited,Visited,_,Max,Max).

height_bfs_aux(Board,Size,[Line-Col |  Rest],Visited,NewVisited,Height,Current_Max,Max):-
    findall(Cords, (getPositionNear(Size,Line,Col,Cords), Cords\= null,\+ member(Cords,Visited),\+ member(Cords,Rest), getPiece(Board,Cords,Height-_Color)),
    New_Cords),
    append(Rest,New_Cords,New_queue),
    NewMax is Current_Max + 1,
    height_bfs_aux(Board,Size,New_queue,[Line-Col | Visited],NewVisited,Height,NewMax,Max).


/*
  esta função é utilizada para encontrar alguma peça que esteja proxima da linha (+Line) e coluna (+Colum) recebida como input as cords recebidas são da peça selecionada
*/
% getPositionNear(+Size,+Line,+Col,-Cords)

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


/*
  finds the next position that is not visited and isnt empty with the height of the input
  */
% next_position_height( +Board, +Visited,+Height, -Nline-Ncol)


next_position_height(Board, Visited,Height, Nline-Ncol) :-
    nth0(Nline, Board, Col),
    length(Col, Ncols),
    TmpNcols is Ncols - 1,
    between(0, TmpNcols, Ncol),
    \+ member(Nline-Ncol, Visited),
    getPiece(Board, Nline-Ncol, Height-_),!.
next_position_height(_, _, _,null).

/*
  finds the next position that is not visited and isnt empty with the Color of the input
  */
% next_position_color(+Board, +Visited, + Color, -Nline-Ncol)
next_position_color(Board, Visited,Color, Nline-Ncol) :-
    nth0(Nline, Board, Col),
    length(Col, Ncols),
    TmpNcols is Ncols - 1,
    between(0, TmpNcols, Ncol),
    \+ member(Nline-Ncol, Visited),
    getPiece(Board, Nline-Ncol, _-Color),!.

next_position_color(_, _, _,null).



/*
  checks if according to the size of the board the next position of the line is valid, example if the line is the last one it cant go front
  */
% can_not_Go_Front(+Size,+Line)

can_not_Go_Front(Size,Line):-
    TmpSize is Size - 1,
    NewSize is TmpSize * 2 + 1,
    NewSize =<Line .



/*
  checks if according to the size and the line and column can go front left there are 6 possible moves front_left,front_right,left,right,back_left,back_right
  and if it can it return the cords of the position needed to go to
  */
% get_front_left( +Size, +Line, +Column, -RLine-RColumn)

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

/*
  checks if according to the size and the line and column can go front right there are 6 possible moves front_left,front_right,left,right,back_left,back_right
  and if it can it return the cords of the position needed to go to
  */
% get_front_right( +Size, +Line, +Column, -RLine-RColumn)



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

/*
  checks if according to the size and the line and column can go left there are 6 possible moves front_left,front_right,left,right,back_left,back_right
  and if it can it return the cords of the position needed to go to
  */
% get_left( +Size, +Line, +Column, -RLine-RColumn)


get_left(_,_,Col,null):-
    Col =:= 0,!.

get_left(_,Line,Column,Line-RColumn):-  
    RColumn is Column - 1.

/*
  checks if according to the size and the line and column can go right there are 6 possible moves front_left,front_right,left,right,back_left,back_right
  and if it can it return the cords of the position needed to go to
  */
% get_right( +Size, +Line, +Column, -RLine-RColumn)
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
/*
  checks if according to the size and the line and column can go back left there are 6 possible moves front_left,front_right,left,right,back_left,back_right
  and if it can it return the cords of the position needed to go to
  */
% get_back_left( +Size, +Line, +Column, -RLine-RColumn)
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


/*
  checks if according to the size and the line and column can go back right there are 6 possible moves front_left,front_right,left,right,back_left,back_right
  and if it can it return the cords of the position needed to go to
  */
% get_back_right( +Size, +Line, +Column, -RLine-RColumn)
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