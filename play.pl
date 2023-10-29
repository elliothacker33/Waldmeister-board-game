play_game_Initial([Board,Trees1,Trees2,54,Turn], (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2)) :-
    InitialState=[Board,Trees1,Trees2,54,Turn],
    display_game(InitialState),
    valid_moves(InitialState, _, ValidMoves),
    get_trees_to_play(InitialState, TreesToPlay),
    choose_tree_in_TreesToPlay(Tree, TreesToPlay),
    choose_coordinates_in_ValidMoves(Coordinates, ValidMoves),
    move(InitialState, (Tree, Coordinates), FinalState),
    play_game_GameState(FinalState, (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2))
.
play_game_GameState([Board,Trees1,Trees2,0,Turn], (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2)) :-
    display_game(EndState),
    game_over(EndState,Winner),
    value(EndState,Goal1, V1),
    value(EndState,Goal2, V2),

    (V1 > V2 ->
        winner((PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2), V1, V2)
    ;
    V1 =:= V2 ->
        draw((PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2), V1, V2)
    ;
        winner((PlayerNumber2, PlayerName2, Goal2), (PlayerNumber1, PlayerName1, Goal1), V2, V1)
).
play_game_GameState(GameState, (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2)):-
    display_game(GameState),
    get_trees_in_board(GameState,TreesInBoard),
    choose_tree_in_board(Tree,TreesInBoard),
    valid_moves(GameState,(_,Coordinates),ValidMoves),
    choose_coordinates_in_ValidMoves(NewCoordinates,ValidMoves),
    move(GameState,(Tree,NewCoordinates),MiddleState),
    display_game(MiddleState),
    get_trees_to_play(MiddleState,TreesToPlay),
    choose_tree_in_TreesToPlay(NewTree,TreesToPlay),
    move(MiddleState,(NewTree,Coordinates),FinalState),
    play_game_GameState(FinalState,(PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2))
.



winner((PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2), Points1, Points2):-
    format("Winner: ~w (Player ~w) with Goal ~w and Points ~w~n", [PlayerName1, PlayerNumber1, Goal1, Points1]),
    format("Loser: ~w (Player ~w) with Goal ~w and Points ~w~n", [PlayerName2, PlayerNumber2, Goal2, Points2]).


draw((PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2), Points1, Points2):-
    format("It's a draw! Both players have the same points.~n"),
    format("Player ~w (Goal ~w) has Points: ~w~n", [PlayerName1, Goal1, Points1]),
    format("Player ~w (Goal ~w) has Points: ~w~n", [PlayerName2, Goal2, Points2]).

