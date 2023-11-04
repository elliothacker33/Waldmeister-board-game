/*

 play_game is the predicate that executes the loop game. 
 Contains the logic and steps of the game.

 play_game([Board,Trees1,Trees2,54,Turn], (PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2)) -> Logic for the InitialState.
 play_game(GameState, (PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2)) -> Logic for the rest of the game until game_over.
 play_game([Board,Trees1,Trees2,0,_], (PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2)) -> Game over logic
 
*/

% play_game(+GameState,+Player1,+Player2)

play_game([Board,Trees1,Trees2,54,Turn], (PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2) ) :-

    InitialState=[Board,Trees1,Trees2,54,Turn],  
    display_game(InitialState),

    valid_moves(InitialState,_,ValidMoves),
 

    (   PlayerDifficulty1 =:= -1 ->

        repeat_choose_tree(Tree,InitialState,1), 
        repeat_choose_valid_move(OldCoordinates, ValidMoves),
        move(InitialState, ((Tree,-1), OldCoordinates), TurnState)

        ;
        choose_move(InitialState, 1, 1, (ValidMoves,Tree,OldCoordinates)),
        move(InitialState, ((Tree,-1), OldCoordinates), TurnState)
    ),

    change_turn(TurnState,MiddleState),
    display_game(MiddleState),
    sleep(5),
    nth0(0,MiddleState,Board1),
    get_free_trees_in_board(0,0,Board1,Board1,TreesInBoard), 


    (
        PlayerDifficulty2 =:= -1 -> 

        repeat_choose_tree_in_board(MiddleState,(NewTree,Coordinates),TreesInBoard),
        valid_moves(MiddleState,Coordinates,ValidMoves1),
        repeat_choose_valid_move(NewCoordinates,ValidMoves1),
        move(MiddleState,((NewTree,Coordinates),NewCoordinates),MiddleState1),
        display_game(MiddleState1),
        sleep(5),
        repeat_choose_tree(NewTree1,MiddleState1,2), 
        move(MiddleState1,((NewTree1,-1),Coordinates),TurnState1),
        display_game(TurnState1),
        sleep(5)

        
        ;
        % os bots são iguais no inicio do jogo
        choose_move(MiddleState,2,1,(TreesInBoard,NewTree,Coordinates,NewCoordinates,NewTree1)),
        move(MiddleState,((NewTree,Coordinates),NewCoordinates),MiddleState1),
        display_game(MiddleState1),
        sleep(5),
        move(MiddleState1,((NewTree1,-1),Coordinates),TurnState1),
        display_game(TurnState1),
        sleep(5)

    ),
    
    change_turn(TurnState1,FinalState),
    play_game(FinalState,(PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2))
.

play_game([Board,Trees1,Trees2,0,_], (PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2)):-

    GameOverState=[Board,Trees1,Trees2,0,_],
    display_game(GameOverState),
    sleep(2),
    game_over(GameOverState,Winner,PointsHeight,PointsColor),
    (Goal1 =:= Winner ->
        display_Winner(Winner,PlayerNumber1,PointsHeight,PointsColor) 
    ;
        display_Winner(Winner,PlayerNumber2,PointsHeight,PointsColor)
    ),
    sleep(20)
.

play_game(GameState, (PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2)):-

    GameState=[Board,Trees1,Trees2,Amount,Turn],
    display_game(GameState),
    sleep(5),
    get_free_trees_in_board(0,0,Board,Board,TreesInBoard),

    (Turn =:= 1 ->
     (
     PlayerDifficulty1 =:= -1 ->
        repeat_choose_tree_in_board(GameState,(Tree,OldCoordinates),TreesInBoard),
        valid_moves(GameState,OldCoordinates,ValidMoves), 
        repeat_choose_valid_move(NewCoordinates,ValidMoves),
        move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
        display_game(MiddleState), 
        sleep(5),
        repeat_choose_tree(NewTree,MiddleState,1), 
        move(MiddleState,((NewTree,-1),OldCoordinates),TurnState),
        display_game(TurnState),
        sleep(5)
     ;
    PlayerDifficulty1 =:= 1->
        choose_move(GameState,1,1,(TreesInBoard,Tree,OldCoordinates,NewCoordinates,NewTree)),
        move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
        display_game(MiddleState),
        sleep(5),
        move(MiddleState,((NewTree,-1),OldCoordinates),TurnState),
        display_game(TurnState),
        sleep(5)
     ;
        choose_move(GameState,1,2,(Goal1,TreesInBoard,((Tree,OldCoordinates),NewCoordinates,NewTree))),
        move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
        display_game(MiddleState),
        sleep(5),
        move(MiddleState,((NewTree,-1),OldCoordinates),TurnState),
        display_game(TurnState),
        sleep(5)
     )
     ;
     (
    PlayerDifficulty2 =:= -1 -> 
        repeat_choose_tree_in_board(GameState,(Tree,OldCoordinates),TreesInBoard),
        valid_moves(GameState,OldCoordinates,ValidMoves), 
        repeat_choose_valid_move(NewCoordinates,ValidMoves),
        move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
        display_game(MiddleState),
        sleep(5),
        repeat_choose_tree(NewTree,MiddleState,2), 
        move(MiddleState,((NewTree,-1),OldCoordinates),TurnState),
        display_game(TurnState),
        sleep(5)
     ; 
     PlayerDifficulty2 =:= 1->

        choose_move(GameState,2,1,(TreesInBoard,Tree,OldCoordinates,NewCoordinates,NewTree)),
        move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
        display_game(MiddleState),
        sleep(5),
        move(MiddleState,((NewTree,-1),OldCoordinates),TurnState),
        display_game(TurnState),
        sleep(5)
        
     ;
        choose_move(GameState,2,2,(Goal2,TreesInBoard,((Tree,OldCoordinates),NewCoordinates,NewTree))),
        move(GameState,((Tree,OldCoordinates),NewCoordinates),MiddleState),
        display_game(MiddleState),
        sleep(5),
        move(MiddleState,((NewTree,-1),OldCoordinates),TurnState),
        display_game(TurnState),
        sleep(5)
        
    )
    ),
    change_turn(TurnState,FinalState),
    play_game(FinalState,(PlayerNumber1, PlayerDifficulty1, Goal1), (PlayerNumber2, PlayerDifficulty2, Goal2))
.

