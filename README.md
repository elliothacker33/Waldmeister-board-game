# Turma 5- Wald Meister_5

## Index 
- [Group](#group) 
- [Installation and Execution](#installation-and-execution) 
	- [Linux](#linux)
	-  [Windows](#windows)
-  [Wald Meister - Introduction and Rules](#wald-meister---introduction-and-rules)
	 - [Game Components](#game-components)
	 - [How to Play](#how-to-play) 
	 - [Objective](#objective) 
	 - [Ending and Scoring](#ending-and-scoring)
   - [Helpful links](#helpful-links)
- [Logic of the game](#logic-of-the-game)Representation Of The GameState
	- [GameState](#representation-of-the-gamestate)
	- [Value of the board](#value-of-the-board)
	- [Bot Move Choice](#bot-move-choice)
## Group
   - Tomás Alexandre Torres Pereira (up202108845@edu.fe.up.pt)
   - Tomás Miranda de Figueiredo Sarmento (up202108778@edu.fe.up.pt)

## Installation and Execution

### Linux
1. Clone the repository to your local machine using SSH:
```shell
git clone git@github.com:elliothacker33/Waldmeister-board-game.git
```

or using HTTPS:
```shell
git clone https://github.com/elliothacker33/Waldmeister-board-game.git
```

2. Navigate to the downloaded directory and open sicstus:
```shell
cd Waldmeister-board-game
sicstus
```

3. Load the game in sicstus:
```prolog
consult('waldmeister.pl').
```

4. Start the game:
```prolog
play.
```

### Windows
1. Clone the repository to your local machine using SSH:
```shell
git clone git@github.com:elliothacker33/Waldmeister-board-game.git
```

or using HTTPS:
```shell
git clone https://github.com/elliothacker33/Waldmeister-board-game.git
```

2. Navigate to the downloaded directory and open sicstus:
```shell
cd Waldmeister-board-game
sicstus.exe
```

3. Load the game in sicstus:
```prolog
consult('waldmeister.pl').
```

4. Start the game:
```prolog
play.
```


## Wald Meister - Introduction and Rules

**Wald Meister** is a board game with a tree nursery theme. In this game, players repeatedly replant trees before transferring them to a larger forest, where strong roots are crucial for their survival.

### Game Components

Wald Meister consists of a total of 54 trees. Each player uses 27 trees. The trees come in three different heights and three different colors. Each player receives three pieces per color and per height.

![Tree Types](media-assets/trees.png)

### How to Play

1.  **Starting the Game**: Choose the starting player arbitrarily. The first player places their tree piece on the board.
    
2.  **Relocating Trees**: The second player can then relocate this piece by moving it in a straight line. After that, the second player places their own piece in the vacant spot from which they removed the last piece. This process can be repeated until the end of the game is reached.
    
3.  **Fixed Pieces**: A piece becomes "fixed" when it is surrounded on all sides, making it impossible to move. Fixed pieces are valuable for building strong clusters that cannot be disrupted by the opponent.
    
4.  **Clusters**: A cluster is a group of pieces of the same height or color that are adjacent or connected without being separated by pieces of different color, height, or empty spaces.
    

### Objective

The game's objective varies for each player:

-   One player aims to form clusters of trees of the same color (three colors available).
-   The other player aims to form clusters of trees of the same height (three heights available).

### Ending and Scoring

The game ends when all the pieces have been placed on the board. Players must then calculate their points. One player should count the points for the largest cluster in each color, while the other player counts the points for the largest cluster in each height. To determine the winner, add up the points for the three largest clusters for each player, with each piece in a cluster counting as one point.

![points](media-assets/points.png)
### Helpful links
- [Rulebook](https://boardgamegeek.com/filepage/249274/rules-waldmeister): Download the comprehensive rulebook for Wald Meister.
- [Official Website](https://www.spielewerkstatt.eu/gb/strategy-tactics/204-forestmeister.html): Browse the official website of the game and buy the game.


### Logic of the Game

#### Representation Of The GameState

The Gamestate is and argument essential for almost all functions in this game and it consists of 5 variables:
- **Board** 
The board of the game in wich it represents the pieces in place in pairs with the acording height and color and there is -1 in the position where there isnt any piece.

- **Trees1** 
	The Trees1 is a list of the trees that player 1 has at it's disposal to play as well has it's number.
- **Trees2**
	The Trees2 is a list of the trees that player 2 has at it's disposal to play as well has it's number.

- **Amount**
	The variable Amount it is the amount of pieces available to be played in the game. It will go from 54 to 0.

- **Turn**

#### Value of the Board
Our game has special way to count to count the poinst depending if u win writh colors or heights u count de number of pieces with the biggest peices from every color/height type and sum it we use 3 main functions to resolve this problem we will show an example of the values function of color its the same but with height in the heights functions

- we used a bfs color_bfs(+Board,+Size,+Queue,+Visited,-NewVisited,+Color,+CurrMax,-CurrMax) that gets all the pieces with the same height/color near the first position that is given in the Queue when its called this returns the number of pieces with the same height/color containing the first piece that are a near each other
```prolog
color_bfs_aux(_,_,[],Visited,Visited,_,Max,Max).

color_bfs_aux(Board,Size,[Line-Col |  Rest],Visited,NewVisited,Color,Current_Max,Max):-
    findall(Cords, (getPositionNear(Size,Line,Col,Cords), Cords\= null,\+ member(Cords,Visited),\+ member(Cords,Rest), getPiece(Board,Cords,_Height-Color)),
    New_Cords),
    append(Rest,New_Cords,New_queue),
    NewMax is Current_Max + 1,
    color_bfs_aux(Board,Size,New_queue,[Line-Col | Visited],NewVisited,Color,NewMax,Max).

```

- using the previous function what we can do is using funtion **next_position_color** that gets the next cordinates of the piece of the board with the color/height expecified and not are not list visited geting the start of the next group of pieces, comparing each time the process is done with the current max and the max calculated we get the bigger and with that we return the bigger value calculanting for a certant board and color/height the group with the biggest number of pieces together

```prolog
color_bfs(Board,_,Visited,Color,CurrMax,CurrMax):-
    next_position_color(Board,Visited,Color,Cord),
    Cord == null.

color_bfs(Board,Size,Visited,Color,CurrMax,Max):-
    next_position_color(Board,Visited,Color,Cord),
    Cord \= null,
    color_bfs_aux(Board,Size,[Cord],Visited,NewVisited,Color,0,TmpMax),
    (TmpMax < CurrMax ->
        color_bfs(Board,Size,NewVisited,Color,CurrMax,Max);
        color_bfs(Board,Size,NewVisited,Color,TmpMax,Max)
    ).
```
- In this step we use this function to check all 3 colors ((dark green : 1 , medium green : 2 , light green : 1)) and sum to get the values
```prolog
	count_color_values(Board,Max):-
    get_size(Board,Size),
    color_bfs(Board,Size,[],1,0,Max1),
    color_bfs(Board,Size,[],2,0,Max2),
    color_bfs(Board,Size,[],3,0,Max3),
    Max is Max1 + Max2 + Max3.
```


#### Bot Move Choice
- **Bot Generic behaviour**
the function choose_move(+Gamestate, +Player, +Dificulty, -Mov) is standard among all bots but they have slight differences our game is a bit special one move is actual two, and our initial move is diferent and doesnt have a gready approch possible because that approch is only feasible when there are pieces in the board one move consist in trading a piece with one of the player and using the piece that was removed from the board to move in one of the available paths but in the start we dont have any piece to replace so the first move is choosing a random position and placing a piece there and then the second player chooses a random valid position and move the piece there.
```prolog
choose_move([_Board, _Trees1, _, _ , _], 1, 1, (ValidMoves,_Tree,Coordinates)):-
    random_member(Coordinates, ValidMoves)
.
choose_move([_Board, _,_Trees2, _ , _], 2, 1, (ValidMoves,_Tree,Coordinates)):-
    random_member(Coordinates, ValidMoves)
.
```

- **BotEasy**
	- We had to be creative to adder in the context of our game and keep it efficient in the mov our this  (TreesInBoard,Tree,Coordinates,NewCoordinates,NewTree) the **TreesInBoard** is input from the function as well and it is the Trees in board that can be moved, the **Tree** is the piece from the board that is moved ,**Cordinates** are the cordinates of the piece moved, the **NewCoordinates** are the new coordinates of the piece moved and the **NewTree** is the piece that will be place in the **Coordinates** of the piece moved.
	<bl>
	<bl>
	- This function chooses a the cordinates of a random piece that can be moved from the **TreesInBoard** (Point1) that we use to get the piece (Point2), now we get the a random valid move from that position of the piece that we choose (Point3), finally we choose a random piece (From the player that is playing int this case Trees1) to put from the table of the in the position of the piece moved
```prolog
choose_move([Board,Trees1,_,_,_],1,1,(TreesInBoard,Tree,Coordinates,NewCoordinates,NewTree)):-
    GameState = [Board,_,_,_,_],
	% Point1
    random_member(Coordinates,TreesInBoard),
	% Point2
    Coordinates = X-Y,
    nth0(X,Board,Row),
    nth0(Y,Row,Tree),
	% Point3
    valid_moves(GameState,Coordinates,ValidMoves),
    random_member(NewCoordinates,ValidMoves),
	%Point4
    collect_available_trees(Trees1,AvailableTrees),
    random_member(NewTree,AvailableTrees)
.
```
- **BotHard**
	- To do a pretty good bot we choose to greadly choose options valid to play the pieces then we execute the move in a temporary board and calculate the points of board according to that move with that our bot is a little slow sometimes when there are a lot of good moves but at max it takes about 7 seconds sometimes.
	<bl>
	<bl>
	- In this bot we made a little gready options like only chosing trees to move in wich its neightboors are with the same color/height of the piece tha we will put, and move the oldpiece only to the positions when there are neightboors with the same height/color with this we greattly reduce the solutions numbers to make the code quicker but we might end the code without any solutions in that case in the end of the code if we dont have solutions it chooses a random move from the easy bot
```prolog
% Calculate the maximum number of pieces with the same color close to each other

bot_move([Board | RestGameState],'Color',Trees,TreesInBoard,BotMov):-
    get_size(Board,Size),
    
    findall(Score-((Tree,OldCords),NewCords,NewTree), 
        (
        % Select a tree that can be moved and check if it has at least one piece with the same height nearby in relation to the piece we place
        getOptimalStartTreeColor(Board,Size,Trees,TreesInBoard,OldCords,NewTree),getPiece(Board,OldCords,Tree),
        % Optimize: consider moves that are close to other trees
        valid_moves([Board | RestGameState],OldCords,ValidMoves) , member(NewCords,ValidMoves) , has_piece_near_with_same_color(Board,Size,NewCords,Tree),
         % Move the piece to another area of the board
        move([Board | RestGameState],( (Tree ,OldCords),NewCords),[BoardUpdated | _]),
        % Place the piece at the location where we removed another piece
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
```

