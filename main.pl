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

adiciona_cl(estafeta(A, B, C, D, E, Somatorio/Total, F), Classificacao, estafeta(A, B, C, D, E, NovoSomatorio/NovoTotal, F)) :-
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
