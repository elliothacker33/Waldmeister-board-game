play_game([Board,Trees1,Trees2,54,Turn], Player1, Player2) :-
    InitialState=[Board,Trees1,Trees2,54,Turn],
    Player1=(PlayerNumber1, PlayerName1, Goal1),
    Player2=(PlayerNumber2, PlayerName2, Goal2),
    % display_game(InitialState),
    valid_moves(InitialState,_,ValidMoves),
    (Turn =:= 1 ->
        repeat_choose_tree(Tree, Trees1);
        repeat_choose_tree(Tree, Trees2)
    ),
    repeat_choose_valid_move(Coordinates, ValidMoves),
    move(InitialState, ((Tree,-1), Coordinates), TurnState),
    change_turn(TurnState,MiddleState),
    valid_moves(MiddleState,Coordinates,ValidMoves1),
    repeat_choose_valid_move(NewCoordinates,ValidMoves1),
    move(MiddleState,((Tree,Coordinates),NewCoordinates),TurnState1), 
    change_turn(TurnState1,FinalState),
    play_game(FinalState,Player1, Player2)
.

play_game([Board,Trees1,Trees2,0,_], (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2)):-
    GameOverState=[Board,Trees1,Trees2,0,_],
    display_game(GameOverState),
    game_over(GameOverState,Winner),
    display_Winner(Winner,Player1)
.

play_game(GameState, (PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2)):-
    GameState=[Board,Trees1,Trees2,Amount,Turn],
    % display_game(GameState),
    get_free_trees_in_board(0,0,Board,Board,TreesInBoard), 
    repeat_choose_tree_in_board(Board,(Tree,OldCoordinates),TreesInBoard),
    valid_moves(GameState,OldCoordinates,ValidMoves), 
    repeat_choose_valid_move(NewCoordinates,ValidMoves),
    move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
    % display_game(MiddleState),
    (Turn =:= 1 ->
        repeat_choose_tree(Tree, Trees1);
        repeat_choose_tree(Tree, Trees2)
    ),
    move(MiddleState,((Tree,-1),OldCoordinates),TurnState),
    change_turn(TurnState,FinalState),
    play_game(FinalState,(PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2))
.

winner((PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2), Points1, Points2):-
    format("Winner: ~w (Player ~w) with Goal ~w and Points ~w~n", [PlayerName1, PlayerNumber1, Goal1, Points1]),
    format("Loser: ~w (Player ~w) with Goal ~w and Points ~w~n", [PlayerName2, PlayerNumber2, Goal2, Points2]).


draw((PlayerNumber1, PlayerName1, Goal1), (PlayerNumber2, PlayerName2, Goal2), Points1, Points2):-
    format("It's a draw! Both players have the same points.~n"),
    format("Player ~w (Goal ~w) has Points: ~w~n", [PlayerName1, Goal1, Points1]),
    format("Player ~w (Goal ~w) has Points: ~w~n", [PlayerName2, Goal2, Points2]).

game_over(GameOverState,Winner):-
    value(GameOverState,1, V1),
    value(GameOverState,2, V2),
    (V1 > V2 ->
        Winner=(1,V1,V2)
    ;
    V1 =:= V2 ->
        Winner=(0,V1,V2)
    ;
        Winner=(2,V2,V1)
).