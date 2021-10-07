:-dynamic opcaoJogadorReal/1.
:-dynamic numJogadores/1.


:- use_module(util).
:- use_module(cartas).
:- use_module(paineis).


main:- 
        tty_clear,
        painelApresentacao,
        read_line_to_string(user_input, _),		
        validaQuantidadeJogadores.
      
      
validaQuantidadeJogadores:-
        tty_clear,
	painelInicial,
	read_line_to_string(user_input, NumJogadoresStr),
	mapeiaQuantidadeJogadores(NumJogadoresStr, NumJogadoresInt),
	
	(NumJogadoresInt =\= -1 -> alteraNumJogadores(NumJogadoresInt), exibeCartasInicias;
	writeln("Você digitou um opção inválida. Tente novamente!"), sleep(2), validaQuantidadeJogadores).

	    
exibeCartasInicias:- 
        tty_clear,
        numJogadores(NumJogadores),
        
        baralho(Baralho),
        embaralhaLista(Baralho, BaralhoEmbaralhado),
        
        criaListaJogadores(0, NumJogadores, BaralhoEmbaralhado, ListaJogadores),
        atualizaBaralho(NumJogadores, BaralhoEmbaralhado, NovoBaralhoEmbaralhado),
        
        painelCartasIniciais(ListaJogadores, NumJogadores),
        
        read_line_to_string(user_input, _),
        validaOpcaoJogadorReal(ListaJogadores, NovoBaralhoEmbaralhado). 


validaOpcaoJogadorReal(ListaJogadores, BaralhoEmbaralhado):- 
        tty_clear,
        painelOpcaoJogo,
        read_line_to_string(user_input, OpcaoJogadorRealStr),
        mapeiaOpcaoJogadorReal(OpcaoJogadorRealStr, OpcaoJogadorRealInt),

        (OpcaoJogadorRealInt =:= 1 -> nl, writeln("Você é o Jogador 1, boa sorte!"), alteraOpcaoJogadorReal(1), sleep(2), 
        sorteiaJogadorIniciante(ListaJogadores, BaralhoEmbaralhado);

        OpcaoJogadorRealInt =:= 2 -> nl, writeln("Ok, divirta-se!"), alteraOpcaoJogadorReal(0), sleep(2),
        sorteiaJogadorIniciante(ListaJogadores, BaralhoEmbaralhado);
        
        writeln("Você digitou um opção inválida. Tente novamente!"), sleep(2), validaOpcaoJogadorReal(ListaJogadores, BaralhoEmbaralhado)).


sorteiaJogadorIniciante(ListaJogadores, BaralhoEmbaralhado):-
        tty_clear,
        numJogadores(NumJogadores),
        embaralhaLista(BaralhoEmbaralhado, NovoBaralhoEmbaralhado),
        
        selecionaCartasSorteio(0,NumJogadores, BaralhoEmbaralhado, CartasSorteadas),
        CartaMenorValor = ["0", ""],
        calculaMaiorValorCarta(CartaMenorValor, CartasSorteadas, MaiorCarta),
        
        contaValorRepetidoCarta(MaiorCarta, CartasSorteadas, 0, NumValorRepetido),        
                
        (NumValorRepetido > 1 -> IndiceMaiorCarta is -1, painelSorteio(CartasSorteadas, NumJogadores, IndiceMaiorCarta),
        read_line_to_string(user_input, _), sorteiaJogadorIniciante(ListaJogadores, NovoBaralhoEmbaralhado);
        
        nth0(IndiceMaiorCarta, CartasSorteadas, MaiorCarta), painelSorteio(CartasSorteadas, NumJogadores, IndiceMaiorCarta),
        iniciaPartica(ListaJogadores, IndiceMaiorCarta, NovoBaralhoEmbaralhado) 
        ).
        

iniciaPartica(ListaJogadores, IndiceJogadorInicial, BaralhoEmbaralhado):-
        selecionaPrimeiraCartaNaoCoringa(BaralhoEmbaralhado, MesaInicial),
        nl, write("Mesa Inicial: "), writeln(MesaInicial),

        nl, nl, writeln("Pressione Enter para continuar!"),

        read_line_to_string(user_input, _),


        removeCartaJogador(MesaInicial, BaralhoEmbaralhado, NovoBaralhoEmbaralhado),         
        OrdemInicial = "horario",

        verificaJogadorReal(MesaInicial, ListaJogadores, IndiceJogadorInicial, OrdemInicial, NovoBaralhoEmbaralhado).
    

verificaJogadorReal(Mesa, ListaJogadores, IndiceJogador, Ordem, BaralhoEmbaralhado):-
        opcaoJogadorReal(OpcaoJogadorReal),
                                                        
        (OpcaoJogadorReal =:= 1, IndiceJogador =:= 0 -> turnoJogadorReal(Mesa, ListaJogadores, Ordem, BaralhoEmbaralhado);
        turnoJogador(Mesa, ListaJogadores, IndiceJogador, Ordem, BaralhoEmbaralhado)).         
              

turnoJogador(Mesa, ListaJogadores, IndiceJogador, Ordem, BaralhoEmbaralhado):-
        tty_clear,
        numJogadores(NumJogadores),
        
        nth0(IndiceJogador, ListaJogadores, Jogador),
        length(Jogador, LenJog1),
        
        verificaJogada(Mesa, Jogador, Mesa2),
        removeCartaJogador(Mesa2, Jogador, NovoJogador),
        length(NovoJogador, LenJog2),
        
        atualizaListaJogadores(IndiceJogador, NovoJogador, ListaJogadores, NovaListaJogadores),
        atualizaCorCoringa(Mesa2, NovaMesa),

        TipoPainel = "normal",
        (NumJogadores =:= 2 -> painel2Jogadores(ListaJogadores, IndiceJogador, TipoPainel);
        NumJogadores =:= 3 -> painel3Jogadores(ListaJogadores, IndiceJogador, TipoPainel);
        NumJogadores =:= 4 -> painel4Jogadores(ListaJogadores, IndiceJogador, TipoPainel)),

        painelMostraMesa(NovaMesa),
        (LenJog1 =:= LenJog2 -> incrementaMaoJogador(Mesa, NovaListaJogadores, IndiceJogador, Ordem, BaralhoEmbaralhado);
        atualizaJogo(1, NovaMesa, NovaListaJogadores, IndiceJogador, Ordem, BaralhoEmbaralhado)).
             

incrementaMaoJogador(Mesa, ListaJogadores, IndiceJogador, Ordem, BaralhoEmbaralhado):-
        tty_clear,
        read_line_to_string(user_input, _),
        numJogadores(NumJogadores),

        nth0(IndiceJogador, ListaJogadores, Jogador),
        adicionaCartaJogador(BaralhoEmbaralhado, Jogador, NovoJogador),
        length(NovoJogador, LenJog1),

        removeCartaBaralho(BaralhoEmbaralhado, BaralhoAtualizado),

        verificaJogada(Mesa, NovoJogador, Mesa2),
        removeCartaJogador(Mesa2, NovoJogador, NovoJogador2),
        length(NovoJogador2, LenJog2),

        atualizaListaJogadores(IndiceJogador, NovoJogador, ListaJogadores, NovaListaJogadoresAux),
        atualizaListaJogadores(IndiceJogador, NovoJogador2, ListaJogadores, NovaListaJogadores),
        atualizaCorCoringa(Mesa2, NovaMesa),
        
        TipoPainel = "monte",
        (NumJogadores =:= 2 -> painel2Jogadores(NovaListaJogadoresAux, IndiceJogador, TipoPainel);
        NumJogadores =:= 3 -> painel3Jogadores(NovaListaJogadoresAux, IndiceJogador, TipoPainel);
        NumJogadores =:= 4 -> painel4Jogadores(NovaListaJogadoresAux, IndiceJogador, TipoPainel)),

        painelMostraMesa(NovaMesa),
        tty_clear,

        (LenJog1 =:= LenJog2 -> atualizaJogo(0, NovaMesa, NovaListaJogadores, IndiceJogador, Ordem, BaralhoAtualizado);
                                atualizaJogo(1, NovaMesa, NovaListaJogadores, IndiceJogador, Ordem, BaralhoAtualizado)).


turnoJogadorReal(Mesa, ListaJogadores, Ordem, BaralhoEmbaralhado):-
        tty_clear,
        numJogadores(NumJogadores),
        IndiceJogador is 0,
	nth0(IndiceJogador, ListaJogadores, Jogador),
        TipoPainel = "normal",
        (NumJogadores =:= 2 -> painel2Jogadores(ListaJogadores, IndiceJogador, TipoPainel);
        NumJogadores =:= 3 -> painel3Jogadores(ListaJogadores, IndiceJogador, TipoPainel);
        NumJogadores =:= 4 -> painel4Jogadores(ListaJogadores, IndiceJogador, TipoPainel)),
        verificaViabilidadeJogada(0, Mesa, Jogador, ViabilidadeJogada),
        
        (ViabilidadeJogada =:= 1 -> verificaIndicesDisponiveis(IndiceJogador, Mesa, Jogador, ListaIndicesDisponiveis),
        painelCartasViaveis(Mesa, ListaIndicesDisponiveis, Jogador),
        solicitaJogadaJogadorReal(Mesa, ListaJogadores, Ordem, BaralhoEmbaralhado);

        painelJogadaIndisponivel(Mesa, TipoPainel),  
        incementaMaoJogadorReal(Mesa, ListaJogadores, Ordem, BaralhoEmbaralhado)
        ).
        

incementaMaoJogadorReal(Mesa, ListaJogadores, Ordem, BaralhoEmbaralhado):-
        read_line_to_string(user_input, _),
        tty_clear,
        numJogadores(NumJogadores),
        IndiceJogador is 0,
	nth0(IndiceJogador, ListaJogadores, Jogador),
        adicionaCartaJogador(BaralhoEmbaralhado, Jogador, NovoJogador),
        removeCartaBaralho(BaralhoEmbaralhado, NovoBaralhoEmbaralhado),

        atualizaListaJogadores(IndiceJogador, NovoJogador, ListaJogadores, NovaListaJogadores),
        
        TipoPainel = "monte",
        (NumJogadores =:= 2 -> painel2Jogadores(NovaListaJogadores, IndiceJogador, TipoPainel);
        NumJogadores =:= 3 -> painel3Jogadores(NovaListaJogadores, IndiceJogador, TipoPainel);
        NumJogadores =:= 4 -> painel4Jogadores(NovaListaJogadores, IndiceJogador, TipoPainel)),

        verificaViabilidadeJogada(0, Mesa, NovoJogador, ViabilidadeJogada),

        (ViabilidadeJogada =:= 1 -> verificaIndicesDisponiveis(IndiceJogador, Mesa, NovoJogador, ListaIndicesDisponiveis),
        painelCartasViaveis(Mesa, ListaIndicesDisponiveis, NovoJogador),
        solicitaJogadaJogadorReal(Mesa, NovaListaJogadores, Ordem, NovoBaralhoEmbaralhado);

        painelJogadaIndisponivel(Mesa, TipoPainel), 
        atualizaJogo(0, Mesa, NovaListaJogadores, IndiceJogador, Ordem, NovoBaralhoEmbaralhado)
        ).
        

solicitaJogadaJogadorReal(Mesa, ListaJogadores, Ordem, BaralhoEmbaralhado):-
        IndiceJogador is 0,
	nth0(IndiceJogador, ListaJogadores, Jogador),
        length(Jogador, LenJog),

        writeln("Digite o índice referente a carta que você deseja jogar: "),
        read_line_to_string(user_input, IndiceCartaString),

        mapeiaIndicePorString(IndiceCartaString, LenJog, IndiceCarta),

        verificaViabilidadeIndice(IndiceCarta, Mesa, Jogador, ViabilidadeIndice),
        (ViabilidadeIndice =:= 1 -> nth0(IndiceCarta, Jogador, NovaMesa), removeCartaJogador(NovaMesa, Jogador, NovoJogador),
        atualizaListaJogadores(IndiceJogador, NovoJogador, ListaJogadores, NovaListaJogadores), 
        isCoringa(1, NovaMesa, NovaListaJogadores, Ordem, BaralhoEmbaralhado);

        writeln(""), writeln("Você digitou uma opção inválida. Tente novamente!"), writeln(""),
        solicitaJogadaJogadorReal(Mesa, ListaJogadores, Ordem, BaralhoEmbaralhado)).
        

isCoringa(TesteMesaAlterada, NovaMesa, ListaJogadores, Ordem, BaralhoEmbaralhado):-
        IndiceJogador is 0,
        nth0(0, NovaMesa, TipoNovaMesa),

        ( (TipoNovaMesa = "C+4"; TipoNovaMesa = "C") -> painelTrocaCorCoringa, read_line_to_string(user_input, CorNumStr),
        mapeiaCorPorNumero(CorNumStr, CorPalavra),  
        testaValidadeCorCoringa(TesteMesaAlterada, NovaMesa, ListaJogadores, Ordem, BaralhoEmbaralhado, CorPalavra);
        
        nl, nl,writeln("Pressione Enter para continuar!"),
        atualizaJogo(TesteMesaAlterada, NovaMesa, ListaJogadores, IndiceJogador, Ordem, BaralhoEmbaralhado)).


testaValidadeCorCoringa(TesteMesaAlterada, NovaMesa, ListaJogadores, Ordem, BaralhoEmbaralhado, Cor):-
        IndiceJogador is 0,

        (Cor = "null" -> writeln(""), writeln("Você digitou uma opção inválida. Tente novamente!"), sleep(2), tty_clear, write("Mesa: "), writeln(NovaMesa),
        isCoringa(TesteMesaAlterada, NovaMesa, ListaJogadores, Ordem, BaralhoEmbaralhado);
        
        nl, nl, writeln("Pressione Enter para continuar!"),
        atualizaCorCoringaJogadorReal(Cor, NovaMesa, NovaMesa2),
        atualizaJogo(TesteMesaAlterada, NovaMesa2, ListaJogadores, IndiceJogador, Ordem, BaralhoEmbaralhado)).        


atualizaJogo(TesteMesaAlterada, NovaMesa, ListaJogadores, IndiceJogador, Ordem, BaralhoEmbaralhado):-
        read_line_to_string(user_input, _),
        numJogadores(NumJogadores),
        nth0(IndiceJogador, ListaJogadores, Jogador),

        numProxJogador(Ordem, IndiceJogador, NumJogadores, IndiceProxJogador),
        nth0(IndiceProxJogador, ListaJogadores, AuxProximoJogador),
        numProxJogador(Ordem, IndiceProxJogador, NumJogadores, NovoIndiceProxJogador),

        length(Jogador, LenJog),
        nth0(0, NovaMesa, TipoMesa),
        
        (LenJog =:= 0, NumJogadores =:= 2 -> tty_clear, painel2Jogadores(ListaJogadores, IndiceJogador, "fim"), halt; 
        LenJog =:= 0, NumJogadores =:= 3 -> tty_clear, painel3Jogadores(ListaJogadores, IndiceJogador, "fim"), halt;
        LenJog =:= 0, NumJogadores =:= 4 -> tty_clear, painel4Jogadores(ListaJogadores, IndiceJogador, "fim"), halt; 
             
        TesteMesaAlterada is 1, TipoMesa = "I" -> inverteOrdem(Ordem, NovaOrdem), numProxJogador(NovaOrdem, IndiceJogador, NumJogadores, R), ajustaIndice(R, NumJogadores, IndiceAjustado),
        verificaJogadorReal(NovaMesa, ListaJogadores, IndiceAjustado, NovaOrdem, BaralhoEmbaralhado);
        
        TesteMesaAlterada is 1, TipoMesa = "P" -> verificaJogadorReal(NovaMesa, ListaJogadores, NovoIndiceProxJogador, Ordem, BaralhoEmbaralhado);
        
        TesteMesaAlterada is 1, TipoMesa = "+2" -> adiciona2CartasJogador(BaralhoEmbaralhado, AuxProximoJogador, ProximoJogador), remove2CartasBaralho(BaralhoEmbaralhado, NovoBaralhoEmbaralhado),
        atualizaListaJogadores(IndiceProxJogador, ProximoJogador, ListaJogadores, NovaListaJogadores),
        verificaJogadorReal(NovaMesa, NovaListaJogadores, NovoIndiceProxJogador, Ordem, NovoBaralhoEmbaralhado);
        
        TesteMesaAlterada is 1, TipoMesa = "C+4" -> adiciona4CartasJogador(BaralhoEmbaralhado, AuxProximoJogador, ProximoJogador), remove4CartasBaralho(BaralhoEmbaralhado, NovoBaralhoEmbaralhado),
        atualizaListaJogadores(IndiceProxJogador, ProximoJogador, ListaJogadores, NovaListaJogadores),
        verificaJogadorReal(NovaMesa, NovaListaJogadores, NovoIndiceProxJogador, Ordem, NovoBaralhoEmbaralhado);
        
        verificaJogadorReal(NovaMesa, ListaJogadores, IndiceProxJogador, Ordem, BaralhoEmbaralhado)).


alteraOpcaoJogadorReal(Opcao):- abolish(opcaoJogadorReal/1), asserta(opcaoJogadorReal(Opcao)).
alteraNumJogadores(Numero):- abolish(numJogadores/1), asserta(numJogadores(Numero)).


opcaoJogadorReal(-1).
numJogadores(0).

                
                
                                  


