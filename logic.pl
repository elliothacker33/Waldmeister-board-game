color(1,'Strong green').
color(2,'Medium green').
color(3,'Light green').

height(1,'High').
height(2,'Medium').
height(3,'Small').

tree(C,H):- color(C,_),height(H,_).

goal(1,'colors').
goal(2,'heights').

/* !! Improve this functions */ 
get_turn(InitialState,Turn):-
    length(InitialState,L),
    L1 is L-1,
    nth0(L1,InitialState,Turn).


available_Tree(Height-Color, []) :- fail.

available_Tree(Height-Color, [(H-C, Quantity) | _]) :-
    Height == H, Color == C, Quantity > 0.

available_Tree(Height-Color, [_ | Rest]) :-
    available_Tree(Height-Color, Rest).

repeat_choose_tree(Tree,Trees1):-
    askTree(Tree),
    print_newline(2),
    available_Tree(Tree,Trees1),!.

repeat_choose_tree(Tree,Trees1):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid option. Please choose an available tree.\e[0m', []),
    print_newline(2),
    repeat_choose_tree(Tree,Trees1).

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

repeat_choose_valid_move(Coordinates,ValidMoves):-
    askCoordinates(Coordinates),
    print_newline(2),
    member(Coordinates,ValidMoves),!
.
repeat_choose_valid_move(Coordinates,ValidMoves):-
    format('~*c', [40, 32]),
    format('\e[48;5;208m\e[97mERROR: Invalid option. Please choose a valid move.\e[0m', []),
    print_newline(2),
    repeat_choose_valid_move(Coordinates,ValidMoves)
.

askCoordinates(Coordinates):-
    format('~*c', [40, 32]),
    write('Choose a valid move (Orange hollows) as X-Y: '),
    read(Coordinates).

update_board([], _, _, _, _, []).

% Recursive case: When updating rows, process the current row and recursively update the rest of the rows.
update_board([Row | RestRows], X, Y, FinalX, FinalY, Tree, [UpdatedRow | RestUpdatedRows]) :-
    X \== FinalX,  % X is not equal to FinalX
    X1 is X + 1,  % Increment X
    update_board(RestRows, X1, Y, FinalX, FinalY, Tree, RestUpdatedRows),
    UpdatedRow = Row.  % Keep the current row as is

% Recursive case: When updating columns, update the current row and recursively update the rest of the rows.
update_board([Row | RestRows], X, Y, FinalX, FinalY, Tree, [UpdatedRow | RestUpdatedRows]) :-
    X == FinalX,  % X is equal to FinalX
    update_row(Row, Y, FinalY, Tree, UpdatedRow),
    RestUpdatedRows=RestRows.  % Update the current row



update_row([], _, _, []).
update_row([Col | RestCols], Y, FinalY, Tree, [NewCol | RestUpdatedCols]) :-
    Y=/=FinalY,
    Y1 is Y+1,
    update_row(RestCols, Y1, FinalY, Tree, RestUpdatedCols),
    NewCol=Col.
update_row([_ | RestCols], Y, Y, Tree, [NewTree | NewRestCols]):-
    NewTree=Tree,
    NewRestCols=RestCols.




move([Board,Trees1,Trees2,Amount,Turn], ((Tree,-1), FinalX-FinalY), [FinalBoard,Trees1,Trees2,NewAmount,Turn]) :-
    update_board(Board, 0, 0, FinalX,FinalY, Tree, FinalBoard),
    NewAmount is Amount-1
.

move([Board | RestOfState], ((Tree, OldX-OldY), NewX-NewY), [UpdatedBoard | RestOfState]) :-
    update_board(Board, OldX, OldY, -1, UpdatedBoard), 
    update_board(UpdatedBoard, NewX, NewY, Tree, FinalBoard). 

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

/* Get valid moves for middle game state */
% valid_moves([Board,_,_,_,_],_,ValidMoves):-


/* Get valid moves for final state (no moves) */
% valid_moves([Board,_,_,0,_],_,[]).
   





