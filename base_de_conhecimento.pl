% ------------------------ Base de Conhecimento ------------------------------ %
/*
estafeta(
    nome,
    identificacao,
    freguesia,
    meio_transporte,
    soma_classificacoes/classificacoes_totais, 
    lista das entregas,
    penalizacao.
)
*/
/*
meio_transporte(
    matricula,
    tipo,
    velocidade,
    peso
)
*/
/*
pedido(
    cliente, -> NIF
    valor_da_encomenda, 
    prazo, -> data limite
    rua,
    freguesia,
    peso,
    data, -> data do pedido
    estado -> concluido ou nao concluido
)
*/

% estafeta: nome, id, zona, meio_transporte, somatorio_classificacoes/classificacoes_totais, lista das entregas  -> { V, F }
estafeta("goncalo", 959897, "real", meio_transporte(623568, bicicleta, 10, 5), 38/9, [], 0).
estafeta("rafael", 998106, "tadim", meio_transporte(453947, bicicleta, 10, 5), 393/138, [pedido(79, 372201, 2021/11/4, "Rua 18", "tadim", 2, 2021/11/1, 0), pedido(12, 184762, 2021/4/23, "Rua 3", "tadim", 1, 2021/4/21, 0), pedido(58, 930354, 2021/5/8, "Rua 15", "tadim", 5, 2021/5/8, 0)], 1).
estafeta("oscar", 133508, "priscos", meio_transporte(362085, bicicleta, 10, 5), 0/0, [pedido(15, 107791, 2021/9/25, "Rua 18", "priscos", 4, 2021/9/13, 0), pedido(27, 185770, 2021/11/27, "Rua 7", "priscos", 5, 2021/11/25, 0), pedido(94, 150958, 2021/9/7, "Rua 10", "priscos", 5, 2021/9/7, 0), pedido(91, 768295, 2021/2/4, "Rua 14", "priscos", 2, 2021/2/2, 0), pedido(7, 78434, 2021/1/11, "Rua 17", "priscos", 1, 2021/1/6, 1), pedido(27, 202776, 2021/12/7, "Rua 7", "priscos", 3, 2021/12/7, 1), pedido(22, 998845, 2021/5/18, "Rua 18", "priscos", 1, 2021/5/10, 1), pedido(2, 651379, 2021/8/17, "Rua 17", "priscos", 2, 2021/8/5, 0), pedido(3, 357643, 2021/8/25, "Rua 1", "priscos", 5, 2021/8/24, 1)], 0).
estafeta("gil", 440786, "sequeira", meio_transporte(623098, bicicleta, 10, 5), 476/183, [], 1).
estafeta("hugo", 659410, "priscos", meio_transporte(90939, carro, 25, 100), 287/117, [pedido(58, 537988, 2021/2/14, "Rua 6", "priscos", 100, 2021/2/11, 1), pedido(56, 468745, 2021/9/8, "Rua 1", "priscos", 10, 2021/9/2, 0), pedido(93, 600493, 2021/5/10, "Rua 0", "priscos", 29, 2021/5/1, 1), pedido(100, 513280, 2021/7/21, "Rua 1", "priscos", 54, 2021/7/10, 1), pedido(31, 311289, 2021/10/25, "Rua 7", "priscos", 52, 2021/10/9, 0), pedido(26, 659410, 2021/8/26, "Rua 18", "priscos", 22, 2021/8/15, 1), pedido(39, 553811, 2021/8/31, "Rua 17", "priscos", 98, 2021/8/13, 0), pedido(22, 205019, 2021/5/29, "Rua 5", "priscos", 45, 2021/5/15, 1), pedido(46, 736360, 2021/9/14, "Rua 14", "priscos", 80, 2021/9/12, 0), pedido(81, 149877, 2021/8/20, "Rua 13", "priscos", 49, 2021/8/9, 0), pedido(63, 372857, 2021/9/25, "Rua 11", "priscos", 57, 2021/9/3, 1), pedido(42, 637187, 2021/6/21, "Rua 7", "priscos", 50, 2021/6/19, 0)], 1).

% meio_transporte: tipo, velocidade, peso -> { V, F }
%meio_transporte(417169, carro, 25, 100).


% pedido: cliente,id_do_pedido,valor_da_encomenda,prazo,zona,peso,preco,data,estado -> { V, F }
%pedido(58, 537988, 2021/2/14, "Rua 6", "priscos", 100, 2021/2/11, 1).
