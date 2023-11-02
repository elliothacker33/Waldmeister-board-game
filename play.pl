play_game([Board,Trees1,Trees2,54,Turn], Player1, Player2) :-

    InitialState=[Board,Trees1,Trees2,54,Turn], 
    Player1=(PlayerNumber1, PlayerDifficulty1, Goal1),
    Player2=(PlayerNumber2, PlayerDifficulty2, Goal2),
    % display_game(InitialState),

    valid_moves(InitialState,_,ValidMoves),
    print_valid_moves(ValidMoves),

    (PlayerDifficulty1 =:= -1 ->
    repeat_choose_tree(Tree, Trees1),
    repeat_choose_valid_move(Coordinates, ValidMoves),
    move(InitialState, ((Tree,-1), Coordinates), TurnState);

    choose_move(InitialState,1,1, (ValidMoves,Tree,Coordinates)),
    move(InitialState, ((Tree,-1), Coordinates), TurnState)
    ),

    change_turn(TurnState,MiddleState),

    % display_game(MiddleState),

    valid_moves(MiddleState,Coordinates,ValidMoves1),
    print_valid_moves(ValidMoves1),
    (PlayerDifficulty2 =:= -1 -> 
    repeat_choose_valid_move(NewCoordinates,ValidMoves1),
    move(MiddleState,((Tree,Coordinates),NewCoordinates),TurnState1);

    choose_move(InitialState,2,1,(ValidMoves1,Coordinates)),
    move(MiddleState,((Tree,Coordinates),NewCoordinates),TurnState1)
    ),
    
    change_turn(TurnState1,FinalState),

    % display_game(FinalState),

    play_game(FinalState,Player1, Player2)
.

play_game([Board,Trees1,Trees2,0,_], (PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2)):-
    GameOverState=[Board,Trees1,Trees2,0,_],
    % display_game(GameOverState),
    game_over(GameOverState,Winner),
    display_Winner(Winner,Player1)
.

play_game(GameState, (PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2)):-
    GameState=[Board,Trees1,Trees2,Amount,Turn],
    % display_game(GameState),
    get_free_trees_in_board(0,0,Board,Board,TreesInBoard), 

    (Turn =:= 1 ->
     (PlayerDifficulty1 =:= -1 ->
     print_list(TreesInBoard),
     repeat_choose_tree_in_board(Board,(Tree,OldCoordinates),TreesInBoard),
     valid_moves(GameState,OldCoordinates,ValidMoves), 
     print_valid_moves(ValidMoves),
     repeat_choose_valid_move(NewCoordinates,ValidMoves),
     move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
     repeat_choose_tree(NewTree, Trees1),
     move(MiddleState,((NewTree,-1),OldCoordinates),TurnState)
     ;
     PlayerDifficulty2 =:= 1->
     choose_move(GameState,1,1,(TreesInBoard,Tree,OldCoordinates,NewCoordinates)),
     move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
     choose_move(MiddleState,1,1,NewTree),
     move(MiddleState,((NewTree,-1),OldCoordinates),TurnState)
     ;
     choose_move(GameState,1,2,(TreesInBoard,Tree,OldCoordinates,NewCoordinates)),
     move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
     choose_move(MiddleState,1,2,(OldCoordinates,NewTree)),
     move(MiddleState,((NewTree,-1),OldCoordinates),TurnState)
     )
     ;
     (PlayerDifficulty2 =:= -1 -> 
     print_list(TreesInBoard),
     repeat_choose_tree_in_board(Board,(Tree,OldCoordinates),TreesInBoard),
     valid_moves(GameState,OldCoordinates,ValidMoves), 
     print_valid_moves(ValidMoves),
     repeat_choose_valid_move(NewCoordinates,ValidMoves),
     move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
     repeat_choose_tree(NewTree, Trees2),
     move(MiddleState,((NewTree,-1),OldCoordinates),TurnState)
     ; 
     PlayerDifficulty2 =:= 1->
     choose_move(GameState,2,1,(TreesInBoard,Tree,OldCoordinates,NewCoordinates)),
     move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
     choose_move(MiddleState,2,1,NewTree),
     move(MiddleState,((NewTree,-1),OldCoordinates),TurnState)
    ;
     choose_move(GameState,2,2,(TreesInBoard,Tree,OldCoordinates,NewCoordinates)),
     move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
     choose_move(MiddleState,2,2,(OldCoordinates,NewTree)),
     move(MiddleState,((NewTree,-1),OldCoordinates),TurnState)
    )
    ),
    % display_game(MiddleState),
    change_turn(TurnState,FinalState),
    play_game(FinalState,(PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2))
.

