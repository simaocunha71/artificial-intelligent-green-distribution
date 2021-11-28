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
cliente(
    nome,
    id
    )
*/
/*
pedido(
    cliente,
    id do pedido,
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
estafeta("amilcar",735316,"ferreiros",meio_transporte(693147,bicicleta,10,5),317/141,[pedido(cliente(joaquim,41),75341,2021/6/28,"Rua 18","ferreiros",1,2021/6/20,0),pedido(cliente(jo,50),319665,2021/3/14,"Rua 10","ferreiros",1,2021/3/4,1),pedido(cliente(tobias,26),692588,2021/7/9,"Rua 11","ferreiros",5,2021/7/5,0)],0).
estafeta("simao",670371,"lomar",meio_transporte(611484,bicicleta,10,5),387/164,[pedido(cliente(geremias,6),47086,2021/2/19,"Rua 16","lomar",3,2021/2/6,1),pedido(cliente(runlo,31),930176,2021/5/31,"Rua 10","lomar",4,2021/5/28,1),pedido(cliente(geremias,6),837872,2021/8/25,"Rua 1","lomar",3,2021/8/7,0),pedido(cliente(gil,12),794564,2021/2/24,"Rua 10","lomar",3,2021/2/18,0),pedido(cliente(jorge,28),402150,2021/5/23,"Rua 3","lomar",5,2021/5/18,0),pedido(cliente(chico,18),193812,2021/5/17,"Rua 1","lomar",3,2021/5/3,0),pedido(cliente(bruno,39),151359,2021/3/1,"Rua 9","lomar",3,2021/3/1,0),pedido(cliente(amilcar,49),837452,2021/1/15,"Rua 0","lomar",5,2021/1/9,1),pedido(cliente(francisco,46),659762,2021/2/28,"Rua 0","lomar",3,2021/2/22,1),pedido(cliente(goncalo,8),281243,2021/3/27,"Rua 11","lomar",3,2021/3/1,0)],0).
estafeta("palmeira",14305,"cabreiros",meio_transporte(115571,moto,35,20),225/87,[pedido(cliente(ruben,45),976794,2021/10/15,"Rua 1","cabreiros",10,2021/10/12,0),pedido(cliente(tomas,25),381822,2021/10/14,"Rua 4","cabreiros",3,2021/10/10,1),pedido(cliente(patricio,43),724768,2021/12/16,"Rua 10","cabreiros",2,2021/12/10,1)],0).
estafeta("raul",79381,"ruilhe",meio_transporte(744395,carro,25,100),83/43,[pedido(cliente(jo,50),222048,2021/12/23,"Rua 6","ruilhe",7,2021/12/22,0),pedido(cliente(jose,17),345770,2021/3/21,"Rua 18","ruilhe",57,2021/3/14,1),pedido(cliente(ricardo,32),86165,2021/6/28,"Rua 1","ruilhe",4,2021/6/15,1),pedido(cliente(zeferino,37),901822,2021/4/18,"Rua 5","ruilhe",40,2021/4/2,0),pedido(cliente(francisco,46),63393,2021/3/3,"Rua 1","ruilhe",39,2021/3/1,1),pedido(cliente(simao,1),161628,2021/5/24,"Rua 1","ruilhe",85,2021/5/24,0),pedido(cliente(goncalo,8),61172,2021/1/21,"Rua 8","ruilhe",39,2021/1/12,1),pedido(cliente(pedro,9),38501,2021/6/19,"Rua 3","ruilhe",76,2021/6/3,1),pedido(cliente(fabio,11),186691,2021/4/25,"Rua 19","ruilhe",14,2021/4/2,1),pedido(cliente(geremias,6),99058,2021/5/21,"Rua 10","ruilhe",98,2021/5/1,0),pedido(cliente(miguel,14),39822,2021/11/15,"Rua 4","ruilhe",39,2021/11/5,1),pedido(cliente(rui,23),514673,2021/10/13,"Rua 19","ruilhe",85,2021/10/8,0)],0).
estafeta("tina",814885,"semelhe",meio_transporte(23700,carro,25,100),438/171,[pedido(cliente(joaquim,41),947217,2021/7/16,"Rua 13","semelhe",78,2021/7/14,1),pedido(cliente(runlo,31),72870,2021/12/9,"Rua 12","semelhe",75,2021/12/9,1),pedido(cliente(amilcar,49),528424,2021/12/25,"Rua 3","semelhe",83,2021/12/6,1),pedido(cliente(tiago,2),737008,2021/10/8,"Rua 19","semelhe",81,2021/10/7,0),pedido(cliente(tobias,26),240573,2021/8/19,"Rua 3","semelhe",45,2021/8/19,0),pedido(cliente(guilherme,16),762157,2021/8/12,"Rua 11","semelhe",29,2021/8/12,1),pedido(cliente(patricio,43),600391,2021/1/25,"Rua 7","semelhe",53,2021/1/23,0),pedido(cliente(pedro,9),44158,2021/8/18,"Rua 0","semelhe",39,2021/8/10,1),pedido(cliente(ruben,45),248011,2021/11/25,"Rua 3","semelhe",2,2021/11/21,1),pedido(cliente(simao,1),105489,2021/11/26,"Rua 19","semelhe",21,2021/11/18,1),pedido(cliente(raul,27),857761,2021/11/28,"Rua 16","semelhe",100,2021/11/19,0),pedido(cliente(rogerio,15),432772,2021/9/24,"Rua 18","semelhe",90,2021/9/14,0),pedido(cliente(paulo,7),19795,2021/7/23,"Rua 8","semelhe",58,2021/7/6,0),pedido(cliente(joao,3),375344,2021/12/13,"Rua 0","semelhe",66,2021/12/8,0),pedido(cliente(simao,1),955987,2021/9/7,"Rua 1","semelhe",7,2021/9/6,0),pedido(cliente(diogo,24),423674,2021/7/31,"Rua 8","semelhe",99,2021/7/30,1),pedido(cliente(gil,12),637496,2021/10/5,"Rua 15","semelhe",39,2021/10/1,0)],0).

% meio_transporte: tipo, velocidade, peso -> { V, F }
%meio_transporte(417169, carro, 25, 100).


% pedido: cliente,id_do_pedido,valor_da_encomenda,prazo,zona,peso,preco,data,estado -> { V, F }
%pedido(58, 537988, 2021/2/14, "Rua 6", "priscos", 100, 2021/2/11, 1).

/*
estafeta("hugo", 659410, "priscos", meio_transporte(90939, carro, 25, 100), 287/117, 
    [pedido(58, 537988, 2021/2/14, "Rua 6", "priscos", 100, 2021/2/11, 1), 
     pedido(56, 468745, 2021/9/8, "Rua 1", "priscos", 10, 2021/9/2, 0), 
     pedido(93, 600493, 2021/5/10, "Rua 0", "priscos", 29, 2021/5/1, 1), 
     pedido(100, 513280, 2021/7/21, "Rua 1", "priscos", 54, 2021/7/10, 1), 
     pedido(31, 311289, 2021/10/25, "Rua 7", "priscos", 52, 2021/10/9, 0), 
     pedido(26, 659410, 2021/8/26, "Rua 18", "priscos", 22, 2021/8/15, 1), 
     pedido(39, 553811, 2021/8/31, "Rua 17", "priscos", 98, 2021/8/13, 0), 
     pedido(22, 205019, 2021/5/29, "Rua 5", "priscos", 45, 2021/5/15, 1), 
     pedido(46, 736360, 2021/9/14, "Rua 14", "priscos", 80, 2021/9/12, 0), 
     pedido(81, 149877, 2021/8/20, "Rua 13", "priscos", 49, 2021/8/9, 0), 
     pedido(63, 372857, 2021/9/25, "Rua 11", "priscos", 57, 2021/9/3, 1), 
     pedido(42, 637187, 2021/6/21, "Rua 7", "priscos", 50, 2021/6/19, 0)], 
1).

*/