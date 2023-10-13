  % Define a predicate to retrieve and convert the TERMINAL_WIDTH environment variable.
get_terminal_width(Width) :-
    environ('TERMINAL_WIDTH', WidthAtom),  % Retrieve the environment variable
    atom_chars(WidthAtom, Y), number_chars(Width, Y).      % Convert to an integer

  get_terminal_height(Height):-
    environ('TERMINAL_HEIGHT',HeightAtom),
    atom_chars(HeightAtom,Y),number_chars(Height,Y).
%convert symbols in the matrix to the screen
draw_Piece(-1):-
    write(' '),
    write('_'),
    write(' ').


draw_Piece(0):-
    write('   ').

draw_matrix([]).

draw_matrix([Head | Tail]):-
    draw_line(Head),
    write('\n'),

    draw_matrix(Tail).

draw_line([]).

draw_line([Head | Tail]):-
    draw_Piece(Head),
    draw_line( Tail).


