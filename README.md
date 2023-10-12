# Turma 5- Wald Meister_5

## Group
   Tomás Alexandre Torres Pereira (up202108845@edu.fe.up.pt)
   Tomás Miranda de Figueiredo Sarmento (up202108778@edu.fe.up.pt)

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
```shell
consult('waldmeister.pl').
```

4. Start the game:
```shell
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
```shell
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

![Tree Types](uploads/trees.png)

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
