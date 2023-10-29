play_game_Initial(InitialState, (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2)) :-
    initial_state_size(1,InitialState),
    get_turn(InitalState,Turn),
    (Turn == 1->
      write("~w. ~w is playing now to goal ~w ",[PlayerNumber1,PlayerName1,Goal1]);
      write("~w. ~w is playing now to goal ~w", [PlayerNumber2,PlayerName2,Goal2])
    ),
    % display_game(InitialState),
    valid_moves(InitialState, (PlayerNumber1, PlayerName1, Goal1), ValidMoves),
    print_valid_moves(ValidMoves),
    write('Choose one place for the tree (format: X-Y): '),
    read(Coordinates),
    (member(Coordinates, ValidMoves) ->
        move(InitialState, Coordinates, FinalState),
        % display_game(FinalState),
        play_game_GameState(FinalState, (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2))
    ;
    write('Invalid move. Try to play again.'),
    nl,
    play_game_Initial(InitialState, (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2))
).


play_game_GameState(GameState, (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2)):-
    get_trees_to_play(InitalState,TreesToPlay),
    TreesToPlay > 0,
    check_end_game,
    get_turn(InitialState,Turn),
    make_moves.

play_game_GameState(EndState, (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2)) :-
    value(Goal1, V1),
    value(Goal2, V2),

    (V1 > V2 ->
        winner((PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2), V1, V2)
    ;
    V1 =:= V2 ->
        draw((PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2), V1, V2)
    ;
        winner((PlayerNumber2, PlayerName2, Goal2), (PlayerNumber1, PlayerName1, Goal1), V2, V1)
    ).


winner((PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2), Points1, Points2) :-
    format("Winner: ~w (Player ~w) with Goal ~w and Points ~w~n", [PlayerName1, PlayerNumber1, Goal1, Points1]),
    format("Loser: ~w (Player ~w) with Goal ~w and Points ~w~n", [PlayerName2, PlayerNumber2, Goal2, Points2]).


draw((PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2), Points1, Points2) :-
    format("It's a draw! Both players have the same points.~n"),
    format("Player ~w (Goal ~w) has Points: ~w~n", [PlayerName1, Goal1, Points1]),
    format("Player ~w (Goal ~w) has Points: ~w~n", [PlayerName2, Goal2, Points2]).

