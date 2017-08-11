/*Predicados que definem que o tabuleiro será 9x9*/
totalLinhas(L):- L is 9.
totalColunas(C):- C is 9.

/*Predicado para verificar se a posição é válida, ou seja, se está dentro da matriz*/
posicaoValida(X,Y):- totalLinhas(L), totalColunas(C), X<L, Y<C. 
