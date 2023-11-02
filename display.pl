initial_state_size(1,[Matrix,[(1-1,3),(1-2,3),(1-3,3),(2-1,3),(2-2,3),(2-3,3),(3-1,3),(3-2,3),(3-3,3)],[(1-1,3),(1-2,3),(1-3,3),(2-1,3),(2-2,3),(2-3,3),(3-1,3),(3-2,3),(3-3,3)],54,1]):-
        generate_matrix(7,Matrix).


print_valid_moves([]).
print_valid_moves([X-Y|H]):-
        format('~w-~w ',[X,Y]),
        print_valid_moves(H).


  