choose_move([_Board, Trees1, _Trees2, 54, _], 1, 1, (ValidMoves, Tree, Coordinates)) :-
    collect_available_trees(Trees1, AvailableTrees),
    random_member(Tree, AvailableTrees),
    random_member(Coordinates, ValidMoves)
.

choose_move([_Board, _, _, 54, _], 1, 1, (ValidMoves,Coordinates)) :-
    random_member(Coordinates, ValidMoves)
.
choose_move([Board,_,_,_,_],_,1,(TreesInBoard,Tree,OldCoordinates,NewCoordinates)):-
    random_member(OldCoordinates,TreesInBoard),
    OldCoordinates = X-Y,
    nth0(Board,X,Row),
    nth0(Row,Y,Tree),
    valid_moves([Board,_,_,_,_],X-Y,ValidMoves),
    random_member(NewCoordinates,ValidMoves)
.

choose_move([_Board, Trees1, _Trees2,_,_],1,1,NewTree):-
    collect_available_trees(Trees1,AvailableTrees),
    random_member(NewTree,AvailableTrees)
.

choose_move([_Board, _Trees1, Trees2,_,_],2,1,NewTree):-
    collect_available_trees(Trees2,AvailableTrees),
    random_member(NewTree,AvailableTrees)
.
choose_move([Board, Trees1, Trees2,Amount,Turn],1,2,(1,TreesInBoard,BotMov)):-
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Height',Trees1,TreesInBoard,BotMov).

choose_move([Board, Trees1, Trees2,Amount,Turn],1,2,(2,TreesInBoard,BotMov)):-
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Color',Trees1,TreesInBoard,BotMov).

choose_move([Board, Trees1, Trees2,Amount,Turn],2,2,(1,TreesInBoard,BotMov)):-
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Height',Trees2,TreesInBoard,BotMov).

choose_move([Board, Trees1, Trees2,Amount,Turn],2,2,(2,TreesInBoard,BotMov)):-
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Color',Trees2,TreesInBoard,BotMov).

bot_Move_first_tree_move([Board | RestGameState],((Tree,OldCords),New_Cords)):-
    get_free_trees_in_board(0,0,Board,Board,TreesInBoard),
    nth0(0,TreesInBoard,OldCords),
    getPiece(Board,OldCords,Tree),
    valid_moves([Board | RestGameState],OldCords,ValidMoves),
    random_member(New_Cords, ValidMoves).

%calcula o numero maximo de pecas com a mesma cor proximas umas das outras
bot_move_easy([Board | RestGameState],Trees,((Tree,OldCords),NewCords,NewTree)):-
    get_free_trees_in_board(0,0,Board,Board,TreesInBoard),
    random_member(OldCords, TreesInBoard),
    getPiece(Board,OldCords,Tree),
    valid_moves([Board | RestGameState],OldCords,ValidMoves),
    random_member(NewCords,ValidMoves),
    random_member((NewTree,Amount),Trees),
    0 < Amount
    .

has_piece_near_with_same_height(Board,Size,Line-Col,Height-_):-
    getPositionNear(Size,Line,Col,Cords),
    getPiece(Board,Cords,Height-_).

getOptimalStartTree(Board,Size,Trees,TreesInBoard,OldCords,NewTree):-
    member((NewTree,Amount),Trees),
    0 < Amount,member(OldCords,TreesInBoard),
    %write(OldCords),write('\n'),
    has_piece_near_with_same_height(Board,Size,OldCords,NewTree).



    has_piece_near_with_same_color(Board,Size,Line-Col,_-Color):-
        getPositionNear(Size,Line,Col,Cords),
        getPiece(Board,Cords,_-Color).
    
    getOptimalStartTreeColor(Board,Size,Trees,TreesInBoard,OldCords,NewTree):-
        member((NewTree,Amount),Trees),
        0 < Amount,member(OldCords,TreesInBoard),
        %write(OldCords),write('\n'),
        has_piece_near_with_same_color(Board,Size,OldCords,NewTree).

%calcula o numero maximo de pecas com a mesma cor proximas umas das outras
bot_move([Board | RestGameState],'Height',Trees,TreesInBoard,BotMov):-
    get_size(Board,Size),
    
    findall(Score-((Tree,OldCords),NewCords,NewTree), 
        (
    %selecionar uma arvore que se pode mexer e vêr se em relação a pessa que pomos tem pelo menos uma pessa com a mesma altura perto
        getOptimalStartTree(Board,Size,Trees,TreesInBoard,OldCords,NewTree),getPiece(Board,OldCords,Tree),
        %optimizações vamos concederar movimentos que estão pertos de outras arvores
        valid_moves([Board | RestGameState],OldCords,ValidMoves) , member(NewCords,ValidMoves) , has_piece_near_with_same_height(Board,Size,NewCords,Tree),
        %mover a peça para outra zona do tabuleiro
        move([Board | RestGameState],( (Tree ,OldCords),NewCords),[BoardUpdated | _]),
        %colocar a peça na localização em que tiramos a outra peça
        move([BoardUpdated | RestGameState],( (NewTree , -1),OldCords),[BoardUpdated1 | _]),
        count_height_values(BoardUpdated1,Score)),MaxMoves),%write('end\n'),
    
    length(MaxMoves,N),
    (0 < N ->
        sort(MaxMoves,SortedMoves),
        %get best score
        last(SortedMoves,MaxScore-_),% write(MaxScore)%por random aqui
        %find all best scores
        findall(Mov,member(MaxScore-Mov,SortedMoves),MaxMoves1),
        %choose one at random
        %write('\nMaxScore:'),%length(MaxMoves1,S),write(S),write('\n'),
        random_member(BotMov, MaxMoves1)
        ;
        bot_move_easy([Board | RestGameState],Trees,BotMov)
    ).


%calcula o numero maximo de pecas com a mesma cor proximas umas das outras
bot_move([Board | RestGameState],'Color',Trees,TreesInBoard,BotMov):-
    get_size(Board,Size),
    
    findall(Score-((Tree,OldCords),NewCords,NewTree), 
        (
    %selecionar uma arvore que se pode mexer e vêr se em relação a pessa que pomos tem pelo menos uma pessa com a mesma altura perto
        getOptimalStartTreeColor(Board,Size,Trees,TreesInBoard,OldCords,NewTree),getPiece(Board,OldCords,Tree),
        %optimizações vamos concederar movimentos que estão pertos de outras arvores
        valid_moves([Board | RestGameState],OldCords,ValidMoves) , member(NewCords,ValidMoves) , has_piece_near_with_same_color(Board,Size,NewCords,Tree),
        %mover a peça para outra zona do tabuleiro
        move([Board | RestGameState],( (Tree ,OldCords),NewCords),[BoardUpdated | _]),
        %colocar a peça na localização em que tiramos a outra peça
        move([BoardUpdated | RestGameState],( (NewTree , -1),OldCords),[BoardUpdated1 | _]),
        count_color_values(BoardUpdated1,Score)),MaxMoves),%write('end\n'),
    
    length(MaxMoves,N),
    (0 < N ->
        sort(MaxMoves,SortedMoves),
        %get best score
        last(SortedMoves,MaxScore-_),% write(MaxScore)%por random aqui
        %find all best scores
        findall(Mov,member(MaxScore-Mov,SortedMoves),MaxMoves1),
        %choose one at random
        %write('\nMaxScore:'),%length(MaxMoves1,S),write(S),write('\n'),
        random_member(BotMov, MaxMoves1)
        ;
        bot_move_easy([Board | RestGameState],Trees,BotMov)
    ).
