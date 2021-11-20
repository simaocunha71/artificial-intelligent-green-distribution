% ------------------------ Base de Conhecimento ------------------------------ %
/*
estafeta(
    nome,
    identificacao,
    zona,
    meio_transporte,
    soma_classificacoes/classificacoes_totais, 
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

% estafeta: nome, id, zona, meio_transporte, somatorio_classificacoes/classificacoes_totais, lista das entregas  -> { V, F }
estafeta(joaquim, 2, famalicao, meio_transporte(moto, 10, 30), 500/100, []).
estafeta(joaquim, 42, famalicao, meio_transporte(moto, 10, 30), 500/100, []).
estafeta(gomes, 40, braga, meio_transporte(bicicleta, 10, 30), 500/100, []).

% meio_transporte: tipo, velocidade, peso -> { V, F }
meio_transporte(moto, 10, 30).
meio_transporte(bicicleta, 10, 30).
meio_transporte(carro, 10, 30).


% pedido: cliente,prazo,zona,peso,preco,data,estado -> { V, F }
pedido(joao, data(12, 10, 2021), famalicao, 2, 10, data(5, 10, 2021), entregue).
pedido(maria, data(12, 10, 2021), porto, 2, 10, data(5, 10, 2021), pendente).
pedido(manuela, data(12, 10, 2021), lisboa, 2, 10, data(5, 10, 2021), cancelado).




