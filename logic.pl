color(1,'Strong green').
color(2,'Medium green').
color(3,'Light green').

height(1,'High').
height(2,'Medium').
height(3,'Small').

tree(C,H):- color(C,_),height(H,_).



% Choose Trees Done

collect_available_trees(Trees, AvailableTrees) :-
    findall(H-C, (member((H-C, Quantity), Trees), Quantity > 0), AvailableTrees).

repeat_choose_tree(Tree, Trees) :-
    collect_available_trees(Trees, AvailableTrees),
    askTree(Tree),
    print_newline(2),
    member(Tree, AvailableTrees),!.


repeat_choose_tree(Tree,Trees):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid option. Please choose an available tree.\e[0m', []),
    print_newline(2),
    repeat_choose_tree(Tree,Trees).

askTree(Tree):-
    format('~*c', [40, 32]),
    write('Heights. 1- High 2-Medium 3-Small'),
    print_newline(1),
    format('~*c', [40, 32]),
    write('Colors.  1- Strong green 2- Medium green 3- Light green'),
    print_newline(1),
    format('~*c', [40, 32]),
    write('Choose a tree Height-Color: '),
    read(Tree).

choose_random_tree(Tree,Trees):-
    collect_available_trees(Trees, AvailableTrees),
    random_member(Tree, AvailableTrees).

% 

repeat_choose_valid_move(Coordinates,ValidMoves):-
    askCoordinates(Coordinates,1),
    print_newline(2),
    member(Coordinates,ValidMoves),!
.
repeat_choose_valid_move(Coordinates,ValidMoves):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid option. Please choose a valid move.\e[0m', []),
    print_newline(2),
    repeat_choose_valid_move(Coordinates,ValidMoves)
.

check_left(Board, X, Y) :- Y1 is Y - 1, Y1 >= 0, nth0(X, Board, Row), nth0(Y1, Row, -1).

check_right(Board, X, Y) :- Y1 is Y + 1,nth0(X, Board, Row),length(Row,Size), Y1 < Size, nth0(Y1, Row, -1).


check_up_right(Board, X, Y,MaxSize) :- X < MaxSize, X1 is X + 1, Y1 is Y + 1, nth0(X1,Board,Row), nth0(Y1, Row, -1).
check_up_right(Board, X, Y,MaxSize) :- X >= MaxSize,X1 is X + 1,length(Board,Size), X1 < Size, Delta is (MaxSize-(X1- MaxSize)),Delta >= Y, nth0(X1,Board,Row),nth0(Y, Row, -1).

check_up_left(Board, X, Y, MaxSize) :- X < MaxSize, X1 is X + 1 ,nth0(X1,Board,Row),nth0(Y, Row, -1).
check_up_left(Board,X,Y, MaxSize) :-  X >= MaxSize, X1 is X + 1, length(Board,Size), X1 < Size, Y1 is Y-1,Y1>=0,nth0(X1 , Board , Row) , nth0(Y1, Row, -1).

check_down_right(Board, X, Y,MaxSize) :- X =< MaxSize, X1 is X - 1,X1 >=0, X1 >= Y , nth0(X1, Board, Row), nth0(Y, Row, -1).
check_down_right(Board, X, Y,MaxSize) :- X > MaxSize, X1 is X - 1, Y1 is Y+1, nth0(X1, Board, Row), nth0(Y1, Row, -1).

check_down_left(Board,X,Y,MaxSize) :-  X =< MaxSize, X1 is X-1, X1 >= 0, Y1 is Y-1, Y1 >=0, nth0(X1,Board,Row),nth0(Y1,Row,-1).
check_down_left(Board, X, Y, MaxSize) :- X > MaxSize, X1 is X - 1, nth0(X1, Board, Row), nth0(Y, Row, -1).

filter_free([], _, []).
filter_free([X-Y|L], Board, FreeTrees) :-
    length(Board,Size),
    MaxSize is ((Size-1)//2),
    (check_left(Board, X, Y) ;
    check_right(Board,X,Y);
    check_up_right(Board, X, Y,MaxSize);
    check_up_left(Board, X, Y,MaxSize);
    check_down_right(Board, X, Y,MaxSize);
    check_down_left(Board, X, Y,MaxSize)),
    !, 
    append([X-Y], RestTrees, FreeTrees),
    filter_free(L, Board, RestTrees).
filter_free([_|L], Board, FreeTrees) :-
    filter_free(L, Board, FreeTrees).




askCoordinates(Coordinates,1):-
    format('~*c', [40, 32]),
    write('Choose a valid move (Orange hollows) as X-Y: '),
    read(Coordinates).

askCoordinates(Coordinates,2):-
    format('~*c', [40, 32]),
    write('Choose valid coordinates for free trees in board (Orange hollows) as X-Y: '),
    read(Coordinates).

repeat_choose_tree_in_board(Board,(Tree,Coordinates),TreesInBoard):-
    askCoordinates(Coordinates,2),
    member(Coordinates,TreesInBoard),
    !,
    Coordinates = X-Y,
    nth0(X,Board,List),
    nth0(Y,List,Tree).

repeat_choose_tree_in_board(Board,(Tree,Coordinates),TreesInBoard):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid option. Please choose a Tree that is on the board.\e[0m', []),
    print_newline(2),
    repeat_choose_tree_in_board(Coordinates,TreesInBoard).

get_free_trees_in_board(_, _, _, [], []).
get_free_trees_in_board(X, Y, Board, [Row | RestRows], TreesInBoard) :-
    search_row(X, Y, Row,TreeRow),
    filter_free(TreeRow,Board,FreeTrees),
    X1 is X + 1,
    get_free_trees_in_board(X1, 0,Board, RestRows, TreeRestRows),
    append(FreeTrees, TreeRestRows, TreesInBoard).

search_row(_, _, [], []).
search_row(X, Y, [Col | RestCols], TreeRow) :-
    (Col =:= -1 ->  TreeRow = RestTreeRow; 
    TreeRow = [X-Y | RestTreeRow]),
    Y1 is Y+1,
    search_row(X,Y1, RestCols, RestTreeRow).

change_turn([1], [2]).
change_turn([2], [1]).

change_turn([H | L], [H | NewRestOfState]) :-
    change_turn(L, NewRestOfState).

update_board([], _, _, _, _, []).

update_board([Row | RestRows], X, Y, FinalX, FinalY, Tree, [UpdatedRow | RestUpdatedRows]) :-
    X =\= FinalX,  
    X1 is X + 1,  
    update_board(RestRows, X1, Y, FinalX, FinalY, Tree, RestUpdatedRows),
    UpdatedRow = Row.  

update_board([Row | RestRows], X, Y, FinalX, FinalY, Tree, [UpdatedRow | RestUpdatedRows]) :-
    X =:= FinalX,  
    update_row(Row, Y, FinalY, Tree, UpdatedRow),
    RestUpdatedRows=RestRows.  



update_row([], _, _, _,[]).

update_row([Col | RestCols], Y, FinalY, Tree, [NewCol | RestUpdatedCols]) :-
    Y =\= FinalY,
    Y1 is Y+1,
    update_row(RestCols, Y1, FinalY, Tree, RestUpdatedCols),
    NewCol=Col.
update_row([_ | RestCols], Y, Y, Tree, [NewTree | NewRestCols]):-
    NewTree=Tree,
    NewRestCols=RestCols.


updateTrees(_, [], []).


updateTrees(X-Y, [(X-Y, Amount) | RestTrees], [(X-Y, Amount1) | RestTrees]) :-
    Amount1 is Amount - 1.

updateTrees(X-Y, [(X1-Y1, Amount) | RestTrees], [(X1-Y1, Amount) | RestUpdatedTrees]) :-
    (X =\= X1 ; Y =\= Y1),
    updateTrees(X-Y, RestTrees, RestUpdatedTrees).

move([Board,Trees1,Trees2,Amount,Turn], ((Tree,-1), FinalX-FinalY), [FinalBoard,NewTrees1,NewTrees2,NewAmount,Turn]) :-
    update_board(Board, 0, 0, FinalX,FinalY, Tree, FinalBoard),
    NewAmount is Amount-1,
    (Turn =:= 1 ->
    updateTrees(Tree,Trees1,NewTrees1),
    NewTrees2=Trees2;
    updateTrees(Tree,Trees2,NewTrees2),
    NewTrees1=Trees1
    )
.
move([Board | RestOfState], ((Tree, OldX-OldY), NewX-NewY), [FinalBoard| RestOfState]) :-
    update_board(Board,0,0, OldX, OldY, -1, UpdatedBoard), 
    update_board(UpdatedBoard,0,0, NewX, NewY, Tree, FinalBoard)
. 

/* Get valid moves for initial state */

get_valid_moves_initial([], _, []).

get_valid_moves_initial([Row|RestRows], RowIndex, ValidMoves) :-
    get_row_moves_initial(Row, RowIndex, 0, RowMoves),
    NewRowIndex is RowIndex + 1,
    get_valid_moves_initial(RestRows, NewRowIndex, RestMoves),
    append(RowMoves, RestMoves, ValidMoves).

get_row_moves_initial([], _, _, []).

get_row_moves_initial([-1|Rest], Row, Col, [Row-Col|RowMoves]) :-
    NewCol is Col + 1,
    get_row_moves_initial(Rest, Row, NewCol, RowMoves).

valid_moves([Board,_,_,54,_],_,ValidMoves):-
    get_valid_moves_initial(Board,0,ValidMoves).

get_valid_moves_row_left(X, Y, Row, RowLeftValidMoves) :-
    Y1 is Y - 1,
    (Y1 >= 0 ->
        nth0(Y1, Row, Element),
        (Element =:= -1 ->
            get_valid_moves_row_left(X, Y1, Row, RestValidMoves),
            append([X-Y1], RestValidMoves, RowLeftValidMoves);
        RowLeftValidMoves = []
        );
    RowLeftValidMoves = []).

get_valid_moves_row_right(X, Y, Row, RowRightValidMoves) :-
    length(Row, L),
    Y1 is Y + 1,
    (Y1 < L ->
        nth0(Y1, Row, Element),
        (Element =:= -1 ->
            get_valid_moves_row_right(X, Y1, Row, RestValidMoves),
            append([X-Y1], RestValidMoves, RowRightValidMoves);
        RowRightValidMoves = []
        );
    RowRightValidMoves = []).



get_valid_moves_up_right(L, C, MaxSize, Board, UpRightValidMoves) :-
    L < MaxSize,
    L1 is L + 1,
    C1 is C + 1,
    nth0(L1, Board, List),
    nth0(C1, List, Element),
    (Element =:= -1 ->
        get_valid_moves_up_right(L1, C1, MaxSize, Board, RestValidMoves),
        append([L1-C1], RestValidMoves, UpRightValidMoves);
    UpRightValidMoves = []
).
get_valid_moves_up_right(L, C, MaxSize, Board, UpRightValidMoves) :-
    L >= MaxSize,

    L1 is L + 1,
    length(Board,Size),
    Delta is (MaxSize-(L1- MaxSize)),
    
    (Delta >= C , L1 < Size  ->(
    nth0(L1, Board, List),
    nth0(C, List, Element),
    (Element =:= -1 ->
        get_valid_moves_up_right(L1, C, MaxSize, Board, RestValidMoves),
        append([L1-C], RestValidMoves, UpRightValidMoves);
    UpRightValidMoves = []));
    UpRightValidMoves = [])
.
get_valid_moves_up_left(L, C, MaxSize, Board, UpLeftValidMoves) :-
    L < MaxSize,
    L1 is L + 1,
    nth0(L1, Board, List),
    nth0(C, List, Element),
    (Element =:= -1 ->
        get_valid_moves_up_left(L1, C, MaxSize, Board, RestValidMoves),
        append([L1-C], RestValidMoves, UpLeftValidMoves);
    UpLeftValidMoves = []
).
get_valid_moves_up_left(L, C, MaxSize, Board, UpLeftValidMoves) :-
    L >= MaxSize,
    L1 is L + 1,
    C1 is C - 1,
    length(Board,Size),
    (C1 >=0 , L1 < Size -> (
    nth0(L1, Board, List),
    nth0(C1, List, Element),
    (Element =:= -1 ->
        get_valid_moves_up_left(L1, C1, MaxSize, Board, RestValidMoves),
        append([L1-C1], RestValidMoves, UpLeftValidMoves);
    UpLeftValidMoves = []))
    ;UpLeftValidMoves = []).

get_valid_moves_down_right(L, C, MaxSize, Board, DownRightValidMoves) :-
    L =< MaxSize,
    L1 is L - 1,
    (L1 >= C, L1 >=0 ->(
    nth0(L1, Board, List),
    nth0(C, List, Element),
    (Element =:= -1 ->
        get_valid_moves_down_right(L1, C, MaxSize, Board, RestValidMoves),
        append([L1-C], RestValidMoves, DownRightValidMoves);
    DownRightValidMoves = []));
    DownRightValidMoves = []).

get_valid_moves_down_right(L, C, MaxSize, Board, DownRightValidMoves) :-
    L > MaxSize,
    L1 is L - 1,
    C1 is C + 1,
    nth0(L1, Board, List),
    nth0(C1, List, Element),
    (Element =:= -1 ->
        get_valid_moves_down_right(L1, C1, MaxSize, Board, RestValidMoves),
        append([L1-C1], RestValidMoves, DownRightValidMoves);
    DownRightValidMoves = []).


get_valid_moves_down_left(L, C, MaxSize, Board, DownLeftValidMoves) :-
    L =< MaxSize,
    L1 is L - 1,
    C1 is C - 1,
    (C1 >=0 , L1 >=0 -> (
    nth0(L1, Board, List),
    nth0(C1, List, Element),
    (Element =:= -1 ->
        get_valid_moves_down_left(L1, C1, MaxSize, Board, RestValidMoves),
        append([L1-C1], RestValidMoves, DownLeftValidMoves);
    DownLeftValidMoves = []));
    DownLeftValidMoves = [])
.

get_valid_moves_down_left(L, C, MaxSize, Board, UpLeftValidMoves) :-
    L > MaxSize,
    L1 is L - 1,
    nth0(L1, Board, List),
    nth0(C, List, Element),
    (Element =:= -1 ->
        get_valid_moves_down_left(L1, C, MaxSize, Board, RestValidMoves),
        append([L1-C], RestValidMoves, DownLeftValidMoves);
    DownLeftValidMoves = []).


/* Get valid moves for middle game state */
valid_moves([Board,_,_,_,_],X-Y,ValidMoves):-
    nth0(X,Board,Row),
    get_valid_moves_row_right(X,Y,Row,RowRightValidMoves),
    get_valid_moves_row_left(X,Y,Row,RowLeftValidMoves),
    length(Board,Size),
    MaxSize is ((Size-1)//2),
    get_valid_moves_up_right(X,Y,MaxSize,Board,UpRightVaildMoves),
    get_valid_moves_up_left(X,Y,MaxSize,Board,UpLeftValidMoves),
    get_valid_moves_down_right(X,Y,MaxSize,Board,DownRightValidMoves),
    get_valid_moves_down_left(X,Y,MaxSize,Board,DownLeftValidMoves),
    append(RowRightValidMoves, RowLeftValidMoves, Temp1),
    append(UpRightVaildMoves,Temp1, Temp2),
    append(Temp2, UpLeftValidMoves, Temp3),
    append(Temp3, DownRightValidMoves, Temp4),
    append(Temp4, DownLeftValidMoves, ValidMoves)
.





/* Get valid moves for final state (no moves) */
% valid_moves([Board,_,_,0,_],_,[]).
   





