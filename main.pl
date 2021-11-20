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
%estafeta(Nome, ID, Freg, MeioT, SomatClassf/NumClassf, LPed, Penaliz)
estafeta_mais_ecologico(EstafetaSol) :-
    findall((Nome, ID, Freg, meio_transporte(ID_Tr,bicicleta,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz), 
            estafeta(Nome, ID, Freg, meio_transporte(ID_Tr,bicicleta,Vel,Peso), SomatClassf/NumClassf, LPed, Penaliz),
            L),
    maiorLista(L,EstafetaSol).

%comprimento da lista de entregas do estafeta
getListPed(estafeta(_, _, _, _, _, LPed, _),LPed).


%devolve o estafeta com mais entregas
maiorLista([],_) :- fail.
maiorLista([L],L) :- !.
maiorLista([H|T],L) :-
    getListPed(H,L1),
    R1 is length(L1),
    writeln(R1),
    R2 is 2,
    (R1 >= R2 ->
        maiorLista(T,H);
        maiorLista(T,L)
    ).


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

% Auxiliares
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
