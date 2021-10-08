:- module(paineis,
    [painelApresentacao/0,
    painelInicial/0,
    painelCartasIniciais/2,
    painelOpcaoJogo/0,
    painelTrocaCorCoringa/0,
    painelCartasViaveis/3,
    painelSorteio/3,
    painelMostraMesa/1,
    painelJogadaIndisponivel/2,
    painel2Jogadores/3,
    painel3Jogadores/3,
    painel4Jogadores/3]
    ).
    
painelApresentacao:-
    writeln("-- Bem vindo a versão em Prolog do Jogo Uno do Grupo 12 --"),
    nl, nl, writeln("Pressione Enter para continuar!").		
	

painelInicial:-
    writeln("Qual a quantidade de jogadores desejada? "),
    writeln("Opções disponíveis: 2, 3, 4"),
    writeln(""),
    writeln("Opção: ").

    
    
painelCartasIniciais(ListaJogadores, NumJogadores):-
     writeln("Lista de Cartas Retiradas do Monte Embaralhado Para Cada Jogador: "),
     writeln(""),
     (NumJogadores =:= 2 -> nth0(0, ListaJogadores, Jogador1), nth0(1, ListaJogadores, Jogador2),
                           write("Jogador 1: "), writeln(Jogador1),
                           write("Jogador 2: "), writeln(Jogador2);
                           
     NumJogadores =:= 3 -> nth0(0, ListaJogadores, Jogador1), nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3),
              write("Jogador 1: "), writeln(Jogador1),
                           write("Jogador 2: "), writeln(Jogador2),
                           write("Jogador 3: "), writeln(Jogador3);
     NumJogadores =:= 4 -> nth0(0, ListaJogadores, Jogador1), nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
              write("Jogador 1: "), writeln(Jogador1),
                           write("Jogador 2: "), writeln(Jogador2),
                           write("Jogador 3: "), writeln(Jogador3),
                           write("Jogador 4: "), writeln(Jogador4)),
    nl,
    writeln("Observação quanto ao tipo das cartas:"),
    writeln("   I = Carta Inverter"),
    writeln("   P = Carta Pular"),
    writeln("   +2 = Carta +2"),
    writeln("   C = Carta Coringa"),
    writeln("   C+4 = Carta Coringa +4"),
    nl, writeln("Pressione Enter para continuar!").

painelOpcaoJogo:-
    writeln("Você deseja jogar ou apenas observar bots jogarem? "),
    writeln(""),
    writeln("Opções Disponíveis:"),
    writeln("1 - Jogar"),
    writeln("2 - Observar"),
    writeln(""),
    writeln("Opção: ").	


painelTrocaCorCoringa:-
     writeln(""),
     writeln("Insira a nova cor desejada."),
     writeln("Opções:"),
     writeln("1 - Azul"),
     writeln("2 - Verde"),
     writeln("3 - Amarela"),
     writeln("4 - Vermelha"),
     writeln(""),
     writeln("Cor: ").

     
painelCartasViaveis(Mesa, ListaIndices, Jogador):-
     nl, write("Mesa: "), write(Mesa), nl, nl,
     writeln("Indices possíveis: "),
     exibeCartasViaveis(0, ListaIndices, Jogador).


exibeCartasViaveis(I, ListaIndices, _):- length(ListaIndices, LenList), I =:= LenList, writeln("").
exibeCartasViaveis(I, ListaIndices, Jogador):- nth0(I, ListaIndices, Indice), nth0(Indice, Jogador, Carta), I2 is I + 1, 
                                               write(Indice), write(": "), writeln(Carta), exibeCartasViaveis(I2, ListaIndices, Jogador).


painelSorteio(CartasSorteadas, NumJogadores, IndiceMaiorCarta):-
    (NumJogadores =:= 2, IndiceMaiorCarta =:= -1 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2), 

    writeln("EMPATE!"),        
    write("Jogador 1: "), writeln(Jogador1),
    write("Jogador 2: "), writeln(Jogador2),
    nl, nl, writeln("Pressione Enter para continuar!");

    NumJogadores =:= 3, IndiceMaiorCarta =:= -1 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2),
    nth0(2, CartasSorteadas, Jogador3),

    writeln("EMPATE!"),        
    write("Jogador 1: "), writeln(Jogador1),
    write("Jogador 2: "), writeln(Jogador2),
    write("Jogador 3: "), writeln(Jogador3),
    nl, nl, writeln("Pressione Enter para continuar!");

    NumJogadores =:= 4, IndiceMaiorCarta =:= -1 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2),
    nth0(2, CartasSorteadas, Jogador3),
    nth0(3, CartasSorteadas, Jogador4),

    writeln("EMPATE!"),        
    write("Jogador 1: "), writeln(Jogador1),
    write("Jogador 2: "), writeln(Jogador2),
    write("Jogador 3: "), writeln(Jogador3),
    write("Jogador 4: "), writeln(Jogador4),
    nl, nl, writeln("Pressione Enter para continuar!");
    
    NumJogadores =:= 2, IndiceMaiorCarta =:= 0 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2), 

    write("Jogador 1: "), write(Jogador1), writeln(" <-- Vencedor do Sorteio"),
    write("Jogador 2: "), writeln(Jogador2);

    NumJogadores =:= 2, IndiceMaiorCarta =:= 1 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2), 

    write("Jogador 1: "), writeln(Jogador1), 
    write("Jogador 2: "), write(Jogador2), writeln(" <-- Vencedor do Sorteio");

    NumJogadores =:= 3, IndiceMaiorCarta =:= 0 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2),
    nth0(2, CartasSorteadas, Jogador3), 

    write("Jogador 1: "), write(Jogador1), writeln(" <-- Vencedor do Sorteio"),
    write("Jogador 2: "), writeln(Jogador2),
    write("Jogador 3: "), writeln(Jogador3);

    NumJogadores =:= 3, IndiceMaiorCarta =:= 1 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2),
    nth0(2, CartasSorteadas, Jogador3), 

    write("Jogador 1: "), writeln(Jogador1),
    write("Jogador 2: "), write(Jogador2), writeln(" <-- Vencedor do Sorteio"),
    write("Jogador 3: "), writeln(Jogador3);

    NumJogadores =:= 3, IndiceMaiorCarta =:= 2 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2),
    nth0(2, CartasSorteadas, Jogador3), 

    write("Jogador 1: "), writeln(Jogador1),
    write("Jogador 2: "), writeln(Jogador2),
    write("Jogador 3: "), write(Jogador3), writeln(" <-- Vencedor do Sorteio");

    NumJogadores =:= 4, IndiceMaiorCarta =:= 0 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2),
    nth0(2, CartasSorteadas, Jogador3),
    nth0(3, CartasSorteadas, Jogador4),  

    write("Jogador 1: "), write(Jogador1), writeln(" <-- Vencedor do Sorteio"),
    write("Jogador 2: "), writeln(Jogador2),
    write("Jogador 3: "), writeln(Jogador3),
    write("Jogador 4: "), writeln(Jogador4);

    NumJogadores =:= 4, IndiceMaiorCarta =:= 1 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2),
    nth0(2, CartasSorteadas, Jogador3),
    nth0(3, CartasSorteadas, Jogador4),  

    write("Jogador 1: "), writeln(Jogador1),
    write("Jogador 2: "), write(Jogador2), writeln(" <-- Vencedor do Sorteio"),
    write("Jogador 3: "), writeln(Jogador3),
    write("Jogador 4: "), writeln(Jogador4);

    NumJogadores =:= 4, IndiceMaiorCarta =:= 2 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2),
    nth0(2, CartasSorteadas, Jogador3),
    nth0(3, CartasSorteadas, Jogador4),  

    write("Jogador 1: "), writeln(Jogador1),
    write("Jogador 2: "), writeln(Jogador2),
    write("Jogador 3: "), write(Jogador3), writeln(" <-- Vencedor do Sorteio"),
    write("Jogador 4: "), writeln(Jogador4);

    NumJogadores =:= 4, IndiceMaiorCarta =:= 3 ->
    nth0(0, CartasSorteadas, Jogador1),
    nth0(1, CartasSorteadas, Jogador2),
    nth0(2, CartasSorteadas, Jogador3),
    nth0(3, CartasSorteadas, Jogador4),  

    write("Jogador 1: "), writeln(Jogador1),
    write("Jogador 2: "), writeln(Jogador2),
    write("Jogador 3: "), writeln(Jogador3),
    write("Jogador 4: "), write(Jogador4), writeln(" <-- Vencedor do Sorteio")
    ).


painelMostraMesa(Mesa):-
    nl, write("Mesa: "), writeln(Mesa), nl, nl,
    writeln("Pressione Enter para continuar!").
      
      
painelJogadaIndisponivel(Mesa, Tipo):- Tipo = "normal",
    nl, write("Mesa: "), writeln(Mesa), nl,
    writeln("Jogada indisponível!"),
    nl, nl,
    writeln("Pressione Enter para continuar!").


painelJogadaIndisponivel(Mesa, Tipo):- Tipo = "monte",
    nl, write("Mesa: "), writeln(Mesa), nl,
    writeln("[Monte] Jogada indisponível!"),
    nl, nl,
    writeln("Pressione Enter para continuar!").

%_____________________________________________________________________________________________________________________________________
%PAINEL 2 JOGADORES
painel2Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 0, Tipo = "normal", nth0(0, ListaJogadores, Jogador1), nth0(1, ListaJogadores, Jogador2),
            write("Jogador 1: "), write(Jogador1), writeln(" <--"),
            write("Jogador 2: "), writeln(Jogador2).
            
painel2Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 1, Tipo = "normal", nth0(0, ListaJogadores, Jogador1), nth0(1, ListaJogadores, Jogador2),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), write(Jogador2), writeln(" <--").
            
painel2Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 0, Tipo = "monte", nth0(0, ListaJogadores, Jogador1), nth0(1, ListaJogadores, Jogador2),
            write("Jogador 1 [Monte]: "), write(Jogador1), writeln(" <--"),
            write("Jogador 2: "), writeln(Jogador2).

painel2Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 1, Tipo = "monte", nth0(0, ListaJogadores, Jogador1), nth0(1, ListaJogadores, Jogador2),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2 [Monte]: "), write(Jogador2), writeln(" <--").
            
painel2Jogadores(ListaJogadores,IndiceJogador, Tipo):- IndiceJogador =:= 0, Tipo = "fim", nth0(1, ListaJogadores, Jogador2),
            writeln(" -- Fim do Jogo -- "), 
            writeln("Jogador 1: VENCEDOR!"),
            write("Jogador 2: "), writeln(Jogador2), nl.
            
painel2Jogadores(ListaJogadores,IndiceJogador, Tipo):- IndiceJogador =:= 1, Tipo = "fim", nth0(0, ListaJogadores, Jogador1),
            writeln(" -- Fim do Jogo -- "),
            write("Jogador 1: "), writeln(Jogador1),
            writeln("Jogador 2: VENCEDOR!"), nl.
                                                          
%_____________________________________________________________________________________________________________________________________
%PAINEL 3 JOGADORES
painel3Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 0, Tipo = "normal", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3),
            write("Jogador 1: "), write(Jogador1), writeln(" <--"),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), writeln(Jogador3).
            
painel3Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 1, Tipo = "normal", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), write(Jogador2), writeln(" <--"),
            write("Jogador 3: "), writeln(Jogador3).
            
painel3Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 2, Tipo = "normal", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), write(Jogador3), writeln(" <--").
            
painel3Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 0, Tipo = "monte", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3),
            write("Jogador 1 [Monte]: "), write(Jogador1), writeln(" <--"),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), writeln(Jogador3).
            
painel3Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 1, Tipo = "monte", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2 [Monte]: "), write(Jogador2), writeln(" <--"),
            write("Jogador 3: "), writeln(Jogador3).
            
painel3Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 2, Tipo = "monte", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3 [Monte]: "), write(Jogador3), writeln(" <--").
            
painel3Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 0, Tipo = "fim",  nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3),
            writeln(" -- Fim do Jogo -- "),
            writeln("Jogador 1: VENCEDOR!"),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), writeln(Jogador3), nl.
            
painel3Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 1, Tipo = "fim", nth0(0, ListaJogadores, Jogador1), nth0(2, ListaJogadores, Jogador3),
            writeln(" -- Fim do Jogo -- "),
            write("Jogador 1: "), writeln(Jogador1),
            writeln("Jogador 2: VENCEDOR!"),
            write("Jogador 3: "), writeln(Jogador3), nl.
            
painel3Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 2, Tipo = "fim", nth0(0, ListaJogadores, Jogador1), nth0(1, ListaJogadores, Jogador2),
            writeln(" -- Fim do Jogo -- "), 
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), writeln(Jogador2),
            writeln("Jogador 3: VENCEDOR!"), nl.
            
%_____________________________________________________________________________________________________________________________________
%PAINEL 4 JOGADORES
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 0, Tipo = "normal", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
            write("Jogador 1: "), write(Jogador1), writeln(" <--"),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), writeln(Jogador3),
            write("Jogador 4: "), writeln(Jogador4).
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 1, Tipo = "normal", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), write(Jogador2), writeln(" <--"),
            write("Jogador 3: "), writeln(Jogador3),
            write("Jogador 4: "), writeln(Jogador4).
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 2, Tipo = "normal", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), write(Jogador3), writeln(" <--"),
            write("Jogador 4: "), writeln(Jogador4).
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 3, Tipo = "normal", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), writeln(Jogador3),
            write("Jogador 4: "), write(Jogador4), writeln(" <--").
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 0, Tipo = "monte", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
            write("Jogador 1 [Monte]: "), write(Jogador1), writeln(" <--"),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), writeln(Jogador3),
            write("Jogador 4: "), writeln(Jogador4).
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 1, Tipo = "monte", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2 [Monte]: "), write(Jogador2), writeln(" <--"),
            write("Jogador 3: "), writeln(Jogador3),
            write("Jogador 4: "), writeln(Jogador4).
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 2, Tipo = "monte", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3 [Monte]: "), write(Jogador3), writeln(" <--"),
            write("Jogador 4: "), writeln(Jogador4).
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 3, Tipo = "monte", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), writeln(Jogador3),
            write("Jogador 4 [Monte]: "), write(Jogador4), writeln(" <--").
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 0, Tipo = "fim",  nth0(1, ListaJogadores, Jogador2), 
                                                          nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
            writeln(" -- Fim do Jogo -- "),
            writeln("Jogador 1: VENCEDOR!"),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), writeln(Jogador3),
            write("Jogador 4: "), writeln(Jogador4), nl.
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 1, Tipo = "fim", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(2, ListaJogadores, Jogador3), nth0(3, ListaJogadores, Jogador4),
            writeln(" -- Fim do Jogo -- "),
            write("Jogador 1: "), writeln(Jogador1),
            writeln("Jogador 2: VENCEDOR!"),
            write("Jogador 3: "), writeln(Jogador3),
            write("Jogador 4: "), writeln(Jogador4), nl.
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 2, Tipo = "fim", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(3, ListaJogadores, Jogador4),
            writeln(" -- Fim do Jogo -- "),                                              
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), writeln(Jogador2),
            writeln("Jogador 3: VENCEDOR!"),
            write("Jogador 4: "), writeln(Jogador4), nl.
            
painel4Jogadores(ListaJogadores, IndiceJogador, Tipo):- IndiceJogador =:= 3, Tipo = "fim", nth0(0, ListaJogadores, Jogador1), 
                                                          nth0(1, ListaJogadores, Jogador2), nth0(2, ListaJogadores, Jogador3),
            writeln(" -- Fim do Jogo -- "),                                              
            write("Jogador 1: "), writeln(Jogador1),
            write("Jogador 2: "), writeln(Jogador2),
            write("Jogador 3: "), writeln(Jogador3),
            writeln("Jogador 4: VENCEDOR!"), nl.
