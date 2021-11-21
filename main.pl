%Para poder inserir e remover
:- (dynamic estafeta/6). 
:- (dynamic meio_transporte/3). 
:- (dynamic pedido/7). 

%-----------------------------Ficheiros auxiliares ----------------------------
:- consult(base_de_conhecimento).
:- consult(invariantes).
%------------------------------------------------------------------------------%
%---------------------------------- Regras  -----------------------------------%
%------------------------------------------------------------------------------%

% (1) Estafeta -----------------------------------------------------------------

% Procura todos os estafetas por -----------------------------------------------

/*... um certo nome */
estafeta_nome(Nome,R) :- findall((Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE),estafeta(Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE), R).
/*... um certo id */
estafeta_id(ID,R) :- findall((Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE),estafeta(Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE), R).
/*... uma certa zona */
estafeta_zona(Zona,R) :- findall((Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE),estafeta(Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE), R).
/*... um certo tipo de transporte */
estafeta_meioT(MeioT,R) :- findall((Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE),estafeta(Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE), R).
/*... um somatorio de classificacoes*/
estafeta_sumClassf(SumClassf,R) :- findall((Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE),estafeta(Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE), R).
/*... uma certa numero de classificacoes*/
estafeta_clTotais(ClTotais,R) :- findall((Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE),estafeta(Nome,ID,Zona,MeioT,SumClassf/ClTotais,LE), R).
/*... uma certa lista de entregas */
%cestafeta_LEntrega(LE,R) :- 

adiciona_classificacao(estafeta(A, B, C, D, E, Somatorio/Total, F), Classificacao, estafeta(A, B, C, D, E, NovoSomatorio/NovoTotal, F)) :-
    NovoSomatorio is Somatorio+Classificacao,
    NovoTotal is Total+1.
    
remove_estafeta(E) :- remove_pred(E).
remove_pred(T) :- findall(I,-T::I,Li),
                remove_bc(T),
                teste(Li).
%- remocao: T -> {V,F}
remove_bc(T) :- retract(T).

%- teste: L -> {V,F}
teste([]).
teste([I|Is]):-I,teste(Is).


% (2) Meio de transporte -------------------------------------------------------

% Procura todos os meios de transporte por -------------------------------------
/*... um certo tipo */
meioTransporte_tipo(Tipo,R) :- findall((Tipo,Velocidade,Peso),meio_transporte(Tipo,Velocidade,Peso), R).
/*... uma certa velocidade */
meioTransporte_vel(Velocidade,R) :- findall((Tipo,Velocidade,Peso),meio_transporte(Tipo,Velocidade,Peso), R).
/*... um certo peso */
meioTransporte_peso(Peso,R) :- findall((Tipo,Velocidade,Peso),meio_transporte(Tipo,Velocidade,Peso), R).

% (3) Pedido -------------------------------------------------------------------

% Procura todos os pedidos por -------------------------------------------------
/*... cliente */
pedido_cliente(Cliente,R) :- findall((Cliente,Prazo,Zona,Peso,Preco,Data,Estado), pedido(Cliente,Prazo,Zona,Peso,Preco,Data,Estado), R).
/*... prazo */
pedido_prazo(Prazo,R) :- findall((Cliente,Prazo,Zona,Peso,Preco,Data,Estado), pedido(Cliente,Prazo,Zona,Peso,Preco,Data,Estado), R).
/*... zona */
pedido_zona(Zona,R) :- findall((Cliente,Prazo,Zona,Peso,Preco,Data,Estado), pedido(Cliente,Prazo,Zona,Peso,Preco,Data,Estado), R).
/*... peso */
pedido_peso(Peso,R) :- findall((Cliente,Prazo,Zona,Peso,Preco,Data,Estado), pedido(Cliente,Prazo,Zona,Peso,Preco,Data,Estado), R).
/*... data */
pedido_data(Data,R) :- findall((Cliente,Prazo,Zona,Peso,Preco,Data,Estado), pedido(Cliente,Prazo,Zona,Peso,Preco,Data,Estado), R).
/*... estado */
pedido_estado(Estado,R) :- findall((Cliente,Prazo,Zona,Peso,Preco,Data,Estado), pedido(Cliente,Prazo,Zona,Peso,Preco,Data,Estado), R).
%------------------------------------------------------------------------------%
%Estafeta mais ecologico 

%estafeta(Nome, ID, Freg, MeioT, SomatClassf/NumClassf, LPed, Penaliz)
estafeta_mais_ecologico(EstafetaSol) :-
    findall(estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,bicicleta,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz), 
            estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,bicicleta,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz),
            L),
    
    length(L, LS),
    (  
        LS == 0 ->    % Caso nao existam estafetas de bicicleta, procura os que andam de moto
            (
                findall(estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,moto,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz), 
                    estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,moto,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz),
                    LL),
                length(LL, NewL),
                (
                    NewL == 0 -> % Caso nao existam estafetas de moto, procura os de carro
                        (
                            findall(estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,carro,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz), 
                                estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,carro,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz),
                                LLL)
                            ,maiorLista(LLL,EstafetaSol)
                        )
                   ;maiorLista(LL,EstafetaSol) 
                )  
            )
            ;maiorLista(L,EstafetaSol)
    ).

%comprimento da lista de entregas do estafeta
getListPed(estafeta(_, _, _, _, _, LPed, _),LPed).


%devolve o estafeta com mais entregas
maiorLista([],L):-
    (\+var(L) ->
        writeln(L);
        writeln("Não existem estafetas")
    ),!.
maiorLista([H|T],L) :-
    getListPed(H,L1),
    length(L1,R1),
    getListPed(L,L2),
    length(L2,R2),
    (R1 >= R2 ->
        maiorLista(T,H);
        maiorLista(T,L)
    ).


%------------------------------------------------------------------------------%
%Estafeta que mais entregou a um dado pedido_cliente

estafeta_mais_entregou(Cliente):-
findall(estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,T,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz), 
            estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,T,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz),
            Lista),
    estafeta_mais_entregou_aux(Cliente,Lista,Max,0,S).


estafeta_mais_entregou_aux(_,[],S,_,S):- writeln(S).


estafeta_mais_entregou_aux(Cliente,[H|T],Max,R2,S):-
    getListPed(H,Pedidos),
    vezes_entregue(Cliente,Pedidos,0,R1),
    (R1>=R2 ->
        estafeta_mais_entregou_aux(Cliente,T,H,R1,S);
        estafeta_mais_entregou_aux(Cliente,T,Max,R2,S)
        ).

vezes_entregue(_,[],R,R).


vezes_entregue(Cliente,[pedido(IdCliente, _, _, _, _, _, _)|T],X,R):-
    (Cliente == IdCliente->
        X2 is X +1,
        vezes_entregue(Cliente,T,X2,R);
        vezes_entregue(Cliente,T,X,R)
        ).
% estafeta_mais_entregou(924093).

%------------------------------------------------------------------------------%
%Clientes servidos por um determinado estafeta

clientes_servidos(EstafetaId):-
    estafeta(_, EstafetaId, _, _, _, LPed, _),
    clientes_servidos_aux(LPed,[]).


clientes_servidos_aux([],S):- writeln(S).


clientes_servidos_aux([H|T],S):-
    H = pedido(IdCliente, _, _, _, _, _, _),
    clientes_servidos_aux(T,[IdCliente|S]).


% clientes_servidos(938283).



%------------------------------------------------------------------------------%
%Calcular valor faturado pela empresa em um dado dia

calcular_valor_faturado_dia(Ano/Mes/Dia):-
    findall(estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,T,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz), 
            estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,T,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz),
            Lista),
    calcular_valor_faturado_dia_aux(Ano/Mes/Dia,Lista,0,Total).


calcular_valor_faturado_dia_aux(_,[],Total,Total):- writeln(Total).

calcular_valor_faturado_dia_aux(Ano/Mes/Dia,[H|T],Calculado,Total):-
    estafeta_valor_faturado_dia(Ano/Mes/Dia,H,R),
    NovoCalculado is R + Calculado,
    calcular_valor_faturado_dia_aux(Ano/Mes/Dia,T,NovoCalculado,Total) . 


estafeta_valor_faturado_dia(Ano/Mes/Dia,H,R):-
    getListPed(H,Pedidos),
    estafeta_valor_faturado_dia_aux(Ano/Mes/Dia,Pedidos,0,R).

estafeta_valor_faturado_dia_aux(_,[],R,R).

estafeta_valor_faturado_dia_aux(Ano/Mes/Dia,[H|T],C,R):-
    H = pedido(_, Limite, _, _, Peso, Y/M/D, _),
    (Y == Ano , M == Mes , D == Dia ->
        calcular_valor(Y/M/D,Limite,Peso,Valor),
        NovoC is C + Valor,
        estafeta_valor_faturado_dia_aux(Ano/Mes/Dia,T,NovoC,R);
        estafeta_valor_faturado_dia_aux(Ano/Mes/Dia,T,C,R)
        ).


calcular_valor(Y/M/D,YLim/MLim/DLim,Peso,Valor):-
    
    Valor is div(Peso*2 , (DLim - D)).



%calcular_valor_faturado_dia(2021/4/1).

%------------------------------------------------------------------------------%
%Calcular zonas com maior volume de entregas

maior_volume_entregas_zona():-
    findall(estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,T,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz), 
            estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,T,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz),
            Lista),
    maior_volume_entregas_zonaAux(Lista,[]).
   
maior_volume_entregas_zonaAux([],[]):-
    writeln("Nao existem estafetas").

maior_volume_entregas_zonaAux([],[H|T]):-
    H = Zona/Acc,
    writeGreatestDouble(T,Acc,Zona,RAcc,RZona),
    writeln(RZona),writeln(RAcc).

maior_volume_entregas_zonaAux([H|T],Zona_Acc):-
    H = estafeta(_,_,_,_,_,ListaPedidos,_),
    adicionaContagem(ListaPedidos,Zona_Acc,NovaZona_Acc),
    maior_volume_entregas_zonaAux(T,NovaZona_Acc).

%atualiza lista de zona/contagem
adicionaContagem([],S,S).
adicionaContagem([H|T],Zona_Acc,NovaZona_Acc):-
    H = pedido(_, _, _, Zona, _, _, _),
    atualiza_lista_pares(Zona,1,Zona_Acc,[],S,0),
    adicionaContagem(T,S,NovaZona_Acc).


atualiza_lista_pares(_,_,_,S,S,1).

atualiza_lista_pares(Z,Acc,[],R,S,0):-
    atualiza_lista_pares(Z,Acc,[],[Z/Acc|R],S,1).

atualiza_lista_pares(Z,Acc,[H|T],R,S,0):-
    H = Zona/A,
    (Z == Zona->
        Acc2 is A +Acc,
        append(T,[Z/Acc2|R],NovaLista),
        atualiza_lista_pares(Z,Acc,T,NovaLista,S,1);
        atualiza_lista_pares(Z,Acc,T,[H|R],S,0)
        ).


%maior_volume_entregas_zona().
%atualiza_lista_pares(ferreiros,1,[figueiredo/1,ferreiros/5],[],S,0).

%------------------------------------------------------------------------------%
%Calcular classificacao media de um estafeta

classificacao_media(EstafetaId):-
    estafeta(_,EstafetaId,_,_,SomatClassf/ClTotais,_,_),
    Media is SomatClassf / ClTotais,
    writeln(Media).



%classificacao_media(938283).


%------------------------------------------------------------------------------%
%Calcular numero de entregas para cada transporte num intervalo de tempo

numero_entregas_intervalo_transporte(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi):-
    findall(estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,T,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz), 
            estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,T,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz),
            Lista),
    numero_entregas_intervalo_transporte_aux(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Lista,0,0,0,TotalBic,TotalMo,TotalCar).


numero_entregas_intervalo_transporte_aux(_,_,[],TotalBic,TotalMo,TotalCar,TotalBic,TotalMo,TotalCar):-
    writeln("Total entregas:"),
    write("Bicicleta -> "),writeln(TotalBic),
    write("Moto -> "),writeln(TotalMo),
    write("Carro -> "),writeln(TotalCar).

numero_entregas_intervalo_transporte_aux(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,[H|T],CalcBi,CalcMo,CalcCar,TotalBic,TotalMo,TotalCar):-
    H = estafeta(_,_,_,meio_transporte(_,Meio,_,_),_,Pedidos,_),
    numero_entregas_intervalo_transporte_aux2(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Meio,Pedidos,0,0,0,B,M,C),
    NovoCalcBi is CalcBi + B,
    NovoCalcMo is CalcMo + M,
    NovoCalcCar is CalcCar + C,
    numero_entregas_intervalo_transporte_aux(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,T,NovoCalcBi,NovoCalcMo,NovoCalcCar,TotalBic,TotalMo,TotalCar).

numero_entregas_intervalo_transporte_aux2(_,_,_,[],B,M,C,B,M,C).

numero_entregas_intervalo_transporte_aux2(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Meio,[H|T],CB,CM,CC,B,M,C):-
    H = pedido(_, _, _, _, _,Ano/Mes/Dia , _),
    data_no_intervalo(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Ano/Mes/Dia,S),
    (S == 1 -> 
        (Meio == bicicleta ->
            (
                NovoCB is CB + 1,
                numero_entregas_intervalo_transporte_aux2(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Meio,T,NovoCB,CM,CC,B,M,C)
                );
            Meio == moto ->
            (
                NovoCM is CM + 1,
                numero_entregas_intervalo_transporte_aux2(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Meio,T,CB,NovoCM,CC,B,M,C)
                );
            NovoCC is CC + 1,
            numero_entregas_intervalo_transporte_aux2(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Meio,T,CB,CM,NovoCC,B,M,C)
            );
        numero_entregas_intervalo_transporte_aux2(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Meio,T,CB,CM,CC,B,M,C)
        ).


%numero_entregas_intervalo_transporte(2021/1/1,2021/5/20).

%------------------------------------------------------------------------------%
%nº de encomendas entregues e nao entregues num intervalo de tempo-------------%

calcula_n_encomendas(AnoI/MesI/DiaI,AnoF/MesF/DiaF,R_NEnt/R_Ent) :-
    findall(LPed, 
            estafeta(_, _, _, _, _, LPed, _),
            L),
    filtra_pedidos(L,AnoI/MesI/DiaI,AnoF/MesF/DiaF,0/0,R_NEnt/R_Ent). 

filtra_pedidos([],_,_,R1/R2,R1/R2).
filtra_pedidos([[]|TS],D1,D2,Accs,Rs) :- filtra_pedidos(TS,D1,D2,Accs,Rs).
filtra_pedidos([[P|T]|TS],DataI,DataF,Acc1/Acc2,R) :-
    getData(P,DataP),
    data_no_intervalo(DataI,DataF,DataP,S),
    (S == 1 ->
        getEstado(P,Estado),
        (Estado == 0 ->
         New_Acc1 is Acc1+1,
         filtra_pedidos([T|TS],DataI,DataF,New_Acc1/Acc2,R);

         New_Acc2 is Acc2+1,
         filtra_pedidos([T|TS],DataI,DataF,Acc1/New_Acc2,R)
        );
        
        filtra_pedidos([T|TS],DataI,DataF,Acc1/Acc2,R)
    ).   

getData(pedido(_, _,DataP, _, _,_, _),DataP).
getEstado(pedido(_, _, _, _, _,_, Estado),Estado).
%------------------------------------------------------------------------------%
%calcular o peso total transportado por um estafeta em um dia

calcula_peso_total(ID, Ano/Mes/Dia, PesoTotal) :-
    estafeta(_, ID, _, _, _, LPed, _),
    filtra_pedidos_dia(LPed,Ano/Mes/Dia,0,PesoTotal).

filtra_pedidos_dia([],_,R,R).
filtra_pedidos_dia([pedido(_, A/M/D, _,_,Peso, _, _)|T],Ano/Mes/Dia,Acc,R) :-
    ((A == Ano , M == Mes , D == Dia) ->
        NewAcc is Acc+Peso,
        filtra_pedidos_dia(T,Ano/Mes/Dia,NewAcc,R);
        filtra_pedidos_dia(T,Ano/Mes/Dia,Acc,R)
    ).

%------------------------------------------------------------------------------%
%identificar o numero total de entregas pelos estafetos num determinado tempo

total_entregas_intervalo(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi) :-
    findall(estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,T,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz), 
            estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,T,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz),
            Lista),
    total_entregas_intervalo_aux(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Lista,0).

total_entregas_intervalo_aux(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,[],R):-writeln(R).
total_entregas_intervalo_aux(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,[H|T],R):-
    getListPed(H,Pedidos),
    numero_entregas_intervalo_transporte_aux2(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Meio,Pedidos,0,0,0,B,M,C),
    CalcEstafeta is R +B + M + C,
    total_entregas_intervalo_aux(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,T,CalcEstafeta).

%total_entregas_intervalo(2021/1/1,2021/12/31).


/*
estafeta("joaquim", 938283, "lamas", meio_transporte(417169, carro, 25, 100), 33/15, 
    [pedido(146065, 2021/3/4, "Rua 11", "lamas", 73, 2021/3/1, 1), 
     pedido(3858, 2021/4/17, "Rua 10", "lamas", 42, 2021/4/1, 0), 
     pedido(457710, 2021/10/10, "Rua 0", "lamas", 24, 2021/10/1, 1), 
     pedido(321960, 2021/4/12, "Rua 8", "lamas", 97, 2021/4/1, 1), 
     pedido(339500, 2021/7/14, "Rua 5", "lamas", 3, 2021/7/1, 1), 
     pedido(408132, 2021/7/18, "Rua 2", "lamas", 46, 2021/7/1, 1), 
     pedido(7725, 2021/9/14, "Rua 0", "lamas", 92, 2021/9/1, 1), 
     pedido(427064, 2021/6/28, "Rua 17", "lamas", 66, 2021/6/1, 1), 
     pedido(745235, 2021/2/23, "Rua 2", "lamas", 23, 2021/2/1, 0), 
     pedido(281199, 2021/4/16, "Rua 0", "lamas", 11, 2021/4/1, 0), 
     pedido(814554, 2021/3/18, "Rua 7", "lamas", 4, 2021/3/1, 0), 
     pedido(315704, 2021/5/6, "Rua 7", "lamas", 10, 2021/5/1, 0), 
     pedido(496065, 2021/10/1, "Rua 16", "lamas", 30, 2021/10/1, 1), 
     pedido(711540, 2021/6/30, "Rua 2", "lamas", 87, 2021/6/1, 0), 
     pedido(688685, 2021/11/22, "Rua 13", "lamas", 77, 2021/11/1, 0)], 0).
*/


%------------------------------------------------------------------------------%

%Auxiliares
valida_data((Ano, Mes, Dia)) :-
    Ano>0,
    Mes>0,
    Mes<13,
    Dia>0,
    Dia<32.

is_transporte(moto).
is_transporte(bicicleta).
is_transporte(carro).

valida_transporte(moto, V, P) :-
    V >= 0, V =< 35,
    P >= 0, P =< 20.
valida_transporte(bicicleta,V,P) :-
    V >= 0, V =< 10, 
    P >= 0, P =< 5.
valida_transporte(carro,V,P) :-
    V >= 0, V =< 100,
    P >= 0, P =< 25.

data_no_intervalo(AnoLo/MesLo/DiaLo,AnoHi/MesHi/DiaHi,Ano/Mes/Dia,S):-
    data_valor(AnoLo/MesLo/DiaLo, Lo),
    data_valor(AnoHi/MesHi/DiaHi,Li),
    data_valor(Ano/Mes/Dia,L),
    (L>=Lo , L=<Li -> S is 1; S is 0).



data_valor(AnoLo/MesLo/DiaLo,S):-
    S is AnoLo*400 + MesLo*32 + DiaLo.

writeGreatestDouble([],TAcc,AZona,TAcc,AZona).

writeGreatestDouble([Z/A|T],Acc,Zona,TAcc,AZona):-
    (A>Acc ->
        writeGreatestDouble(T,A,Z,TAcc,AZona);
        writeGreatestDouble(T,Acc,Zona,TAcc,AZona)
        ).