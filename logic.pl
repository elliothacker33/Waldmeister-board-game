color(1,'dg').
color(2,'mg').
color(3,'lg').

height(1,'l').
height(2,'m').
height(3,'h').

piece(C,H):- color(C,_),height(H,_).

number_of_pieces(54).
player_one(Name,X)
player_two(Name,

player(1).
player(2).
initial(1,[[-1],[-1,-1],[-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1],
	[-1,-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1,-1],[-1,-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1],[-1,-1],[-1]]
).
move(GameState,Move,NewGameState):- 
