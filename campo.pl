/*:-[textos].*/

use_module(library(random)).

:-initialization main.

criaMatriz(Matriz):- Matriz = [
(1, 1, 0), (1, 2, 0), (1, 3, 0), (1, 4, 0), (1, 5, 0), (1, 6, 0), (1, 7, 0), (1, 8, 0), (1, 9, 0), 
(2, 1, 0), (2, 2, 0), (2, 3, 0), (2, 4, 0), (2, 5, 0), (2, 6, 0), (2, 7, 0), (2, 8, 0), (2, 9, 0), 
(3, 1, 0), (3, 2, 0), (3, 3, 0), (3, 4, 0), (3, 5, 0), (3, 6, 0), (3, 7, 0), (3, 8, 0), (3, 9, 0), 
(4, 1, 0), (4, 2, 0), (4, 3, 0), (4, 4, 0), (4, 5, 0), (4, 6, 0), (4, 7, 0), (4, 8, 0), (4, 9, 0), 
(5, 1, 0), (5, 2, 0), (5, 3, 0), (5, 4, 0), (5, 5, 0), (5, 6, 0), (5, 7, 0), (5, 8, 0), (5, 9, 0), 
(6, 1, 0), (6, 2, 0), (6, 3, 0), (6, 4, 0), (6, 5, 0), (6, 6, 0), (6, 7, 0), (6, 8, 0), (6, 9, 0), 
(7, 1, 0), (7, 2, 0), (7, 3, 0), (7, 4, 0), (7, 5, 0), (7, 6, 0), (7, 7, 0), (7, 8, 0), (7, 9, 0), 
(8, 1, 0), (8, 2, 0), (8, 3, 0), (8, 4, 0), (8, 5, 0), (8, 6, 0), (8, 7, 0), (8, 8, 0), (8, 9, 0), 
(9, 1, 0), (9, 2, 0), (9, 3, 0), (9, 4, 0), (9, 5, 0), (9, 6, 0), (9, 7, 0), (9, 8, 0), (9, 9, 0) 
]. 

criaMatrizUsuario(Matriz):- Matriz = [
(1, 1, " "), (1, 2, " "), (1, 3, " "), (1, 4, " "), (1, 5, " "), (1, 6, " "), (1, 7, " "), (1, 8, " "), (1, 9, " "), 
(2, 1, " "), (2, 2, " "), (2, 3, " "), (2, 4, " "), (2, 5, " "), (2, 6, " "), (2, 7, " "), (2, 8, " "), (2, 9, " "), 
(3, 1, " "), (3, 2, " "), (3, 3, " "), (3, 4, " "), (3, 5, " "), (3, 6, " "), (3, 7, " "), (3, 8, " "), (3, 9, " "), 
(4, 1, " "), (4, 2, " "), (4, 3, " "), (4, 4, " "), (4, 5, " "), (4, 6, " "), (4, 7, " "), (4, 8, " "), (4, 9, " "), 
(5, 1, " "), (5, 2, " "), (5, 3, " "), (5, 4, " "), (5, 5, " "), (5, 6, " "), (5, 7, " "), (5, 8, " "), (5, 9, " "), 
(6, 1, " "), (6, 2, " "), (6, 3, " "), (6, 4, " "), (6, 5, " "), (6, 6, " "), (6, 7, " "), (6, 8, " "), (6, 9, " "), 
(7, 1, " "), (7, 2, " "), (7, 3, " "), (7, 4, " "), (7, 5, " "), (7, 6, " "), (7, 7, " "), (7, 8, " "), (7, 9, " "), 
(8, 1, " "), (8, 2, " "), (8, 3, " "), (8, 4, " "), (8, 5, " "), (8, 6, " "), (8, 7, " "), (8, 8, " "), (8, 9, " "), 
(9, 1, " "), (9, 2, " "), (9, 3, " "), (9, 4, " "), (9, 5, " "), (9, 6, " "), (9, 7, " "), (9, 8, " "), (9, 9, " ") 
]. 

numeroAleatorio(X):- random(1, 10, X).	

editaListaCoord([Head|Tail], 0, Elem, [Elem|Tail]).
editaListaCoord([Head|Tail], Pos, Elem, NLista):- NLista is [Head|Ts], Z is Pos - 1, editaListaCoord(Tail, Z, Elem, Ts).

insereBombaNaMatriz([], Matriz, Matriz).
insereBombaNaMatriz([(X,Y)|TBombas], Matriz, NovaMatriz):- editaLista(X, Y, -1, Matriz, MatrizTemp),
	getAdjacentes(X, Y, Adj),
	addDicas(Adj, MatrizTemp, MatrizComDicas), 
	insereBombaNaMatriz(TBombas, MatrizComDicas, NovaMatriz).
 
%geraBomba(Matriz, Matriz_modificada, 1):- numeroAleatorio(X), numeroAleatorio(Y), insereBombaNaMatriz(X, Y, Matriz, Matriz_modificada).
%geraBomba(Matriz, Matriz_modificada, Contador):- numeroAleatorio(X), numeroAleatorio(Y), insereBombaNaMatriz(X, Y, Matriz, Matriz_modificada), C is Contador-1, geraBomba(Matriz, Matriz_modificada, C).

imprime([]).
imprime([(_,_,X1),(_,_,X2), (_,_,X3), (_,_,X4), (_,_,X5), (_,_,X6), (_,_,X7), (_,_,X8), (_,_,X9)|Corpo]):- write("    |"),write(X1), write("|   |"), write(X2), write("|   |"), write(X3), write("|   |"), write(X4), write("|   |"), write(X5), write("|   |"), write(X6), write("|   |"), write(X7), write("|   |"), write(X8), write("|   |"), write(X9),write("|"),nl,imprime(Corpo).

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

editaLista(CoordX, CoordY, Elem, [(CoordX, CoordY, Z)|T], [(CoordX, CoordY, Elem)|T]).	
editaLista(CoordX, CoordY, Elem, [H|T], NovaLista):- NovaLista = [H|Ts],
	editaLista(CoordX, CoordY, Elem, T, Ts).                        


gerarCoordAleatoria(Coord):- numeroAleatorio(X), numeroAleatorio(Y), Coord = (X,Y).

gerandoBombas(NBombas, ListBombas):- length(TempList, NBombas),
	maplist( gerarCoordAleatoria, TempList), sort(TempList, ListBombas).

coordValida(X,Y):- X > 0, X < 10, Y > 0, Y < 10.

filtraCoords([], Filtradas).
filtraCoords([(X,Y)|Tcoords], Filtradas):- coordValida(X,Y) -> Filtradas = [(X,Y)|Ts], filtraCoords(Tcoords, Ts);
Filtradas = Ts, filtraCoords(Tcoords, Ts).


getAdjacentes(X, Y, Adjacentes):- TodasAdjacentes = [(A,Y), (B,Y), (X,C), (X,D), (A,C), (A,D), (B,C), (B,D)],
	A  is X + 1, B is X - 1, C is Y + 1, D is Y - 1,
	filtraCoords(TodasAdjacentes, Adjacentes).


getElem(X, Y, [(X, Y, Elem)|T], Elem).
getElem(X,Y, [H|T], Elem):- getElem(X, Y, T, Elem).


addDicas([], Matriz, Matriz).
addDicas([(X,Y)|Tail], Matriz, NovaMatriz):- getElem(X, Y, Matriz, Ele), Z is Ele + 1,
	(Ele == -1 -> addDicas(Tail, Matriz, NovaMatriz);
	editaLista(X, Y, Z, Matriz, TempMatriz), addDicas(Tail, TempMatriz, NovaMatriz)).



game(Matriz, Display):- read_X(X), read_Y(Y), getElem(X,Y, Matriz, Ele),
	(Ele =:= (-1) -> modificaMatriz(Matriz, Nova),
		imprime(Nova), nl, 
		write("GAMEOVER! VOCÊ PERDEU!"),halt(0);
	abreCasa(X,Y, Matriz, Display, NovoDisplay),
	imprime(NovoDisplay), nl, game(Matriz, NovoDisplay)),nl.


main:- 

criaMatriz(Matriz),
criaMatrizUsuario(Display),
gerandoBombas(8, Bombas),
insereBombaNaMatriz(Bombas, Matriz, MatrizComBombas),
imprime(Display),nl,
game(MatrizComBombas, Display).
