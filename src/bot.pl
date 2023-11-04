
% Random AI

/*
 choose_move([_Board, _Trees1, _, _ , _], _, 1, (ValidMoves,_Tree,Coordinates))
 This predicat is responsible to choose a random coordinates for a tree.
*/
% choose_move(+GameState, +PlayerNumber, +Difficulty, (+ValidMoves,-Tree,-Coordinates))

choose_move([_Board, _Trees1, _, _ , _], 1, 1, (ValidMoves,_Tree,Coordinates)):-
    random_member(Coordinates, ValidMoves)
.

choose_move([_Board, _,_Trees2, _ , _], 2, 1, (ValidMoves,_Tree,Coordinates)):-
    random_member(Coordinates, ValidMoves)
.

/*
choose_move([Board,_,_,_,_],_,1,(TreesInBoard,Tree,Coordinates,NewCoordinates,NewTree))
This is the predicat that executes the random difficulty level for the AI.
*/
% choose_move(+GameState,+PlayerNumber,+Difficulty,(+TreesInBoard,-Tree,-Coordinates,-NewCoordinates,-NewTree))

choose_move([Board,Trees1,_,_,_],1,1,(TreesInBoard,Tree,Coordinates,NewCoordinates,NewTree)):-
    GameState = [Board,_,_,_,_],
    random_member(Coordinates,TreesInBoard),
    Coordinates = X-Y,
    nth0(X,Board,Row),
    nth0(Y,Row,Tree),
    valid_moves(GameState,Coordinates,ValidMoves),
    random_member(NewCoordinates,ValidMoves),
    collect_available_trees(Trees1,AvailableTrees),
    random_member(NewTree,AvailableTrees)
.

choose_move([Board,_,Trees2,_,_],2,1,(TreesInBoard,Tree,Coordinates,NewCoordinates,NewTree)):-
    GameState = [Board,_,_,_,_],
    random_member(Coordinates,TreesInBoard),
    Coordinates = X-Y,
    nth0(X,Board,Row),
    nth0(Y,Row,Tree),
    valid_moves(GameState,Coordinates,ValidMoves),
    random_member(NewCoordinates,ValidMoves),
    collect_available_trees(Trees2,AvailableTrees),
    random_member(NewTree,AvailableTrees)
.


% Greedy AI

choose_move([Board, Trees1, Trees2,Amount,Turn],1,2,(1,TreesInBoard,BotMov)):-write('Height1'),nl,
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Height',Trees1,TreesInBoard,BotMov).

choose_move([Board, Trees1, Trees2,Amount,Turn],1,2,(2,TreesInBoard,BotMov)):-write('Color'),nl,
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Color',Trees1,TreesInBoard,BotMov).

choose_move([Board, Trees1, Trees2,Amount,Turn],2,2,(1,TreesInBoard,BotMov)):-write('Height2'),nl,
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Height',Trees2,TreesInBoard,BotMov).

choose_move([Board, Trees1, Trees2,Amount,Turn],2,2,(2,TreesInBoard,BotMov)):-write('Color'),nl,
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Color',Trees2,TreesInBoard,BotMov).


has_piece_near_with_same_height(Board,Size,Line-Col,Height-_):-
    getPositionNear(Size,Line,Col,Cords),
    getPiece(Board,Cords,Height-_).

getOptimalStartTree(Board,Size,Trees,TreesInBoard,OldCords,NewTree):-
    member((NewTree,Amount),Trees),
    0 < Amount,member(OldCords,TreesInBoard),
    has_piece_near_with_same_height(Board,Size,OldCords,NewTree).



    has_piece_near_with_same_color(Board,Size,Line-Col,_-Color):-
        getPositionNear(Size,Line,Col,Cords),
        getPiece(Board,Cords,_-Color).
    
    getOptimalStartTreeColor(Board,Size,Trees,TreesInBoard,OldCords,NewTree):-
        member((NewTree,Amount),Trees),
        0 < Amount,member(OldCords,TreesInBoard),
        has_piece_near_with_same_color(Board,Size,OldCords,NewTree).

/*
   The bot's movement with easy difficulty will return a better move for the situation ((Tree, OldCoords), NewCoords, NewTree)) tree
   which will move from the old coordinates to the new ones, and the new tree that will be placed on the board at the old coordinates.
   If there is no better move available, a random one will be used.
*/
% bot_move(+GameState,'Height' or 'Color', +TreesInBoard,-BotMov)
bot_move([Board | RestGameState],'Height',Trees,TreesInBoard,BotMov):-
    get_size(Board,Size),
    
    findall(Score-((Tree,OldCords),NewCords,NewTree), 
        (
        getOptimalStartTree(Board,Size,Trees,TreesInBoard,OldCords,NewTree),getPiece(Board,OldCords,Tree),
        valid_moves([Board | RestGameState],OldCords,ValidMoves) , member(NewCords,ValidMoves) , has_piece_near_with_same_height(Board,Size,NewCords,Tree),
        move([Board | RestGameState],( (Tree ,OldCords),NewCords),[BoardUpdated | _]),
        move([BoardUpdated | RestGameState],( (NewTree , -1),OldCords),[BoardUpdated1 | _]),
        count_height_values(BoardUpdated1,Score)),MaxMoves),
    write('exited'),
    length(MaxMoves,N),
    (0 < N ->
        sort(MaxMoves,SortedMoves),
        last(SortedMoves,MaxScore-_),
        findall(Mov,member(MaxScore-Mov,SortedMoves),MaxMoves1),
        random_member(BotMov, MaxMoves1)
        ;
        choose_move([Board,Trees,_,_,_],1,1,(TreesInBoard,Tree,Coordinates,NewCoordinates,NewTree)),
        BotMov = ((Tree,Coordinates),NewCoordinates,NewTree)
    ).


bot_move([Board | RestGameState],'Color',Trees,TreesInBoard,BotMov):-
    get_size(Board,Size),
    
    findall(Score-((Tree,OldCords),NewCords,NewTree), 
        (
        getOptimalStartTreeColor(Board,Size,Trees,TreesInBoard,OldCords,NewTree),getPiece(Board,OldCords,Tree),
        valid_moves([Board | RestGameState],OldCords,ValidMoves) , member(NewCords,ValidMoves) , has_piece_near_with_same_color(Board,Size,NewCords,Tree),
        move([Board | RestGameState],( (Tree ,OldCords),NewCords),[BoardUpdated | _]),
        move([BoardUpdated | RestGameState],( (NewTree , -1),OldCords),[BoardUpdated1 | _]),
        count_color_values(BoardUpdated1,Score)),MaxMoves),
    
    length(MaxMoves,N),
    (0 < N ->
        sort(MaxMoves,SortedMoves),
        last(SortedMoves,MaxScore-_),
        findall(Mov,member(MaxScore-Mov,SortedMoves),MaxMoves1),
        random_member(BotMov, MaxMoves1)
        ;
        choose_move([Board,Trees,_,_,_],1,1,(TreesInBoard,Tree,Coordinates,NewCoordinates,NewTree)),
        BotMov = ((Tree,Coordinates),NewCoordinates,NewTree)
    ).
