choose_move([Board, Trees1, Trees2, 54, _], 1, 1, (ValidMoves, Tree, Coordinates)) :-
    collect_available_trees(Trees1, AvailableTrees),
    random_member(Tree, AvailableTrees),
    random_member(Coordinates, ValidMoves)
.

choose_move([Board, _, _, 54, _], 1, 1, (ValidMoves,Coordinates)) :-
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

choose_move([Board, Trees1, Trees2,_,_],1,1,NewTree):-
    collect_available_trees(Trees1,AvailableTrees),
    random_member(NewTree,AvailableTrees)
.

choose_move([Board, Trees1, Trees2,_,_],2,1,NewTree):-
    collect_available_trees(Trees2,AvailableTrees),
    random_member(NewTree,AvailableTrees)
.

bot_Move_first_tree_move([Board | RestGameState],((Tree,OldCords),New_Cords)):-
    get_free_trees_in_board(0,0,Board,Board,TreesInBoard),
    nth0(0,TreesInBoard,OldCords),
    getPiece(Board,OldCords,Tree),
    valid_moves([Board | RestGameState],OldCords,ValidMoves),
    random_member(New_Cords, ValidMoves).

%calcula o numero maximo de pecas com a mesma cor proximas umas das outras
bot_move_easy([Board | RestGameState],Trees,((Tree,OldCords),NewCords,NewTree)):-
    get_size(Board,Size),
    get_free_trees_in_board(0,0,Board,Board,TreesInBoard),write(TreesInBoard),
    random_member(OldCords, TreesInBoard),
    getPiece(Board,OldCords,Tree),
    valid_moves([Board | RestGameState],OldCords,ValidMoves),
    random_member(ValidMoves, NewCords),
    random_member((NewTree,Amount),Trees),
    0 < Amount
    .


get_Maxs(OrdereMoves,MaxScore,MaxMoves):-
    findall(Mov, (member(Score-Mov,OrdereMoves),Score == MaxScore),MaxMoves).
%calcula o numero maximo de pecas com a mesma cor proximas umas das outras
bot_move([Board | RestGameState],'Height',Trees,BotMov):-
    get_size(Board,Size),write('start_color_bfs\n'),
    get_free_trees_in_board(0,0,Board,Board,TreesInBoard),write(TreesInBoard),write('start_color_bfs\n'),
    findall(Score-((Tree,OldCords),NewCords,NewTree), (
    %selecionar uma arvore que se pode mexer e vê se os movimentos validos e 
        member(OldCords,TreesInBoard),getPiece(Board,OldCords,Tree),write(OldCords),valid_moves([Board | RestGameState],OldCords,ValidMoves),
        write(ValidMoves),member(NewCords,ValidMoves),write('try to move\n'),move([Board | RestGameState],( (Tree ,OldCords),NewCords),[BoardUpdated | _])
        ,write('found start pieces\n'),member((NewTree- Amount),Trees),0 < Amount,move([BoardUpdated | RestGameState],( (NewTree , -1),OldCords),[BoardUpdated1 | _]),
    count_height_values(BoardUpdated1,Size,Score)),MaxMoves),
    sort(MaxMoves,SortedMoves),last(SortedMoves,MaxScore-_),% write(MaxScore)%por random aqui
    reverse(SortedMoves,OrdereMoves),
    get_Maxs(OrdereMoves,MaxScore,MaxMoves),
    random_member(Mov, MaxMoves)
    .

%calcula o numero maximo de pecas com a mesma cor proximas umas das outras
bot_move([Board | RestGameState],'Color',Trees,BotMov):-
    get_size(Board,Size),
    get_free_trees_in_board(0,0,Board,Board,TreesInBoard),write(TreesInBoard),
    findall(Score-((Tree,OldCords),NewCords,NewTree), (
    %selecionar uma arvore que se pode mexer e vê se os movimentos validos e 
        member(OldCords,TreesInBoard),getPiece(Board,OldCords,Tree),write(OldCords),valid_moves([Board | RestGameState],OldCords,ValidMoves),
        write(ValidMoves),member(NewCords,ValidMoves),write('try to move\n'),move([Board | RestGameState],( (Tree ,OldCords),NewCords),[BoardUpdated | _])
        ,write('found start pieces\n'),member((NewTree- Amount),Trees),0 < Amount,move([BoardUpdated | RestGameState],( (NewTree , -1),OldCords),[BoardUpdated1 | _]),
    count_color_values(BoardUpdated1,Size,Score)),MaxMoves),
    sort(MaxMoves,SortedMoves),last(SortedMoves,MaxScore-_),% write(MaxScore)%por random aqui
    reverse(SortedMoves,OrdereMoves),
    get_Maxs(OrdereMoves,MaxScore,MaxMoves),
    random_member(Mov, MaxMoves)
    .

