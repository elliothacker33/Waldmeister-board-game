bot_Add_first_tree_move([Board | RestGameState],Trees,(Tree,Cords)):-
    get_size(Board,Size),
    Tmp_size is Size - 1,
    MaxLine is Tmp_size * 2 + 1,
    random_member((Tree,Amount),Trees),
    findall(L-C, (between(0,MaxLine,L),((L=< Tmp_size,between(0,L,C)) ; (Tmp_size<L,Tmp_L is Tmp_size*2 - L,between(0,Tmp_L,C)))),PossibleCords),
    random_member(Cords, PossibleCords).

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