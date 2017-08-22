:-[textos].

use_module(library(random)).

:-initialization main.

/*Retorna uma matriz de elementos (X, Y, Z), X eh a coordenada do eixo X, Y eh a coordenada do eixo Y e Z e o valor na posicao XY.*/
criaMatriz(X, Matriz):- Matriz = 
[(1, 1, X), (1, 2, X), (1, 3, X), (1, 4, X), (1, 5, X), (1, 6, X), (1, 7, X), (1, 8, X), (1, 9, X), 
 (2, 1, X), (2, 2, X), (2, 3, X), (2, 4, X), (2, 5, X), (2, 6, X), (2, 7, X), (2, 8, X), (2, 9, X), 
 (3, 1, X), (3, 2, X), (3, 3, X), (3, 4, X), (3, 5, X), (3, 6, X), (3, 7, X), (3, 8, X), (3, 9, X), 
 (4, 1, X), (4, 2, X), (4, 3, X), (4, 4, X), (4, 5, X), (4, 6, X), (4, 7, X), (4, 8, X), (4, 9, X), 
 (5, 1, X), (5, 2, X), (5, 3, X), (5, 4, X), (5, 5, X), (5, 6, X), (5, 7, X), (5, 8, X), (5, 9, X), 
 (6, 1, X), (6, 2, X), (6, 3, X), (6, 4, X), (6, 5, X), (6, 6, X), (6, 7, X), (6, 8, X), (6, 9, X), 
 (7, 1, X), (7, 2, X), (7, 3, X), (7, 4, X), (7, 5, X), (7, 6, X), (7, 7, X), (7, 8, X), (7, 9, X), 
 (8, 1, X), (8, 2, X), (8, 3, X), (8, 4, X), (8, 5, X), (8, 6, X), (8, 7, X), (8, 8, X), (8, 9, X), 
 (9, 1, X), (9, 2, X), (9, 3, X), (9, 4, X), (9, 5, X), (9, 6, X), (9, 7, X), (9, 8, X), (9, 9, X)]. 

/*Funcao para numeros aleatorios entre 1 e 10.*/
numeroAleatorio(X):- random(1, 10, X).	

/*Predicado usado para modificar o elemento*/
editaListaCoord([_|Tail], 0, Elem, [Elem|Tail]).
editaListaCoord([Head|Tail], Pos, Elem, NLista):- NLista is [Head|Ts], Z is Pos - 1, editaListaCoord(Tail, Z, Elem, Ts).

/*Funcao que insere as bombas na matriz.*/
insereBombaNaMatriz([], Matriz, Matriz).
insereBombaNaMatriz([(X,Y)|TBombas], Matriz, NovaMatriz):- editaLista(X, Y, -1, Matriz, MatrizTemp),
	getAdjacentes(X, Y, Adj),
	addDicas(Adj, MatrizTemp, MatrizComDicas), 
	insereBombaNaMatriz(TBombas, MatrizComDicas, NovaMatriz).
 
/*Funcoes de impressao de Matriz para o usuario.*/
imprime([]):-
	write("    -------------------------------------"),nl. 
imprime([(_,_,X1),(_,_,X2), (_,_,X3), (_,_,X4), (_,_,X5), (_,_,X6), (_,_,X7), (_,_,X8), (_,_,X9)|Corpo]):- 
	write("    -------------------------------------"),nl, 
	write("    | "), write(X1), 
	write(" | "), write(X2), 
	write(" | "), write(X3), 
	write(" | "), write(X4), 
	write(" | "), write(X5), 
	write(" | "), write(X6), 
	write(" | "), write(X7), 
	write(" | "), write(X8), 
	write(" | "), write(X9),
	write(" |"), nl,imprime(Corpo).

modificaMatriz([],[]).
modificaMatriz([(_, _, Z)|Corpo], [(_, _, Z2)|Corpo2]):- Z =:= 0, Z2 = "_", modificaMatriz(Corpo,Corpo2).
modificaMatriz([(_, _, Z)|Corpo], [(_, _, Z2)|Corpo2]):- Z =:= (-1), Z2 = "*", modificaMatriz(Corpo,Corpo2).
modificaMatriz([(_, _, Z)|Corpo], [(_, _, Z2)|Corpo2]):- Z2 = Z, modificaMatriz(Corpo, Corpo2).

/*Predicado que mostra a casa para o usuario de acordo com a sua jogada*/
abreCasa(X,Y, Matriz, Display, MatrizAberta):- getElem(X, Y, Matriz, Ele),
	(Ele =:= 0 -> editaLista(X, Y, "_", Display, MatrizAberta);
	Ele =:= (-1) -> editaLista(X, Y, "*", Display, MatrizAberta);
	editaLista(X, Y, Ele, Display, MatrizAberta)).

/*Predicados que pedem ao usuario as coordenadas x e y*/
read_X(CoordX) :-
	writeln("Digite uma coordenada X entre 1 e 9: "),
	read_line_to_codes(user_input, X2),
	(string_to_atom(X2,X1),
	atom_number(X1,X), X =< 9, X >= 1) -> ( CoordX is X); (write("Número invalido"),nl, read_X(CoordX)).

read_Y(CoordY) :-
	writeln("Digite uma coordenada Y entre 1 e 9: "),
	read_line_to_codes(user_input, Y2),
	(string_to_atom(Y2,Y1),
	atom_number(Y1,Y), Y =< 9, Y >= 1) -> ( CoordY is Y); (write("Número invalido"),nl, read_Y(CoordY)).

/*Edita a lista pegando as posições X e Y*/
editaLista(CoordX, CoordY, Elem, [(CoordX, CoordY, _)|T], [(CoordX, CoordY, Elem)|T]).	
editaLista(CoordX, CoordY, Elem, [H|T], NovaLista):- NovaLista = [H|Ts],
	editaLista(CoordX, CoordY, Elem, T, Ts).                        

/*Gerando coordenada aleatória*/
gerarCoordAleatoria(Coord):- numeroAleatorio(X), numeroAleatorio(Y), Coord = (X,Y).

/*Predicado que gera as bombas*/
gerandoBombas(NBombas, ListBombas):- length(TempList, NBombas),
	maplist( gerarCoordAleatoria, TempList), sort(TempList, ListBombas).

coordValida(X,Y):- X > 0, X < 10, Y > 0, Y < 10.

/*Filtra as coordenadas válidas*/
filtraCoords([], _).
filtraCoords([(X,Y)|Tcoords], Filtradas):- coordValida(X,Y) -> Filtradas = [(X,Y)|Ts], filtraCoords(Tcoords, Ts);
Filtradas = Ts, filtraCoords(Tcoords, Ts).

/*Predicado que icrementa os adjacentes*/
getAdjacentes(X, Y, Adjacentes):- TodasAdjacentes = [(A,Y), (B,Y), (X,C), (X,D), (A,C), (A,D), (B,C), (B,D)],
	A  is X + 1, B is X - 1, C is Y + 1, D is Y - 1,
	filtraCoords(TodasAdjacentes, Adjacentes).

/*Predicado que auxiliar-nos para encontrar as bombas*/
getElem(X, Y, [(X, Y, Elem)|_], Elem).
getElem(X,Y, [_|T], Elem):- getElem(X, Y, T, Elem).

/*Predicado que soma 1 no elemento de uma coordenada*/
addDicas([], Matriz, Matriz).
addDicas([(X,Y)|Tail], Matriz, NovaMatriz):- getElem(X, Y, Matriz, Ele), Z is Ele + 1,
	(Ele == -1 -> addDicas(Tail, Matriz, NovaMatriz);
	editaLista(X, Y, Z, Matriz, TempMatriz), addDicas(Tail, TempMatriz, NovaMatriz)).

/*Predicado que mostra ao usuario as suas jogadas*/
game(Matriz, Display):- read_X(X), read_Y(Y), getElem(X,Y, Matriz, Ele),
	(Ele =:= (-1) -> modificaMatriz(Matriz, Nova),
	imprime(Nova), nl, 
	textoPerdeu(), nl,
	halt(0);

	abreCasa(X,Y, Matriz, Display, NovoDisplay), 
	not(ganhouJogo(NovoDisplay, Matriz)),
	imprime(NovoDisplay), nl, 
	game(Matriz, NovoDisplay);
	
	ganhouJogo(NovoDisplay, Matriz),
	modificaMatriz(Matriz, Nova),
	imprime(Nova), nl, 
	textoGanhou(), halt(0)).

/*Funcao que verifica se nao ganhou o jogo.*/
ganhouJogo([], []).
ganhouJogo([(X, Y, " ")|Corpo],[(X, Y, -1)|C]):- ganhouJogo(Corpo, C).
ganhouJogo([(X, Y, Z)|Corpo],[(X, Y, Z)|C]):- ganhouJogo(Corpo, C).

main:- 
	textoInicio(),
	criaMatriz(0, Matriz),
	criaMatriz(" ", Display),
	gerandoBombas(8, Bombas),
	insereBombaNaMatriz(Bombas, Matriz, MatrizComBombas),
	imprime(Display),nl,
	game(MatrizComBombas, Display).


