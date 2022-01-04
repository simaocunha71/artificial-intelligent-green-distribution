:- consult(src/view/view_menu).
:- consult(src/view/grafos_view).
:- consult(src/model/queries).
:- consult(src/model/base_de_conhecimento).
:- consult(src/model/listagens).
:- consult(src/model/fluxo).
:- consult(src/model/invariantes).
:- consult(src/model/pesquisas).
:- consult(src/model/base_de_conhecimento).
:- use_module(library(dialect/sicstus/system)).

:- (dynamic estafeta/7). 
:- (dynamic meio_transporte/4). 
:- (dynamic pedido/8). 
:- (dynamic morada/2). 
:- (dynamic cliente/2). 

run_opt(1) :-
    limpaT,
    menuAddTermos.

run_opt(2) :-
    limpaT,
    menuListagens.

run_opt(3) :-
    limpaT,
    menuQueries.

run_opt(4) :-
    limpaT,
    menuT.

run_opt(0) :-
    write('\033\[31m----------Adeus!------------\033\[0m\n'),
    halt.

run_opt(_) :- limpaT,
              write('Opção Inválida'),
              menuPrincipal,
              read(Choice),
              run_opt(Choice).


runApp():-
    limpaT,
    menuPrincipal,
    read(Choice),
    run_opt(Choice).


% ------------------------------ Menu listagens ------------------------------------------

menuListagens :-
    menuListas,
    read(Option),
    limpaT,
    executarListagem(Option).

menuListagens_estafetas :-
    menuListar_estafetas,
    read(Option),
    executarListagem_estafetas(Option).

menuListagens_MT :-
    menuListar_MT,
    read(Option),
    executarListagem_mt(Option).

menuListagens_Pedidos :-
    menuListar_Pedidos,
    read(Option),
    executarListagem_pedidos(Option).


executarListagem(Option) :-(Option=:=1, menuListagens_estafetas;
                            Option=:=2, menuListagens_MT;
                            Option=:=3, menuListagens_Pedidos;
                    
                            Option=:=0, runApp,limpaT
                            ),menuListagens.

executarListagem_estafetas(Option) :-(Option=:=1, estafeta_nome_view;
                                      Option=:=2, estafeta_id_view;
                                      Option=:=3, estafeta_zona_view;
                                      Option=:=4, estafeta_meioT_view;
                                      Option=:=5, estafeta_sumClassf_view;
                                      Option=:=6, estafeta_clTotais_view;
                                      Option=:=7, estafeta_LEntrega_view;
                                      Option=:=8, estafeta_Penaliz_view; 
                    
                                      Option=:=0, limpaT,menuListagens
                                      ),menuListagens_estafetas.


executarListagem_mt(Option) :-(Option=:=1, meioTransporte_matricula_view;
                               Option=:=2, meioTransporte_tipo_view;
                               Option=:=3, meioTransporte_vel_view;
                               Option=:=4, meioTransporte_peso_view;
                    
                               Option=:=0, limpaT,menuListagens
                              ),menuListagens_MT.


executarListagem_pedidos(Option) :-( Option=:=1, pedido_id_view;
                                     Option=:=2, pedido_cliente_view;
                                     Option=:=3, pedido_prazo_view;  
                                     Option=:=4, pedido_rua_view;
                                     Option=:=5, pedido_zona_view; 
                                     Option=:=6, pedido_peso_view;   
                                     Option=:=7, pedido_data_view; 
                                     Option=:=8, pedido_estado_view; 
                    
                                     Option=:=0, limpaT,menuListagens
                                    ),menuListagens_Pedidos.

/*-------------------------------------------------------------------------- */
/*------------------------------ Adicionar termos -------------------------- */
/*-------------------------------------------------------------------------- */

menuAddTermos :-
    limpaT,
    menuAddTermosGeral,
    read(Option),
    executarAdd(Option).

executarAdd(Option) :-( Option=:=1, (addMorada,limpaT);

                        Option=:=2, (addMT,limpaT);

                        Option=:=3, (addCliente,limpaT);  

                        Option=:=4, addEstafeta,limpaT; 

                        Option=:=5, addPedidoAoEstafeta,limpaT;   
                    
                        Option=:=0, runApp,limpaT
                    ),menuAddTermos.

addMorada:-
    writeln('Zona: '), read(Zona),
    writeln('Rua: '), read(Rua),
    evolucao(morada(Zona,Rua)).


addMT:-
    writeln('ID do transporte: '), read(ID),
    writeln('Tipo do transporte: '), read(Tipo),
    writeln('Velocidade média do transporte: '), read(V),
    writeln('Peso máximo do transporte: '), read(P),
    evolucao(meio_transporte(ID,Tipo,V,P)).

addCliente:-
    writeln('Nome do cliente: '), read(Nome),
    writeln('ID do cliente: '), read(ID),
    evolucao(cliente(Nome,ID)). 

addPedido :-
    writeln('Nome do cliente: '), read(Nome),
    writeln('ID do cliente: '), read(IDC),
    writeln('ID do pedido: '), read(ID),
    writeln('Data de entrega: '), read(DataE),
    writeln('Zona: '), read(Zona),
    writeln('Rua: '), read(Rua),
    writeln('Peso: '), read(Peso),
    writeln('Data do pedido: '), read(DataP),
    writeln('Estado: '), read(Est),
    evolucao(pedido(cliente(Nome,IDC),ID,DataE,Rua,Zona,Peso,DataP,Est)).

addEstafeta :-
    writeln('Nome: '), read(Nome),
    writeln('ID do estafeta: '), read(ID),
    writeln('Zona: '), read(Z),
    writeln('ID do transporte: '), read(IDT),
    writeln('Tipo do transporte: '), read(Tipo),
    writeln('Velocidade média do transporte: '), read(V),
    writeln('Peso máximo do transporte: '), read(P),
    writeln('Somatório de classificações '), read(SC),
    writeln('Número de classificações: '), read(NC),
    writeln('Penalização: '), read(P),
    evolucao(estafeta(Nome,ID,Z,meio_transporte(IDT,Tipo,V,P),SC/NC,[],P)).


addPedidoAoEstafeta :-
    writeln('ID do estafeta: '), read(ID),
    estafeta_id(ID,R),
    length(R, L),
    (L == 1 ->
       R = [H|_],
       H = estafeta(Nome,ID,Z,MT,Cl,LE,Penaliz),

           writeln('Nome do cliente: '), read(NomeC),
           writeln('ID do cliente: '), read(IDC),
           writeln('ID do pedido: '), read(IDP),
           writeln('Data de entrega: '), read(DataE),
           writeln('Zona: '), read(Zona),
           writeln('Rua: '), read(Rua),
           writeln('Peso: '), read(Peso),
           writeln('Data do pedido: '), read(DataP),
           writeln('Estado: '), read(Est),
           E = pedido(cliente(NomeC,IDC),IDP,DataE,Rua,Zona,Peso,DataP,Est),
           evolucao(E),

       evolucao_troca(H,estafeta(Nome,ID,Z,MT,Cl,[E|LE],Penaliz)),
       (estafeta(_,ID,_,_,_,_,_) -> 
         evolucao(H)
        );
       writeln('Estafeta não existe') 
    ).

% ------------------------------ Menu queries ------------------------------------------

menuQueries :-
    menuQuery_view,
    read(Option),
    executarQuery(Option).


executarQuery(Option) :-(Option=:=1, estafeta_mais_ecologico_view;
                         Option=:=2, estafeta_entregaram_cliente;
                         Option=:=3, clientes_servidos_view;
                         Option=:=4, calcular_valor_faturado_dia_view;
                         Option=:=5, maior_volume_entregas_zona_view;
                         Option=:=6, classificacao_media_view;
                         Option=:=7, numero_entregas_intervalo_transporte_view;
                         Option=:=8, total_entregas_intervalo_view;
                         Option=:=9, calcula_n_encomendas_view;
                         Option=:=10, calcula_pesos_totais_view;
                         Option=:=11, calcula_peso_total_view; 
                    
                         Option=:=0, runApp, limpaT
                         ), menuQueries.

/*-------------------------------------------------------------------------- */
/*------------------------------ Listagens --------------------------------- */
/*-------------------------------------------------------------------------- */

/*------------------------------ Estafeta ---------------------------------- */
estafeta_nome_view :-
    write('Nome:'),
    read(Nome),
    estafeta_nome(Nome, R),
    write_lista_estafeta(R, 0,0).

estafeta_id_view :-
    write('ID:'),
    read(ID),
    estafeta_id(ID, R),
    write_lista_estafeta(R,0,0).

estafeta_zona_view :-
    write('Zona:'),
    read(Zona),
    estafeta_zona(Zona, R),
    write_lista_estafeta(R,1,0).

estafeta_meioT_view :-
    write('Meio de transporte (escreve apenas o tipo):'),
    read(MTranp),
    estafeta_meioT(MTranp, R),
    write_lista_estafeta(R,1,0).

estafeta_sumClassf_view :-
    write('Somatório das classificações:'),
    read(sumClassf),
    estafeta_sumClassf(sumClassf, R),
    write_lista_estafeta(R,0,0).

estafeta_clTotais_view :-
    write('Classificação total: '),
    read(clTotais),
    estafeta_clTotais(clTotais, R),
    write_lista_estafeta(R,0,0).

estafeta_LEntrega_view :-
    write('Lista de entregas: '),
    read(LE),
    estafeta_LEntrega(LE, R),
    write_lista_estafeta(R,0,0).

estafeta_Penaliz_view :-
    write('Nível de penalização: '),
    read(P),
    estafeta_Penaliz(P, R),
    write_lista_estafeta(R,1,0).


/*------------------------------ Meios de transporte ---------------------------------- */
meioTransporte_matricula_view :-
    write('Matricula do transporte:'),
    read(Matricula),
    meioTransporte_matricula(Matricula, R),
    printMts(R).

meioTransporte_tipo_view :-
    write('Tipo de transporte:'),
    read(Tipo),
    meioTransporte_tipo(Tipo, R),
    printMts(R).

meioTransporte_vel_view :-
    write('Velocidade do transporte:'),
    read(Vel),
    meioTransporte_vel(Vel, R),
    printMts(R).


meioTransporte_peso_view :-
    write('Peso do transporte:'),
    read(Peso),
    meioTransporte_peso(Peso, R),
    printMts(R).


/*------------------------------ Pedidos ---------------------------------- */
pedido_id_view :-
    write('ID do pedido: '),
    read(ID),
    pedido_cliente(ID, R),
    printPedidos(R).

pedido_cliente_view :-
    write('ID do cliente: '),
    read(ClienteID),
    pedido_cliente(ClienteID, R),
    printPedidos(R).


pedido_prazo_view :-
    write('Prazo: '),
    read(Prazo),
    pedido_prazo(Prazo, R),
    printPedidos(R).

pedido_rua_view :-
    write('Rua: '),
    read(Rua),
    pedido_rua(Rua, R),
    printPedidos(R).

pedido_zona_view :-
    write('Zona: '),
    read(Zona),
    pedido_zona(Zona, R),
    printPedidos(R).

pedido_peso_view :-
    write('Peso: '),
    read(Peso),
    pedido_peso(Peso, R),
    printPedidos(R).

pedido_data_view :-
    write('Data: '),
    read(Data),
    pedido_data(Data, R),
    printPedidos(R).

pedido_estado_view :-
    write('Estado: '),
    read(Estado),
    pedido_estado(Estado, R),
    printPedidos(R).

/*-------------------------------------------------------------------------- */
/*------------------------------ Querys ------------------------------------ */
/*-------------------------------------------------------------------------- */


estafeta_mais_ecologico_view :-
    estafeta_mais_ecologico(X),
    (\+var(X) ->
        writeEstafeta(X);
        writeln('Não existem estafetas na base de conhecimento')
    ).
    
estafeta_entregaram_cliente :-
    writeln('Cliente: '),
    read(Cliente),
    estafeta_entregaram_cliente(Cliente,S),
    (\+var(S) ->
        write_lista_estafeta(S,1,0);
        writeln('Não existem estafetas na base de conhecimento')
    ).


estafeta_mais_entregou_view :-
    writeln('Cliente: '),
    read(Cliente),
    estafeta_mais_entregou(Cliente,S),
    (\+var(S) ->
        writeEstafeta(S);
        writeln('Não existem estafetas na base de conhecimento')
    ).

clientes_servidos_view :-
    writeln('ID do estafeta: '),
    read(ID),
    clientes_servidos(ID,L),
    writeln('Clientes servidos: '),
    writeln(L).

calcular_valor_faturado_dia_view :-
    writeln('Data: '),
    read(Data),
    calcular_valor_faturado_dia(Data,V),
    write('Valor faturado: '),
    writeln(V).

maior_volume_entregas_zona_view :-
    maior_volume_entregas_zona().
    %writeln(X).

classificacao_media_view :-
    writeln('Id do estafeta: '),
    read(ID),
    classificacao_media(ID,C),
    write('Classificação média do estafeta: '),
    writeln(C).

numero_entregas_intervalo_transporte_view :-
    writeln('Data limite inferior: '),
    read(DataInf),
    writeln('Data limite superior: '),
    read(DataSup),
    numero_entregas_intervalo_transporte(DataInf,DataSup,TotalBic,TotalMo,TotalCar),
    writeln('Total de encomendas:'),
    write('> bicicleta -> '), writeln(TotalBic),
    write('> moto -> '), writeln(TotalMo),
    write('> carro -> '), writeln(TotalCar).

total_entregas_intervalo_view :-
    writeln('Data limite inferior: '),
    read(DataInf),
    write('Data limite superior: '),
    read(DataSup),
    total_entregas_intervalo(DataInf, DataSup, N),
    write('Entregas efetuadas: '),
    writeln(N).   

calcula_n_encomendas_view :-
    writeln('Data limite inferior: '),
    read(DataInf),
    writeln('Data limite superior: '),
    read(DataSup),
    calcula_n_encomendas(DataInf, DataSup, N),
    write('Encomendas efetuadas: '),
    writeln(N).    

calcula_pesos_totais_view :-
    writeln('Data: '),
    read(Data),
    calcula_pesos(Data,L),
    write_lista_estafPesos(L).
calcula_peso_total_view :-
    writeln('Id do estafeta: '),
    read(ID),
    writeln('Data: '),
    read(Data),
    calcula_peso_total(ID, Data, P),
    write('Peso total: '),
    writeln(P).

/*-------------------------------------------------------------------------- */
/*------------------------------ Travessias -------------------------------- */
/*-------------------------------------------------------------------------- */
menuT :-
    menuT_view,
    read(Opt),
    executeTrav(Opt).

executeTrav(Opt) :- (Opt=:=1, limpaT, menuTravessias;
                     Opt=:=2, limpaT, menuComparaCircuitos;
                     Opt=:=3, limpaT, menuCircuitoRapido;
                     Opt=:=4, limpaT, menuCircuitoEco;
                     Opt=:=5, limpaT, menuTravessiasTeste;

                     Opt=:=0, runApp, limpaT
                     ), menuT.


menuTravessias :-
    menuTravessias_view,
    read(TipoPesq),
    menuGrafos_view,
    read(Option),
    selectZona(TipoPesq,Option).


selectZona(TipoPesq,Option) :-(Option=:=1, limpaT, print_Ruilhe    , zonaPesq_view("Ruilhe",TipoPesq);
                               Option=:=2, limpaT, print_Lomar     , zonaPesq_view("Lomar",TipoPesq);
                               Option=:=3, limpaT, print_Semelhe   , zonaPesq_view("Semelhe",TipoPesq);
                               Option=:=4, limpaT, print_Cabreiros , zonaPesq_view("Cabreiros",TipoPesq);
                               Option=:=5, limpaT, print_Ferreiros , zonaPesq_view("Ferreiros",TipoPesq);

                               Option=:=0, runApp, limpaT
                               ), menuTravessias.

zonaPesq_view(Zona,TipoPesq) :-
    writeln("Estafetas disponíveis:"), 
    estafeta_zona(Zona,R), write_lista_estafeta(R,1,0),
    pickEstafeta(R,Ef),
    diminuiVel(Ef,Vel),
    getTodosPontosEntrega(Ef,Aux1),
    append(["Centro de distribuições"], Aux1, Pts),
    get_time(Inicio),
    (TipoPesq=:=1, emProfundidade(Zona,Pts,"Centro de distribuições",[],0,_,_);
     TipoPesq=:=2, emLargura(Zona,Pts,"Centro de distribuições",[],0,_,_);
     TipoPesq=:=3, embilp(Zona,Pts,"Centro de distribuições",[],_);
     (TipoPesq=:=4; TipoPesq =:= 5), 
     menuEuristicas,
     (read(Mode),
        (Mode =:= 1, writeln("Aplicando algoritmo greedy com heuristica DISTÂNCIA...");
         Mode =:= 2, Vel > 0, writeln("Aplicando algoritmo greedy com heuristica TEMPO...");
         Mode =:= 2, Vel =< 0, writeln("\u001B[31mVelocidade do estafeta é zero, pelo que não é possivel aplicar o algoritmo!\u001B[0m");
         Mode =\= 1 , Mode =\= 2 -> read(Mode)
        ),
        (((Mode =:= 1);(Mode =:= 2 , Vel > 0)) ->
            (TipoPesq =:= 4 ->
            greedy(Zona,Pts,"Centro de distribuições",Vel, Mode, _);
            star(Zona,Pts,"Centro de distribuições",Vel, Mode, _)
            );
            !
        )
     )
    ),
    get_time(Fim),
    TempoDecorrido is (Fim - Inicio) * 1000,
    write("Tempo decorrido: "),write(TempoDecorrido),writeln(" ms").
 


menuComparaCircuitos :-
    findall(estafeta(N,ID,Zona,MT,Cl,LE,P),
            estafeta(N,ID,Zona,MT,Cl,LE,P), 
            R),
    menuTravessias_view,
    read(Mode),
        (Mode =:= 1, compara_circuitos_dfs(R,"Centro de distribuições",[],PathList);
         Mode =:= 2, compara_circuitos_bfs(R,"Centro de distribuições",[],PathList);
         Mode =:= 3, compara_circuitos_bilp(R,"Centro de distribuições",[],PathList);
         Mode =:= 4, compara_circuitos_gulosa(R,"Centro de distribuições",[],PathList);
         Mode =:= 5, compara_circuitos_estrela(R,"Centro de distribuições",[],PathList);
         Mode =\= 1 , Mode =\= 2,Mode =\= 3 , Mode =\= 4,Mode =\= 5 -> read(Mode)
        ),
    menucomparaCircuitos2(PathList,10),
    !.

menucomparaCircuitos2(PathList,N):-
    menuComparaCircuitos2,
    read(Mode),
        (Mode =:= 1, seperateCircuito(1,PathList,[],NewPathList),sort(2,@>=,NewPathList,Sorted);
         Mode =:= 2, seperateCircuito(2,PathList,[],NewPathList),sort(2,@>=,NewPathList,Sorted);
         Mode =\= 1 , Mode =\= 2-> read(Mode)
        ),
    take(N,Sorted,BestN),
    print_list(BestN).



menuCircuitoRapido :-
    findall(estafeta(N,ID,Zona,MT,Cl,LE,P),
            estafeta(N,ID,Zona,MT,Cl,LE,P), 
            R),
    circuito_melhor(R,0).


menuCircuitoEco :-
    findall(estafeta(N,ID,Zona,meio_transporte(ID_Tr,bicicleta,Vel,Peso),Cl,LE,P),
            estafeta(N,ID,Zona,meio_transporte(ID_Tr,bicicleta,Vel,Peso),Cl,LE,P),
            Rbicileta),
    length(Rbicileta,L1),
    (L1 == 0 ->
        findall(estafeta(N,ID,Zona,meio_transporte(X,moto,Y,C),Cl,LE,P),
            estafeta(N,ID,Zona,meio_transporte(X,moto,Y,C),Cl,LE,P),
            Rmoto),
        length(Rmoto,L2),
        (L2 == 0->
            findall(estafeta(N,ID,Zona,meio_transporte(X,carro,Y,C),Cl,LE,P),
                estafeta(N,ID,Zona,meio_transporte(X,carro,Y,C),Cl,LE,P),
                Rcarro),
            length(Rcarro,L3),
            (L3 > 0-> circuito_melhor(Rcarro,1) ; !
            )
            ;circuito_melhor(Rmoto,1)
        )
        ;circuito_melhor(Rbicileta,1)   
    ).


circuito_melhor(X,Tipo):-
    menuTravessiasInformada_view,
    read(Mode),
        (Mode =:= 1, compara_circuitos_gulosa(X,"Centro de distribuições",[],PathList);
         Mode =:= 2, compara_circuitos_estrela(X,"Centro de distribuições",[],PathList);
         Mode =\= 1 , Mode =\= 2 -> read(Mode)
        ),
    menuMelhorCircuito(PathList,5,Tipo),
    !.



menuMelhorCircuito(PathList,N,Tipo):-
    (Tipo =:= 0, seperateCircuito(4,PathList,[],NewPathList),sort(2,@=<,NewPathList,Sorted);
     seperateCircuito(3,PathList,[],NewPathList),sort(2,@=<,NewPathList,Sorted)
    ),
    take(N,Sorted,BestN),
    print_list(BestN).



menuTravessiasTeste:-
    menuTravessias_view,
    read(TipoPesq),
    limpaT,

    findall(estafeta(N,ID,Zona,MT,Cl,LE,P),
            estafeta(N,ID,Zona,MT,Cl,LE,P), 
            R),
    writeln("Estafetas disponíveis:"), 
    write_lista_estafeta(R,1,0),
    pickEstafeta(R,Est),
    limpaT,
    writeln("Pedidos disponíveis:"),
    getListPed(Est,ListP),
    printPedidosSimples(ListP,0),
    pickPedido(ListP,Pedido),
    limpaT,

    diminuiVel(Est,Vel),
    getRua(Pedido,Rua),
    append(["Centro de distribuições"], [Rua], Pts),
    get_time(Inicio),
    (TipoPesq=:=1, emProfundidade(Zona,Pts,"Centro de distribuições",[],0,_,_);
     TipoPesq=:=2, emLargura(Zona,Pts,"Centro de distribuições",[],0,_,_);
     TipoPesq=:=3, embilp(Zona,Pts,"Centro de distribuições",[],_);
     (TipoPesq=:=4; TipoPesq =:= 5), 
     menuEuristicas,
     (read(Mode),
        (Mode =:= 1, writeln("Aplicando algoritmo greedy com heuristica DISTÂNCIA...");
         Mode =:= 2, Vel > 0, writeln("Aplicando algoritmo greedy com heuristica TEMPO...");
         Mode =:= 2, Vel =< 0, writeln("\u001B[31mVelocidade do estafeta é zero, pelo que não é possivel aplicar o algoritmo!\u001B[0m");
         Mode =\= 1 , Mode =\= 2 -> read(Mode)
        ),
        (((Mode =:= 1);(Mode =:= 2 , Vel > 0)) ->
            (TipoPesq =:= 4 ->
            greedy(Zona,Pts,"Centro de distribuições",Vel, Mode, _);
            star(Zona,Pts,"Centro de distribuições",Vel, Mode, _)
            );
            !
        )
     )
    ),
    get_time(Fim),
    TempoDecorrido is (Fim - Inicio) * 1000,
    write("Tempo decorrido: "),write(TempoDecorrido),writeln(" ms").




pickEstafeta([],_).
pickEstafeta(List,Ef) :-
    writeln("Escreve o indice (a começar no 0) do estafeta que quer utilizar para as travessias"),
    read(X),
    ( (X >= 0 , length(List, Size), X < Size) ->
        getElementByIndex(X,List, Ef);
        writeln("Indice a aceder inválido"),pickEstafeta(List,Ef)
    ).

pickPedido([],_).
pickPedido(List,Ef) :-
    writeln("Escreve o indice (a começar no 0) do pedido que quer entregar"),
    read(X),
    ( (X >= 0 , length(List, Size), X < Size) ->
        getElementByIndex(X,List, Ef);
        writeln("Indice a aceder inválido"),pickPedido(List,Ef)
    ).





%[estafeta(Amilcar,1,Ferreiros,meio_transporte(1,bicicleta,10,5),317/141,[pedido(cliente(Joaquim,41),1,2021/6/28,Rua 18,Ferreiros,1,2021/6/20,0),pedido(cliente(Jo,50),2,2021/3/14,Rua 10,Ferreiros,1,2021/3/4,1),pedido(cliente(Tobias,26),3,2021/7/9,Rua 11,Ferreiros,5,2021/7/5,0)],0),estafeta(Simão,2,Lomar,meio_transporte(2,bicicleta,10,5),387/164,[pedido(cliente(Geremias,6),4,2021/2/19,Rua 16,Lomar,3,2021/2/6,1),pedido(cliente(Runlo,31),5,2021/5/31,Rua 10,Lomar,4,2021/5/28,1),pedido(cliente(Geremias,6),6,2021/8/25,Rua 1,Lomar,3,2021/8/7,0),pedido(cliente(Gil,12),7,2021/2/24,Rua 10,Lomar,3,2021/2/18,0),pedido(cliente(Jorge,28),8,2021/5/23,Rua 3,Lomar,5,2021/5/18,0),pedido(cliente(Chico,18),9,2021/5/17,Rua 1,Lomar,3,2021/5/3,0),pedido(cliente(Bruno,39),10,2021/3/1,Rua 9,Lomar,3,2021/3/1,0),pedido(cliente(Amilcar,49),11,2021/1/15,Rua 0,Lomar,5,2021/1/9,1),pedido(cliente(Francisco,46),12,2021/2/28,Rua 0,Lomar,3,2021/2/22,1),pedido(cliente(Gonçalo,8),13,2021/3/27,Rua 11,Lomar,3,2021/3/1,0)],0),estafeta(Palmeira,3,Cabreiros,meio_transporte(3,moto,35,20),225/87,[pedido(cliente(Rúben,45),14,2021/10/15,Rua 1,Cabreiros,10,2021/10/12,0),pedido(cliente(Tomás,25),15,2021/10/14,Rua 4,Cabreiros,3,2021/10/10,1),pedido(cliente(Patrício,43),16,2021/12/16,Rua 10,Cabreiros,2,2021/12/10,1)],0),estafeta(Raul,4,Ruilhe,meio_transporte(4,carro,25,100),83/43,[pedido(cliente(Jo,50),17,2021/12/23,Rua 6,Ruilhe,7,2021/12/22,0),pedido(cliente(José,17),18,2021/3/21,Rua 18,Ruilhe,57,2021/3/14,1),pedido(cliente(Ricardo,32),19,2021/6/28,Rua 1,Ruilhe,4,2021/6/15,1),pedido(cliente(Zeferino,37),20,2021/4/18,Rua 5,Ruilhe,40,2021/4/2,0),pedido(cliente(Francisco,46),21,2021/3/3,Rua 1,Ruilhe,39,2021/3/1,1),pedido(cliente(Barbosa,20),22,2021/5/24,Rua 1,Ruilhe,85,2021/5/24,0),pedido(cliente(Gonçalo,8),23,2021/1/21,Rua 8,Ruilhe,39,2021/1/12,1),pedido(cliente(Pedro,9),24,2021/6/19,Rua 3,Ruilhe,76,2021/6/3,1),pedido(cliente(Fábio,11),25,2021/4/25,Rua 19,Ruilhe,14,2021/4/2,1),pedido(cliente(Duarte,10),26,2021/5/21,Rua 10,Ruilhe,98,2021/5/1,0),pedido(cliente(Miguel,14),27,2021/11/15,Rua 4,Ruilhe,39,2021/11/5,1),pedido(cliente(Rui,23),28,2021/10/13,Rua 19,Ruilhe,85,2021/10/8,0)],0),estafeta(Tina,5,Semelhe,meio_transporte(5,carro,25,100),438/171,[pedido(cliente(Joaquim,41),29,2021/7/16,Rua 13,Semelhe,78,2021/7/14,1),pedido(cliente(Runlo,31),30,2021/12/9,Rua 12,Semelhe,75,2021/12/9,1),pedido(cliente(Amilcar,49),31,2021/12/25,Rua 3,Semelhe,83,2021/12/6,1),pedido(cliente(Tiago,2),32,2021/10/8,Rua 19,Semelhe,81,2021/10/7,0),pedido(cliente(Tobias,26),33,2021/8/19,Rua 3,Semelhe,45,2021/8/19,0),pedido(cliente(Guilherme,16),34,2021/8/12,Rua 11,Semelhe,29,2021/8/12,1),pedido(cliente(Patrício,43),35,2021/1/25,Rua 7,Semelhe,53,2021/1/23,0),pedido(cliente(Pedro,9),36,2021/8/18,Rua 0,Semelhe,39,2021/8/10,1),pedido(cliente(Rúben,45),37,2021/11/25,Rua 3,Semelhe,2,2021/11/21,1),pedido(cliente(Simão,1),38,2021/11/26,Rua 19,Semelhe,21,2021/11/18,1),pedido(cliente(Raul,27),39,2021/11/28,Rua 16,Semelhe,100,2021/11/19,0),pedido(cliente(Rogério,15),40,2021/9/24,Rua 18,Semelhe,90,2021/9/14,0),pedido(cliente(Paulo,7),41,2021/7/23,Rua 8,Semelhe,58,2021/7/6,0),pedido(cliente(João,3),42,2021/12/13,Rua 0,Semelhe,66,2021/12/8,0),pedido(cliente(Simão,1),43,2021/9/7,Rua 1,Semelhe,7,2021/9/6,0),pedido(cliente(Diogo,24),44,2021/7/31,Rua 8,Semelhe,99,2021/7/30,1),pedido(cliente(Gil,12),45,2021/10/5,Rua 15,Semelhe,39,2021/10/1,0)],0)]

%estafeta("Amilcar",1,"Ferreiros",meio_transporte(1,bicicleta,10,5),317/141,[pedido(cliente("Joaquim",41),1,2021/6/28,"Rua 18","Ferreiros",1,2021/6/20,0),pedido(cliente("Jo",50),2,2021/3/14,"Rua 10","Ferreiros",1,2021/3/4,1),pedido(cliente("Tobias",26),3,2021/7/9,"Rua 11","Ferreiros",5,2021/7/5,0)],0)

%pedido(cliente("Joaquim",41),1,2021/6/28,"Centro de distribuições","Ferreiros",1,2021/6/20,0)



