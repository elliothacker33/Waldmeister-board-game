
% Random AI

choose_move([_Board, Trees1, _, _ , _], 1, 1, (ValidMoves,Tree,Coordinates)):-
    random_member(Coordinates, ValidMoves)
.
choose_move([_Board, _, Trees2, _ , _], 2, 1, (ValidMoves,Tree,Coordinates)):-
    random_member(Coordinates, ValidMoves)
.

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
    random_member(NewTree,AvailableTrees),
.


% Greedy AI

choose_move([Board, Trees1, Trees2,Amount,Turn],1,2,(1,TreesInBoard,BotMov)):-
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Height',Trees1,TreesInBoard,BotMov).

choose_move([Board, Trees1, Trees2,Amount,Turn],1,2,(2,TreesInBoard,BotMov)):-
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Color',Trees1,TreesInBoard,BotMov).

choose_move([Board, Trees1, Trees2,Amount,Turn],2,2,(1,TreesInBoard,BotMov)):-
    bot_move([Board, Trees1, Trees2,Amount,Turn],'Height',Trees2,TreesInBoard,BotMov).

choose_move([Board, Trees1, Trees2,Amount,Turn],2,2,(2,TreesInBoard,BotMov)):-
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
   movimento do bot com dificuldade facil vai retornar um movimento melhor para a situação ((Tree,OldCords),NewCords,NewTree)) tree
    que se vai mecher das cordenadas velhas para as novas e a nova arvore que se vai colocar no tabuleiro nas cordenadas antigas 
    caso nao exista nenhum movimento melhor é utilizado um aleatorio
*/
% bot_move(+GameState,'Height' or 'Color', +TreesInBoard,-BotMov)
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
        count_height_values(BoardUpdated1,Score)),MaxMoves),
    
    length(MaxMoves,N),
    (0 < N ->
        sort(MaxMoves,SortedMoves),
        %get best score
        last(SortedMoves,MaxScore-_),
        %find all best scores
        findall(Mov,member(MaxScore-Mov,SortedMoves),MaxMoves1),
        %choose one at random
        random_member(BotMov, MaxMoves1)
        ;
        %if the gready algorithm didnt find any moves, use the easy algorithm
        choose_move([Board,Trees,_,_,_],1,1,(TreesInBoard,Tree,Coordinates,NewCoordinates;NewTree)),
        BotMov = ((Tree,Coordinates),NewCoordinates,NewTree)
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
        count_color_values(BoardUpdated1,Score)),MaxMoves),
    
    length(MaxMoves,N),
    (0 < N ->
        sort(MaxMoves,SortedMoves),
        %get best score
        last(SortedMoves,MaxScore-_),
        %find all best scores
        findall(Mov,member(MaxScore-Mov,SortedMoves),MaxMoves1),
        %choose one at random
        random_member(BotMov, MaxMoves1)
        ;
        choose_move([Board,Trees,_,_,_],1,1,(TreesInBoard,Tree,Coordinates,NewCoordinates;NewTree)),
        BotMov = ((Tree,Coordinates),NewCoordinates,NewTree)
    ).
