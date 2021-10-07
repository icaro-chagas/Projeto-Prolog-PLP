:- module(util,
    [criaListaindicesString/3,
    mapeiaIndicePorString/3,
    mapeiaQuantidadeJogadores/2,
    mapeiaCorPorNumero/2,
    mapeiaOpcaoJogadorReal/2,
    selecionaPrimeiraCartaNaoCoringa/2,
    selecionaCartasSorteio/4,
    contaValorRepetidoCarta/4,
    calculaMaiorValorCarta/3,
    verificaIndicesDisponiveis/4,
    verificaViabilidadeJogada/4,
    verificaViabilidadeIndice/4,
    atualizaListaJogadores/4,
    atualizaCorCoringa/2,
    atualizaCorCoringaJogadorReal/3,
    embaralhaLista/2,
    verificaJogada/3,
    removeCartaJogador/3,
    adicionaCartaJogador/3,
    adiciona2CartasJogador/3,
    adiciona4CartasJogador/3,
    removeCartaBaralho/2,
    remove2CartasBaralho/2,
    remove4CartasBaralho/2,
    atualizaBaralho/3,
    numProxJogador/4,
    inverteOrdem/2,
    ajustaIndice/3,
    criaListaJogadores/4]
    ).

criaListaindicesString(LenJogador, LenJogador, []):- !.
criaListaindicesString(I, LenJogador, [IString|R]):- number_string(I, IString), I2 is I + 1, criaListaindicesString(I2, LenJogador, R). 


mapeiaIndicePorString(NumString, LenJogador, R):- criaListaindicesString(0, LenJogador, ListaNumString), member(NumString, ListaNumString), atom_number(NumString, R), !.
mapeiaIndicePorString(_, _, -1).


mapeiaQuantidadeJogadores("2", 2):- !.
mapeiaQuantidadeJogadores("3", 3):- !.
mapeiaQuantidadeJogadores("4", 4):- !.
mapeiaQuantidadeJogadores(_, -1).


mapeiaCorPorNumero("1", "Azul"):- !.
mapeiaCorPorNumero("2", "Verde"):- !.
mapeiaCorPorNumero("3", "Amarela"):- !.
mapeiaCorPorNumero("4", "Vermelha"):- !.
mapeiaCorPorNumero(_, "null").


mapeiaOpcaoJogadorReal("1", 1):- !.
mapeiaOpcaoJogadorReal("2", 2):- !.
mapeiaOpcaoJogadorReal(_, -1).


selecionaPrimeiraCartaNaoCoringa([H|T], R):- nth0(1, H, Cor), Cor = "Preta", selecionaPrimeiraCartaNaoCoringa(T, R), !.
selecionaPrimeiraCartaNaoCoringa([H|_], H):- nth0(1, H, Cor), not(Cor = "Preta").


selecionaCartasSorteio(NumJogadores, NumJogadores, _, []):- !.
selecionaCartasSorteio(I,NumJogadores, [H|T], [H|R]):- I2 is I + 1, selecionaCartasSorteio(I2,NumJogadores, T, R).

        
contaValorRepetidoCarta(_, [], Count, Count):- !.
contaValorRepetidoCarta(Carta, [H|T], Count, R):- (getValorCarta(H, ValorH), getValorCarta(Carta, ValorC), ValorH =:= ValorC 
                                                       -> Count2 is Count + 1, contaValorRepetidoCarta(Carta, T, Count2, R); 
                                                                               contaValorRepetidoCarta(Carta, T, Count, R)).


getValorCarta(Carta, 0):- nth0(0, Carta, Valor), member(Valor, ["I", "P", "+2", "C", "C+4"]), !.
getValorCarta(Carta, R):- nth0(0, Carta, Valor), atom_number(Valor, R).


calculaMaiorValorCarta(Carta, [], Carta):- !.
calculaMaiorValorCarta(Carta, [H|T], R):- (getValorCarta(H, ValorH), getValorCarta(Carta, ValorC), ValorH > ValorC -> calculaMaiorValorCarta(H, T, R); 
                                                                                                                 calculaMaiorValorCarta(Carta, T, R)).

        
verificaIndicesDisponiveis(Indice, _, Jogador, []):- length(Jogador, LenJog), Indice =:= LenJog, !.
verificaIndicesDisponiveis(Indice, Mesa, Jogador, [Indice|R]):- verificaViabilidadeIndice(Indice, Mesa, Jogador, R2), R2 =:= 1, I2 is Indice + 1, verificaIndicesDisponiveis(I2, Mesa, Jogador, R), !.
verificaIndicesDisponiveis(Indice, Mesa, Jogador, R):- I2 is Indice + 1, verificaIndicesDisponiveis(I2, Mesa, Jogador, R).

        
verificaViabilidadeJogada(Indice, _, Jogador, 0):- length(Jogador, LenJog), Indice =:= LenJog, !.
verificaViabilidadeJogada(Indice, Mesa, Jogador, 1):- verificaViabilidadeIndice(Indice, Mesa, Jogador, R), R =:= 1, !.
verificaViabilidadeJogada(Indice, Mesa, Jogador, R):- I2 is Indice + 1, verificaViabilidadeJogada(I2, Mesa, Jogador, R).
 
      
verificaViabilidadeIndice(Indice, Mesa, Jogador, R):- nth0(Indice, Jogador, CartaJogador), nth0(0, CartaJogador, TipoCarta), TipoCarta = "C+4", 
                                                       testaViabilidadeCoringaMais4(Mesa, Jogador, RC4), RC4 is 1, R is 1, !.
verificaViabilidadeIndice(Indice, Mesa, Jogador, R):- nth0(Indice, Jogador, CartaJogador), nth0(0, CartaJogador, TipoCarta), nth0(0, Mesa, TipoCarta), not(TipoCarta = "C+4"), R is 1, !.
verificaViabilidadeIndice(Indice, Mesa, Jogador, R):- nth0(Indice, Jogador, CartaJogador), nth0(1, CartaJogador, CorCarta), nth0(1, Mesa, CorCarta), R is 1, !.
verificaViabilidadeIndice(Indice, _, Jogador, R):- nth0(Indice, Jogador, CartaJogador), nth0(0, CartaJogador, TipoCarta), TipoCarta = "C", R is 1, !.
verificaViabilidadeIndice(-1, _, _, 0):- !.  
verificaViabilidadeIndice(_, _, _, 0).                                                           
 
             
atualizaListaJogadores(0, NovoJogador, [_|T], [NovoJogador|T]):- !.
atualizaListaJogadores(I, NovoJogador, [H|T], [H|R]):- I > -1, I2 is I-1, atualizaListaJogadores(I2, NovoJogador, T, R), !.
atualizaListaJogadores(_, _, L, L).


atualizaCorCoringa(Carta, R):- nth0(1, Carta, Cor), Cor = "Preta", nth0(0, Carta, Tipo), 
                               embaralhaLista(["Azul", "Verde", "Amarela", "Vermelha"], CoresEbaralhadas), 
                               nth0(0, CoresEbaralhadas, NovaCor), R = [Tipo, NovaCor], !.
atualizaCorCoringa(Carta, Carta).


atualizaCorCoringaJogadorReal(Cor, Carta, NovaCarta):- nth0(0, Carta, Tipo), NovaCarta = [Tipo, Cor]. 
        
        
testaViabilidadeCoringaMais4(_, [], R):- R is 1, !.
testaViabilidadeCoringaMais4(Carta, [H|_], R):- (nth0(0, H, Tipo), nth0(0, Carta, Tipo)), not(Tipo = "C+4"), R is 0, !.
testaViabilidadeCoringaMais4(Carta, [H|_], R):-  nth0(1, H, Cor), nth0(1, Carta, Cor),R is 0, !.
testaViabilidadeCoringaMais4(_, [H|_], R):- nth0(0, H, Tipo), Tipo = "C", R is 0, !.
testaViabilidadeCoringaMais4(Carta, [_|T], R):- testaViabilidadeCoringaMais4(Carta, T, R).  

contemCoringaMais4([]):- fail.
contemCoringaMais4([H|_]):- H = ["C+4", "Preta"], !.
contemCoringaMais4([_|T]):- contemCoringaMais4(T).

testaJogaCoringaMais4(Carta, Jogador):- testaViabilidadeCoringaMais4(Carta, Jogador, R), R =:= 1, contemCoringaMais4(Jogador).

  
embaralhaLista(Lista, R) :- random_permutation(Lista, R).


verificaJogada(Carta, [], Carta).
verificaJogada(Carta, [H|T], R):- testaJogaCoringaMais4(Carta, [H|T]), R = ["C+4", "Preta"], !. 
verificaJogada(Carta, [H|_], H):- ( (nth0(0,H, Tipo), nth0(0, Carta, Tipo) ); ( nth0(1, H, Cor), nth0(1, Carta, Cor)) ), !.
verificaJogada(_, [H|_], H):- nth0(0, H, "C"), !. 
verificaJogada(Carta, [_|T], R):- verificaJogada(Carta, T, R).


removeCartaJogador(_, [], []).
removeCartaJogador(Carta, [Carta|T], T):- !.
removeCartaJogador(Carta, [H|T], [H|R]) :- removeCartaJogador(Carta, T, R).


adicionaCartaJogador([C|_], MaoJogador, R):- append([C], MaoJogador, R).
adiciona2CartasJogador([C1,C2|_], MaoJogador, R):- append([C1,C2], MaoJogador, R).
adiciona4CartasJogador([C1,C2,C3,C4|_], MaoJogador, R):- append([C1,C2,C3,C4], MaoJogador, R).


removeCartaBaralho([_|T], T).
remove2CartasBaralho([_, _|T], T).
remove4CartasBaralho([_,_,_,_|T], T).


atualizaBaralho(0, Baralho, Baralho):- !.
atualizaBaralho(NumJogadores, Baralho, R):- remove4CartasBaralho(Baralho, NB), NJ2 is NumJogadores - 1, atualizaBaralho(NJ2, NB, R).


numProxJogador(Ordem, IndiceJogAnterior, NumJogadores, R):- Ordem = "horario", (IndiceJogAnterior + 1) >= NumJogadores, R is 0, !.
numProxJogador(Ordem, IndiceJogAnterior, NumJogadores, R):- Ordem = "horario", (IndiceJogAnterior + 1) < NumJogadores, R is IndiceJogAnterior + 1, !.
numProxJogador(Ordem, IndiceJogAnterior, NumJogadores, R):- Ordem = "anti-horario", (IndiceJogAnterior - 1) =< -1, R is NumJogadores - 1, !.
numProxJogador(Ordem, IndiceJogAnterior, _, R):- Ordem = "anti-horario", (IndiceJogAnterior - 1) > -1, R is IndiceJogAnterior - 1, !.


inverteOrdem("horario", "anti-horario").
inverteOrdem("anti-horario", "horario").


ajustaIndice(IndiceJogador, NumJogadores, 1):- IndiceJogador =:= 0, NumJogadores =:= 2.
ajustaIndice(IndiceJogador, NumJogadores, 0):- IndiceJogador =:= 1, NumJogadores =:= 2.
ajustaIndice(IndiceJogador, _, IndiceJogador). 


criaJogadorParaLista([C1,C2,C3,C4|_], [C1, C2, C3, C4]).

criaListaJogadores(NumJogadores, NumJogadores, _, []):- !. 
criaListaJogadores(Indice, NumJogadores, Baralho, [H|R]):- criaJogadorParaLista(Baralho, H), I2 is Indice + 1, 
                                                           remove4CartasBaralho(Baralho, NB), criaListaJogadores(I2, NumJogadores, NB, R).