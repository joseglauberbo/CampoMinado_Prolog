/*Predicados que definem que o tabuleiro será 9x9*/
totalLinhas(L):- L is 9.
totalColunas(C):- C is 9.

/*Predicado para verificar se a posição é válida, ou seja, se está dentro da matriz*/
posicaoValida(X,Y):- totalLinhas(L), totalColunas(C), X<L, Y<C. 

/*Gerar random*/

linha is random(1, 9, X).
coluna is random(1, 9, X).






/*exemplo de gerar random em c++*/

    for(int i = 0; i <= quant_bombas; i++){

        linha = rand() % size;
        coluna = rand() % size;

        campo_minado[linha][coluna] = -1;
 
