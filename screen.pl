

%convert symbols in the matrix to the screen
draw_Piece(-1):-
    write(' '),
    write('_'),
    write(' ').


draw_Piece(0):-
    write('   ').


draw_matrix([Head | Tail]):-
    draw_line(Head),
    write('\n'),

    draw_matrix(Tail).

draw_line([]).

draw_line([Head | Tail]):-
    draw_Piece(Head),
    draw_line( Tail).


