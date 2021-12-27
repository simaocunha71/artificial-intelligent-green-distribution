:- consult(src/view/view_menu).
:- consult(src/view/grafos_view).
:- consult(src/model/queries).
:- consult(src/model/base_de_conhecimento).
:- consult(src/model/listagens).
:- consult(src/model/fluxo).
:- consult(src/model/invariantes).
:- consult(src/model/pesquisas).
:- consult(src/model/base_de_conhecimento).

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
    menuTravessias.

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
    write_lista_estafeta(R, 0).

estafeta_id_view :-
    write('ID:'),
    read(ID),
    estafeta_id(ID, R),
    write_lista_estafeta(R,0).

estafeta_zona_view :-
    write('Zona:'),
    read(Zona),
    estafeta_zona(Zona, R),
    write_lista_estafeta(R,1).

estafeta_meioT_view :-
    write('Meio de transporte (escreve apenas o tipo):'),
    read(MTranp),
    estafeta_meioT(MTranp, R),
    write_lista_estafeta(R,1).

estafeta_sumClassf_view :-
    write('Somatório das classificações:'),
    read(sumClassf),
    estafeta_sumClassf(sumClassf, R),
    write_lista_estafeta(R,0).

estafeta_clTotais_view :-
    write('Classificação total: '),
    read(clTotais),
    estafeta_clTotais(clTotais, R),
    write_lista_estafeta(R,0).

estafeta_LEntrega_view :-
    write('Lista de entregas: '),
    read(LE),
    estafeta_LEntrega(LE, R),
    write_lista_estafeta(R,0).

estafeta_Penaliz_view :-
    write('Nível de penalização: '),
    read(P),
    estafeta_Penaliz(P, R),
    write_lista_estafeta(R,1).


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
        write_lista_estafeta(S,1);
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
    estafeta_zona(Zona,R), write_lista_estafeta(R,1),
    pickEstafeta(R,Ef),
    getTodosPontosEntrega(Ef,Aux1),
    append(["Centro de distribuições"], Aux1, Aux2),
    append(Aux2, ["Centro de distribuições"], Pts),
    (TipoPesq=:=1, emProfundidade(Zona,Pts,[],_);
     TipoPesq=:=2, emLargura(Zona,Pts,[],_);
     TipoPesq=:=3, embilp(Zona,Pts,[],_);
     TipoPesq=:=4, emgulosa(Zona,Pts,[],_);
     TipoPesq=:=5, em_a_estrela(Zona,Pts,[],_)
    ).
 


pickEstafeta([],_).
pickEstafeta([H],H).
pickEstafeta(List,Ef) :-
    writeln("Escreve o indice (a começar no 0) do estafeta que quer utilizar para as travessias"),
    read(X),
    ( (X >= 0 , length(List, Size), X < Size) ->
        getElementByIndex(X,List, Ef);
        writeln("Indice a aceder inválido"),pickEstafeta(List,Ef)
    ).



