:- consult(view_menu).


run_opt(1) :-
    menuListagens.

run_opt(2) :-
    menuQuerys.

run_opt(3) :- write('Adeus\n'), halt.

run_opt(_) :- write('Opção Inválida\n').


main :-
    menuPrincipal,
    read(Choice),
    run_opt(Choice).


% ------------------------------ Menu auxiliar ------------------------------------------

menuListagens :-
    menuListas,
    read(Option),
    executarListagem(Option).

menuListagens_estafetas :-
    menuListar_estafetas,
    read(Option),
    executarListagem(Option).

menuListagens_MT :-
    menuListar_MT,
    read(Option),
    executarListagem(Option).

menuListagens_Pedidos :-
    menuListar_Pedidos,
    read(Option),
    executarListagem(Option).


executarListagem(Option) :-(Option=:=1, estafeta_nome_view;
                            Option=:=2, estafeta_id_view;
                            Option=:=3, estafeta_zona_view;
                            Option=:=4, estafeta_meioT_view;
                            Option=:=5, estafeta_sumClassf_view;
                            Option=:=6, estafeta_clTotais_view;
                            Option=:=7, estafeta_LEntrega_view;
                            Option=:=8, estafeta_Penaliz_view;

                            Option=:=9, meioTransporte_matricula_view;
                            Option=:=10, meioTransporte_tipo_view;
                            Option=:=11, meioTransporte_vel_view;
                            Option=:=12, meioTransporte_peso_view;

                            Option=:=10, pedido_cliente_view;
                            Option=:=11, pedido_prazo_view;
                            Option=:=12, pedido_zona_view;  
                            Option=:=13, pedido_peso_view;
                            Option=:=14, pedido_data_view; 
                            Option=:=15, pedido_estado_view;   
                    
                            Option=:=0, true,write('BYE'),nl,halt
                           ),main.

menuQuerys :-
    menuQuery_view,
    read(Option),
    executarListagem(Option).


executarQuery(Option) :-(Option=:=1, estafeta_mais_ecologico_view;
                         Option=:=2, estafeta_mais_entregou_view;
                         Option=:=3, clientes_servidos_view;
                         Option=:=4, calcular_valor_faturado_dia_view;
                         Option=:=5, maior_volume_entregas_zona_view;
                         Option=:=6, classificacao_media_view;
                         Option=:=7, numero_entregas_intervalo_transporte_view;
                         Option=:=8, total_entregas_intervalo_view;
                         Option=:=9, calcula_n_encomendas_view;
                         Option=:=10, calcula_peso_total_view; 
                    
                         Option=:=0, true,write('BYE'),nl,halt
                         ),main.

/*-------------------------------------------------------------------------- */
/*------------------------------ Listagens --------------------------------- */
/*-------------------------------------------------------------------------- */

/*------------------------------ Estafeta ---------------------------------- */
estafeta_nome_view :-
    write('Nome:'),
    read(Nome),
    estafeta_nome(Nome, R),
    printPedidos(R).

estafeta_id_view :-
    write('ID:'),
    read(ID),
    estafeta_id(ID, R),
    printPedidos(R).

estafeta_zona_view :-
    write('Zona:'),
    read(Zona),
    estafeta_zona(Zona, R),
    printPedidos(R).

estafeta_meioT_view :-
    write('Meio de transporte:'),
    read(MTranp),
    estafeta_meioT(MTranp, R),
    printPedidos(R).

estafeta_sumClassf_view :-
    write('Somatório das classificações:'),
    read(sumClassf),
    estafeta_sumClassf(sumClassf, R),
    printPedidos(R).

estafeta_clTotais_view :-
    write('Classificação total: '),
    read(clTotais),
    estafeta_clTotais(clTotais, R),
    printPedidos(R).

estafeta_LEntrega_view :-
    write('Lista de entregas: '),
    read(ClTotal),
    estafeta_clTotais(ClTotal, R),
    printPedidos(R).

estafeta_Penaliz_view :-
    write('Nível de penalização: '),
    read(ClTotal),
    estafeta_clTotais(ClTotal, R),
    printPedidos(R).


/*------------------------------ Meios de transporte ---------------------------------- */
meioTransporte_matricula_view :-
    write('Tipo de transporte:'),
    read(Tipo),
    meioTransporte_tipo(Tipo, R),
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
pedido_cliente_view :-
    write('Cliente: '),
    read(Cliente),
    pedido_cliente(Cliente, R),
    writeln(R).


pedido_prazo_view :-
    write('Prazo: '),
    read(Prazo),
    pedido_prazo(Prazo, R),
    writeln(R).

pedido_zona_view :-
    write('Zona: '),
    read(Zona),
    pedido_zona(Zona, R),
    writeln(R).

pedido_peso_view :-
    write('Peso: '),
    read(Peso),
    pedido_peso(Peso, R),
    writeln(R).

pedido_data_view :-
    write('Data: '),
    read(Data),
    pedido_data(Data, R),
     writeln(R).

pedido_estado_view :-
    write('Estado: '),
    read(Estado),
    pedido_estado(Estado, R),
    writeln(R).

/*-------------------------------------------------------------------------- */
/*------------------------------ Querys ------------------------------------ */
/*-------------------------------------------------------------------------- */


estafeta_mais_ecologico_view :-
    estafeta_mais_ecologico(X),
    writeEstafeta(X).

estafeta_mais_entregou_view :-
    writeln('Cliente: '),
    read(Cliente),
    estafeta_mais_entregou(Cliente,S),
    writeEstafeta(S).

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
    writeln(V).

maior_volume_entregas_zona_view :-
    maior_volume_entregas_zona(X),
    writeln(X).

classificacao_media_view :-
    writeln('Id do estafeta: '),
    read(ID),
    classificacao_media(ID,C),
    writeln(C).

numero_entregas_intervalo_transporte_view :-
    writeln('Data limite inferior: '),
    read(DataInf),
    writeln('Data limite superior: '),
    read(DataSup),
    numero_entregas_intervalo_transporte(DataInf,DataSup,N),
    writeln(N).

total_entregas_intervalo_view :-
    writeln('Data limite inferior: '),
    read(DataInf),
    write('Data limite superior: '),
    read(DataSup),
    total_entregas_intervalo(DataInf, DataSup, N),
    writeln(N).   

calcula_n_encomendas_view :-
    writeln('Data limite inferior: '),
    read(DataInf),
    writeln('Data limite superior: '),
    read(DataSup),
    calcula_n_encomendas(DataInf, DataSup, N),
    writeln(N).    

calcula_peso_total_view :-
    writeln('Id do estafeta: '),
    read(ID),
    writeln('Data: '),
    read(Data),
    calcula_peso_total(ID, Data, P),
    writeln(P).