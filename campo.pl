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

editaListaCoord([_|Tail], 0, Elem, [Elem|Tail]).
editaListaCoord([Head|Tail], Pos, Elem, NLista):- NLista is [Head|Ts], Z is Pos - 1, editaListaCoord(Tail, Z, Elem, Ts).

/*Funcoes que geram as bombas*/
/*Funcao que chama o insereBombaNaMatriz 8 vezes e no final chama o somaAdjacentes.*/
%geraBomba(Matriz, Matriz_modificada, 1):- numeroAleatorio(X), numeroAleatorio(Y), insereBombaNaMatriz(X, Y, Matriz, Matriz_modificada).
%geraBomba(Matriz, Matriz_modificada, Contador):- numeroAleatorio(X), numeroAleatorio(Y), insereBombaNaMatriz(X, Y, Matriz, Matriz_modificada), C is Contador-1, geraBomba(Matriz, Matriz_modificada, C).

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


abreCasa(X,Y, Matriz, Display, MatrizAberta):- getElem(X, Y, Matriz, Ele),
	(Ele =:= 0 -> editaLista(X, Y, "_", Display, MatrizAberta);
	Ele =:= (-1) -> editaLista(X, Y, "*", Display, MatrizAberta);
	editaLista(X, Y, Ele, Display, MatrizAberta)).


/*atom_concat("| ",Z, R1)*/

read_X(CoordX) :-
	writeln("Digite uma coordenada y entre 1 e 9: "),
	read_line_to_codes(user_input, X2),
	(string_to_atom(X2,X1),
	atom_number(X1,X), X =< 9, X >= 1) -> ( CoordX is X); (write("Número invalido"),nl, read_X(CoordX)).

read_Y(CoordY) :-
	writeln("Digite uma coordenada x entre 1 e 9: "),
	read_line_to_codes(user_input, Y2),
	(string_to_atom(Y2,Y1),
	atom_number(Y1,Y), Y =< 9, Y >= 1) -> ( CoordY is Y); (write("Número invalido"),nl, read_Y(CoordY)).

editaLista(CoordX, CoordY, Elem, [(CoordX, CoordY, _)|T], [(CoordX, CoordY, Elem)|T]).	
editaLista(CoordX, CoordY, Elem, [H|T], NovaLista):- NovaLista = [H|Ts],
	editaLista(CoordX, CoordY, Elem, T, Ts).                        


gerarCoordAleatoria(Coord):- numeroAleatorio(X), numeroAleatorio(Y), Coord = (X,Y).

gerandoBombas(NBombas, ListBombas):- length(TempList, NBombas),
	maplist( gerarCoordAleatoria, TempList), sort(TempList, ListBombas).

coordValida(X,Y):- X > 0, X < 10, Y > 0, Y < 10.

filtraCoords([], _).
filtraCoords([(X,Y)|Tcoords], Filtradas):- coordValida(X,Y) -> Filtradas = [(X,Y)|Ts], filtraCoords(Tcoords, Ts);
Filtradas = Ts, filtraCoords(Tcoords, Ts).


getAdjacentes(X, Y, Adjacentes):- TodasAdjacentes = [(A,Y), (B,Y), (X,C), (X,D), (A,C), (A,D), (B,C), (B,D)],
	A  is X + 1, B is X - 1, C is Y + 1, D is Y - 1,
	filtraCoords(TodasAdjacentes, Adjacentes).


getElem(X, Y, [(X, Y, Elem)|_], Elem).
getElem(X,Y, [_|T], Elem):- getElem(X, Y, T, Elem).


addDicas([], Matriz, Matriz).
addDicas([(X,Y)|Tail], Matriz, NovaMatriz):- getElem(X, Y, Matriz, Ele), Z is Ele + 1,
	(Ele == -1 -> addDicas(Tail, Matriz, NovaMatriz);
	editaLista(X, Y, Z, Matriz, TempMatriz), addDicas(Tail, TempMatriz, NovaMatriz)).


game(Matriz, Display):- read_X(X), read_Y(Y), getElem(X,Y, Matriz, Ele),
	(Ele =:= (-1) -> modificaMatriz(Matriz, Nova),
	imprime(Nova), nl, 
	textoPerdeu(), nl,
	halt(0);
	abreCasa(X,Y, Matriz, Display, NovoDisplay), 
	naoGanhouJogo(NovoDisplay),
	imprime(NovoDisplay), nl, game(Matriz, NovoDisplay)),nl;
	textoGanhou(), halt(0).
	
/*Funcao que verifica se nao ganhou o jogo.*/
naoGanhouJogo([]):-false.
naoGanhouJogo([(_, _, " ")|_]).
naoGanhouJogo([(_, _, _)|Corpo]):-naoGanhouJogo(Corpo).


main:- 

textoInicio(),
criaMatriz(0, Matriz),
criaMatriz(" ", Display),
gerandoBombas(8, Bombas),
insereBombaNaMatriz(Bombas, Matriz, MatrizComBombas),
imprime(Display),nl,
game(MatrizComBombas, Display).

