color('dg').
color('mg').
color('lg').

height('l').
height('m').
height('h').

piece(C,H):- color(X),height(Y).

player(1).
player(2).
initial(1,[[-1],[-1,-1],[-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1],
	[-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1],[-1,-1],[-1]]
).
move(GameState,Move,NewGameState):- 
