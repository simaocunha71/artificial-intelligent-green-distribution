% ------------------------ Base de Conhecimento ------------------------------ %
/*
estafeta(
    nome,
    identificacao,
    zona,
    meio_transporte,
    classificacao_media, 
    classificacoes_totais, //lista de classificações ou somatório de classificações?
    lista das entregas
)
*/
/*
meio_transporte(
    tipo,
    velocidade,
    peso
)
*/
/*
pedido(
    cliente,
    prazo,
    zona,
    peso,
    preco,
    data,
    estado
)
*/

% estafeta: nome, id, zona, meio_transporte, classificacao_media, classificacoes_totais, lista das entregas  -> { V, F }
estafeta(joaquim,42,famalicao,meio_transporte(moto,10,30),5,500,[]).
estafeta(gomes,40,braga,meio_transporte(bicicleta,10,30),5,500,[]).

% meio_transporte: tipo, velocidade, peso -> { V, F }
meio_transporte(moto,10,30).
meio_transporte(bicicleta,10,30).
meio_transporte(carro,10,30).


% pedido: cliente,prazo,zona,peso,preco,data,estado -> { V, F }
pedido(joao,(12,10,2021),famalicao,2,10,(5,10,2021),entregue).
pedido(maria, (12,10,2021), porto, 2, 10, (5,10,2021), pendente).
pedido(manuela, (12,10,2021), lisboa, 2, 10, (5,10,2021), cancelado).





%------------------------------------------------------------------------------%
%------------------------------- Validaçoes  ----------------------------------%
%------------------------------------------------------------------------------%
% Auxiliares
valida_data((Ano,Mes,Dia)) :- 
    Ano > 0 ,
    Mes > 0 , Mes < 13 ,
    Dia > 0 , Dia < 32.

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

% (1) Estafeta -----------------------------------------------------------------

% (2) Meio de transporte -------------------------------------------------------

% (3) Pedido -------------------------------------------------------------------


%------------------------------------------------------------------------------%
%---------------------------------- Regras  -----------------------------------%
%------------------------------------------------------------------------------%

% (1) Estafeta -----------------------------------------------------------------

% Procura todos os estafetas por -----------------------------------------------

/*... um certo nome */
estafeta_nome(Nome,R) :- findall((Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE),estafeta(Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), R).
/*... um certo id */
estafeta_id(ID,R) :- findall((Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), estafeta(Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), R).
/*... uma certa zona */
estafeta_zona(Zona,R) :- findall((Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), estafeta(Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), R).
/*... um certo tipo de transporte */
estafeta_meioT(MeioT,R) :- findall((Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), estafeta(Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), R).
/*... uma certa classificação média */
estafeta_clMedia(ClMedia,R) :- findall((Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), estafeta(Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), R).
/*... uma certa classificação total (a mudar)*/
estafeta_clTotais(ClTotais,R) :- findall((Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), estafeta(Nome,ID,Zona,MeioT,ClMedia,ClTotais,LE), R).
/*... uma certa lista de entregas */
%cestafeta_LEntrega(LE,R) :- 

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
