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
    tempo de entrega,
    data, -> data do pedido
    estado -> concluido ou nao concluido
)
*/

% estafeta: nome, id, zona, meio_transporte, somatorio_classificacoes/classificacoes_totais, lista das entregas  -> { V, F }
%estafeta("alberto", 380416, "lomar", meio_transporte(248239, bicicleta, 10, 5), 154/64, [pedido(315609, 2021/8/15, "Rua 12", "lomar", 4, 2021/8/1, 1), pedido(185309, 2021/6/18, "Rua 2", "lomar", 1, 2021/6/1, 0), pedido(767595, 2021/11/9, "Rua 15", "lomar", 3, 2021/11/1, 1), pedido(460367, 2021/10/16, "Rua 5", "lomar", 4, 2021/10/1, 1), pedido(405316, 2021/1/23, "Rua 7", "lomar", 3, 2021/1/1, 0), pedido(131005, 2021/10/8, "Rua 18", "lomar", 4, 2021/10/1, 1), pedido(996271, 2021/11/23, "Rua 0", "lomar", 1, 2021/11/1, 1), pedido(805019, 2021/2/16, "Rua 13", "lomar", 4, 2021/2/1, 1), pedido(861618, 2021/7/11, "Rua 0", "lomar", 3, 2021/7/1, 1), pedido(187900, 2021/8/9, "Rua 10", "lomar", 3, 2021/8/1, 0), pedido(200425, 2021/9/21, "Rua 16", "lomar", 1, 2021/9/1, 1), pedido(152155, 2021/12/23, "Rua 11", "lomar", 5, 2021/12/1, 0), pedido(115827, 2021/8/23, "Rua 15", "lomar", 5, 2021/8/1, 1), pedido(866135, 2021/1/23, "Rua 17", "lomar", 4, 2021/1/1, 1), pedido(605068, 2021/6/1, "Rua 9", "lomar", 3, 2021/6/1, 1), pedido(506538, 2021/11/3, "Rua 7", "lomar", 2, 2021/11/1, 0), pedido(52866, 2021/5/18, "Rua 3", "lomar", 2, 2021/5/1, 1)], 1).
%estafeta("geremias", 44906, "pedralva", meio_transporte(490913, bicicleta, 10, 5), 289/121, [pedido(140195, 2021/9/28, "Rua 4", "pedralva", 4, 2021/9/1, 1), pedido(127721, 2021/5/30, "Rua 12", "pedralva", 3, 2021/5/1, 0), pedido(158678, 2021/12/16, "Rua 1", "pedralva", 1, 2021/12/1, 0), pedido(295026, 2021/1/14, "Rua 13", "pedralva", 1, 2021/1/1, 1), pedido(73580, 2021/11/9, "Rua 10", "pedralva", 2, 2021/11/1, 1)], 0).
%estafeta("pato", 432093, "figueiredo", meio_transporte(379413, bicicleta, 10, 5), 51/23, [pedido(288091, 2021/10/3, "Rua 18", "figueiredo", 2, 2021/10/1, 0), pedido(924093, 2021/4/13, "Rua 19", "figueiredo", 4, 2021/4/1, 1), pedido(833290, 2021/8/20, "Rua 16", "figueiredo", 1, 2021/8/1, 0), pedido(200729, 2021/4/16, "Rua 0", "figueiredo", 1, 2021/4/1, 0), pedido(553554, 2021/1/9, "Rua 2", "figueiredo", 5, 2021/1/1, 1), pedido(834403, 2021/7/23, "Rua 0", "figueiredo", 3, 2021/7/1, 0), pedido(568190, 2021/12/21, "Rua 12", "figueiredo", 4, 2021/12/1, 0), pedido(780861, 2021/12/5, "Rua 8", "figueiredo", 3, 2021/12/1, 0), pedido(41243, 2021/5/25, "Rua 10", "figueiredo", 3, 2021/5/1, 0), pedido(226182, 2021/9/13, "Rua 2", "figueiredo", 2, 2021/9/1, 0), pedido(832501, 2021/6/16, "Rua 12", "figueiredo", 1, 2021/6/1, 1), pedido(105172, 2021/5/6, "Rua 15", "figueiredo", 5, 2021/5/1, 1), pedido(746680, 2021/1/4, "Rua 14", "figueiredo", 1, 2021/1/1, 1), pedido(96258, 2021/8/15, "Rua 8", "figueiredo", 5, 2021/8/1, 1), pedido(308488, 2021/9/23, "Rua 9", "figueiredo", 5, 2021/9/1, 1), pedido(744469, 2021/11/9, "Rua 0", "figueiredo", 5, 2021/11/1, 1)], 1).
estafeta("joaquim", 938283, "lamas", meio_transporte(417169, carro, 25, 100), 33/15, [pedido(146065, 2021/3/4, "Rua 11", "lamas", 73, 2021/3/1, 1), pedido(3858, 2021/4/17, "Rua 10", "lamas", 42, 2021/4/1, 0), pedido(457710, 2021/10/10, "Rua 0", "lamas", 24, 2021/10/1, 1), pedido(321960, 2021/4/12, "Rua 8", "lamas", 97, 2021/4/1, 1), pedido(339500, 2021/7/14, "Rua 5", "lamas", 3, 2021/7/1, 1), pedido(408132, 2021/7/18, "Rua 2", "lamas", 46, 2021/7/1, 1), pedido(7725, 2021/9/14, "Rua 0", "lamas", 92, 2021/9/1, 1), pedido(427064, 2021/6/28, "Rua 17", "lamas", 66, 2021/6/1, 1), pedido(745235, 2021/2/23, "Rua 2", "lamas", 23, 2021/2/1, 0), pedido(281199, 2021/4/16, "Rua 0", "lamas", 11, 2021/4/1, 0), pedido(814554, 2021/3/18, "Rua 7", "lamas", 4, 2021/3/1, 0), pedido(315704, 2021/5/6, "Rua 7", "lamas", 10, 2021/5/1, 0), pedido(496065, 2021/10/1, "Rua 16", "lamas", 30, 2021/10/1, 1), pedido(711540, 2021/6/30, "Rua 2", "lamas", 87, 2021/6/1, 0), pedido(688685, 2021/11/22, "Rua 13", "lamas", 77, 2021/11/1, 0)], 0).
estafeta("costa", 955839, "figueiredo", meio_transporte(524595, moto, 35, 20), 255/101, [pedido(52220, 2021/5/1, "Rua 0", "figueiredo", 18, 2021/5/1, 0), pedido(522111, 2021/10/20, "Rua 10", "figueiredo", 7, 2021/10/1, 0), pedido(240806, 2021/12/19, "Rua 9", "figueiredo", 6, 2021/12/1, 1), pedido(3335, 2021/1/27, "Rua 2", "figueiredo", 13, 2021/1/1, 0), pedido(176855, 2021/7/10, "Rua 12", "figueiredo", 14, 2021/7/1, 1), pedido(220545, 2021/11/20, "Rua 3", "figueiredo", 20, 2021/11/1, 0), pedido(195453, 2021/6/9, "Rua 4", "figueiredo", 17, 2021/6/1, 0), pedido(739422, 2021/7/15, "Rua 14", "figueiredo", 5, 2021/7/1, 0), pedido(611340, 2021/6/2, "Rua 0", "figueiredo", 16, 2021/6/1, 0), pedido(863797, 2021/11/28, "Rua 14", "figueiredo", 17, 2021/11/1, 0), pedido(496334, 2021/3/19, "Rua 0", "figueiredo", 15, 2021/3/1, 1), pedido(182671, 2021/1/28, "Rua 5", "figueiredo", 7, 2021/1/1, 0), pedido(569356, 2021/6/20, "Rua 12", "figueiredo", 6, 2021/6/1, 1), pedido(59409, 2021/9/5, "Rua 8", "figueiredo", 10, 2021/9/1, 1), pedido(639397, 2021/1/28, "Rua 16", "figueiredo", 10, 2021/1/1, 0), pedido(120532, 2021/5/12, "Rua 4", "figueiredo", 12, 2021/5/1, 0), pedido(343981, 2021/3/8, "Rua 9", "figueiredo", 13, 2021/3/1, 1)], 1).
estafeta("manafa", 892707, "figueiredo", meio_transporte(490038, carro, 25, 100), 62/24, [], 1).

% meio_transporte: tipo, velocidade, peso -> { V, F }
meio_transporte(417169, carro, 25, 100).
meio_transporte(248239, bicicleta, 10, 5).
meio_transporte(490038, carro, 25, 100).


% pedido: cliente,valor_da_encomenda,prazo,zona,peso,preco,data,estado -> { V, F }
%pedido(140195, 2021/9/28, "Rua 4", "pedralva", 4, 2021/9/1, 1), pedido(127721, 2021/5/30, "Rua 12", "pedralva", 3, 2021/5/1, 0).
