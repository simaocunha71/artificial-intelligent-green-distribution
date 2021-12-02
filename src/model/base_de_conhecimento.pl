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
estafeta("Amilcar",1,"Ferreiros",meio_transporte(1,bicicleta,10,5),317/141,[pedido(cliente("Joaquim",41),1,2021/6/28,"Rua 18","ferreiros",1,2021/6/20,0),
                                                                                      pedido(cliente("Jo",50),2,2021/3/14,"Rua 10","ferreiros",1,2021/3/4,1),
                                                                                      pedido(cliente("Tobias",26),3,2021/7/9,"Rua 11","ferreiros",5,2021/7/5,0)],
                                                                                      0).

estafeta("Simão",2,"Lomar",meio_transporte(2,bicicleta,10,5),387/164,[pedido(cliente("Geremias",6),4,2021/2/19,"Rua 16","Lomar",3,2021/2/6,1),
                                                                                pedido(cliente("Runlo",31),5,2021/5/31,"Rua 10","Lomar",4,2021/5/28,1),
                                                                                pedido(cliente("Geremias",6),6,2021/8/25,"Rua 1","Lomar",3,2021/8/7,0),
                                                                                pedido(cliente("Gil",12),7,2021/2/24,"Rua 10","Lomar",3,2021/2/18,0),
                                                                                pedido(cliente("Jorge",28),8,2021/5/23,"Rua 3","Lomar",5,2021/5/18,0),
                                                                                pedido(cliente("Chico",18),9,2021/5/17,"Rua 1","Lomar",3,2021/5/3,0),
                                                                                pedido(cliente("Bruno",39),10,2021/3/1,"Rua 9","Lomar",3,2021/3/1,0),
                                                                                pedido(cliente("Amilcar",49),11,2021/1/15,"Rua 0","Lomar",5,2021/1/9,1),
                                                                                pedido(cliente("Francisco",46),12,2021/2/28,"Rua 0","Lomar",3,2021/2/22,1),
                                                                                pedido(cliente("Gonçalo",8),13,2021/3/27,"Rua 11","Lomar",3,2021/3/1,0)],
                                                                                0).

estafeta("Palmeira",3,"Cabreiros",meio_transporte(3,moto,35,20),225/87,[pedido(cliente("Rúben",45),14,2021/10/15,"Rua 1","Cabreiros",10,2021/10/12,0),
                                                                                 pedido(cliente("Tomás",25),15,2021/10/14,"Rua 4","Cabreiros",3,2021/10/10,1),
                                                                                 pedido(cliente("Patrício",43),16,2021/12/16,"Rua 10","Cabreiros",2,2021/12/10,1)],
                                                                                 0).

estafeta("Raul",4,"Ruilhe",meio_transporte(4,carro,25,100),83/43,[pedido(cliente("Jo",50),17,2021/12/23,"Rua 6","Ruilhe",7,2021/12/22,0),
                                                                           pedido(cliente("José",17),18,2021/3/21,"Rua 18","Ruilhe",57,2021/3/14,1),
                                                                           pedido(cliente("Ricardo",32),19,2021/6/28,"Rua 1","Ruilhe",4,2021/6/15,1),
                                                                           pedido(cliente("Zeferino",37),20,2021/4/18,"Rua 5","Ruilhe",40,2021/4/2,0),
                                                                           pedido(cliente("Francisco",46),21,2021/3/3,"Rua 1","Ruilhe",39,2021/3/1,1),
                                                                           pedido(cliente("Barbosa",20),22,2021/5/24,"Rua 1","Ruilhe",85,2021/5/24,0),
                                                                           pedido(cliente("Gonçalo",8),23,2021/1/21,"Rua 8","Ruilhe",39,2021/1/12,1),
                                                                           pedido(cliente("Pedro",9),24,2021/6/19,"Rua 3","Ruilhe",76,2021/6/3,1),
                                                                           pedido(cliente("Fábio",11),25,2021/4/25,"Rua 19","Ruilhe",14,2021/4/2,1),
                                                                           pedido(cliente("Duarte",10),26,2021/5/21,"Rua 10","Ruilhe",98,2021/5/1,0),
                                                                           pedido(cliente("Miguel",14),27,2021/11/15,"Rua 4","Ruilhe",39,2021/11/5,1),
                                                                           pedido(cliente("Rui",23),28,2021/10/13,"Rua 19","Ruilhe",85,2021/10/8,0)],
                                                                           0).

estafeta("Tina",5,"Semelhe",meio_transporte(5,carro,25,100),438/171,[pedido(cliente("Joaquim",41),29,2021/7/16,"Rua 13","Semelhe",78,2021/7/14,1),
                                                                              pedido(cliente("Runlo",31),30,2021/12/9,"Rua 12","Semelhe",75,2021/12/9,1),
                                                                              pedido(cliente("Amilcar",49),31,2021/12/25,"Rua 3","Semelhe",83,2021/12/6,1),
                                                                              pedido(cliente("Tiago",2),32,2021/10/8,"Rua 19","Semelhe",81,2021/10/7,0),
                                                                              pedido(cliente("Tobias",26),33,2021/8/19,"Rua 3","Semelhe",45,2021/8/19,0),
                                                                              pedido(cliente("Guilherme",16),34,2021/8/12,"Rua 11","Semelhe",29,2021/8/12,1),
                                                                              pedido(cliente("Patrício",43),35,2021/1/25,"Rua 7","Semelhe",53,2021/1/23,0),
                                                                              pedido(cliente("Pedro",9),36,2021/8/18,"Rua 0","Semelhe",39,2021/8/10,1),
                                                                              pedido(cliente("Rúben",45),37,2021/11/25,"Rua 3","Semelhe",2,2021/11/21,1),
                                                                              pedido(cliente("Simão",1),38,2021/11/26,"Rua 19","Semelhe",21,2021/11/18,1),
                                                                              pedido(cliente("Raul",27),39,2021/11/28,"Rua 16","Semelhe",100,2021/11/19,0),
                                                                              pedido(cliente("Rogério",15),40,2021/9/24,"Rua 18","Semelhe",90,2021/9/14,0),
                                                                              pedido(cliente("Paulo",7),41,2021/7/23,"Rua 8","Semelhe",58,2021/7/6,0),
                                                                              pedido(cliente("João",3),42,2021/12/13,"Rua 0","Semelhe",66,2021/12/8,0),
                                                                              pedido(cliente("Simão",1),43,2021/9/7,"Rua 1","Semelhe",7,2021/9/6,0),
                                                                              pedido(cliente("Diogo",24),44,2021/7/31,"Rua 8","Semelhe",99,2021/7/30,1),
                                                                              pedido(cliente("Gil",12),45,2021/10/5,"Rua 15","Semelhe",39,2021/10/1,0)],
                                                                              0).


transporte(moto).
transporte(bicicleta).
transporte(carro).

velMed(moto, 35).
velMed(bicicleta, 10). 
velMed(carro, 25).

pesoMax(moto, 20).
pesoMax(bicicleta, 5).
pesoMax(carro, 100).


cliente("Simão",1).
cliente("Tiago",2).
cliente("João",3).
%4
%5
cliente("Geremias",6).
cliente("Paulo",7).
cliente("Gonçalo",8).
cliente("Pedro",9).
cliente("Duarte",10).
cliente("Fábio",11).
cliente("Gil",12).
%13
cliente("Miguel",14).
cliente("Rogério",15).
cliente("Guilherme",16).
cliente("José",17).
%18
%19
cliente("Barbosa",20).
%21
%22
cliente("Rui",23).
cliente("Diogo",24).
cliente("Tomás",25).
cliente("Tobias",26).
cliente("Raul",27).
cliente("Jorge",28).
%29
%30
cliente("Runlo",31).
cliente("Ricardo",32).
%33
%34
%35
%36
cliente("Zeferino",37).
%38
cliente("Bruno",39).
%40
cliente("Joaquim",41).
%42
cliente("Patrício",43).
%44
cliente("Rúben",45).
cliente("Francisco",46).
%47
%48
cliente("Amilcar",49).
cliente("Jo",50).






morada("Ruilhe","Rua 1").
morada("Ruilhe","Rua 3").
morada("Ruilhe","Rua 4").
morada("Ruilhe","Rua 5").
morada("Ruilhe","Rua 6").
morada("Ruilhe","Rua 8").
morada("Ruilhe","Rua 10").
morada("Ruilhe","Rua 18").
morada("Ruilhe","Rua 19").


morada("Lomar","Rua 0").
morada("Lomar","Rua 1").
morada("Lomar","Rua 3").
morada("Lomar","Rua 9").
morada("Lomar","Rua 10").
morada("Lomar","Rua 11").
morada("Lomar","Rua 16").

morada("Cabreiros","Rua 1").
morada("Cabreiros","Rua 4").
morada("Cabreiros","Rua 10").

morada("Ferreiros","Rua 10").
morada("Ferreiros","Rua 11").
morada("Ferreiros","Rua 18").

morada("Semelhe","Rua 0").
morada("Semelhe","Rua 1").
morada("Semelhe","Rua 3").
morada("Semelhe","Rua 7").
morada("Semelhe","Rua 8").
morada("Semelhe","Rua 11").
morada("Semelhe","Rua 12").
morada("Semelhe","Rua 13").
morada("Semelhe","Rua 15").
morada("Semelhe","Rua 16").
morada("Semelhe","Rua 18").
morada("Semelhe","Rua 19").



%...

% meio_transporte: tipo, velocidade, peso -> { V, F }
%meio_transporte(417169, carro, 25, 100).


% pedido: cliente,id_do_pedido,valor_da_encomenda,prazo,zona,peso,preco,data,estado -> { V, F }
%pedido(58, 537988, 2021/2/14, "Rua 6",evolucao_backup(estafeta(gerundio,123,Braga,meio_transporte(43, carro, 25, 100),5/1,[],0),estafeta(gerundio,123,Braga,meio_transporte(43, carro, 25, 100),5/1,[pedido(cliente(simao,1),105489,2021/11/26,"Rua 19",Braga,21,2021/11/18,1)],0)). "priscos", 100, 2021/2/11, 1).

/*
estafeta("tina",814885,"semelhe",meio_transporte(23700,carro,25,100),438/171,
[pedido(cliente(joaquim,41),947217,2021/7/16,"Rua 13","semelhe",78,2021/7/14,1),
 pedido(cliente(runlo,31),72870,2021/12/9,"Rua 12","semelhe",75,2021/12/9,1),
 pedido(cliente(amilcar,49),528424,2021/12/25,"Rua 3","semelhe",83,2021/12/6,1),
 pedido(cliente(tiago,2),737008,2021/10/8,"Rua 19","semelhe",81,2021/10/7,0),
 pedido(cliente(tobias,26),240573,2021/8/19,"Rua 3","semelhe",45,2021/8/19,0),
 pedido(cliente(guilherme,16),762157,2021/8/12,"Rua 11","semelhe",29,2021/8/12,1),
 pedido(cliente(patricio,43),600391,2021/1/25,"Rua 7","semelhe",53,2021/1/23,0),
 pedido(cliente(pedro,9),44158,2021/8/18,"Rua 0","semelhe",39,2021/8/10,1),
 pedido(cliente(ruben,45),248011,2021/11/25,"Rua 3","semelhe",2,2021/11/21,1),
 pedido(cliente(simao,1),105489,2021/11/26,"Rua 19","semelhe",21,2021/11/18,1),
 pedido(cliente(raul,27),857761,2021/11/28,"Rua 16","semelhe",100,2021/11/19,0),
 pedido(cliente(rogerio,15),432772,2021/9/24,"Rua 18","semelhe",90,2021/9/14,0),
 pedido(cliente(paulo,7),19795,2021/7/23,"Rua 8","semelhe",58,2021/7/6,0),
 pedido(cliente(joao,3),375344,2021/12/13,"Rua 0","semelhe",66,2021/12/8,0),
 pedido(cliente(simao,1),955987,2021/9/7,"Rua 1","semelhe",7,2021/9/6,0),
 pedido(cliente(diogo,24),423674,2021/7/31,"Rua 8","semelhe",99,2021/7/30,1),
 pedido(cliente(gil,12),637496,2021/10/5,"Rua 15","semelhe",39,2021/10/1,0)],0).


*/