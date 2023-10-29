color(1,'strong green').
color(2,'medium green').
color(3,'light green').

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

get_trees_to_play(InitialState,TreesToPlay):-
    length(InitialState,L),
    L1 is L-2,
    nth0(L1,InitialState,TreesToPlay).



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
valid_moves([Board,_,_,_,_],_,ValidMoves):-
.

/* Get valid moves for final state (no moves) */
% valid_moves(EndState,_,[]).
   

createState(GameState,X,Y,FinalState):-

.

move(GameState, FinalState):-
    questionInitialState(GameState),
	validMoves(GameState),
    write('Choose one place for the tree (format: X-Y): '),
    read(Coordinates),
    atom_chars(Coordinates, [XAtom, '-', YAtom]),
    number_chars(X, XAtom),
    number_chars(Y, YAtom),
    createState(GameState, X, Y, FinalState).

move(GameState):-

.


