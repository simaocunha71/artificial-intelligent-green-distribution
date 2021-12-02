:- consult(base_de_conhecimento).
:- consult(invariantes).

% (1) Estafeta -----------------------------------------------------------------

% Procura todos os estafetas por -----------------------------------------------

/*... um certo nome */
estafeta_nome(Nome,R) :- findall(estafeta(Nome,ID,Z,MT,Cl,LE,P),
                                 estafeta(Nome,ID,Z,MT,Cl,LE,P), R).
/*... um certo id */
estafeta_id(ID,R) :- findall(estafeta(N,ID,Z,MT,Cl,LE,P),
                             estafeta(N,ID,Z,MT,Cl,LE,P), R).
/*... uma certa zona */
estafeta_zona(Zona,R) :- findall(estafeta(N,ID,Zona,MT,Cl,LE,P),
                                 estafeta(N,ID,Zona,MT,Cl,LE,P), R).
/*... um certo tipo de transporte */
estafeta_meioT(TipoMT,R) :- findall(estafeta(N,ID,Z,meio_transporte(Matr,TipoMT,V,Peso),Cl,LE,P),
                                    estafeta(N,ID,Z,meio_transporte(Matr,TipoMT,V,Peso),Cl,LE,P), R).
/*... um somatorio de classificacoes*/
estafeta_sumClassf(SumClassf,R) :- findall(estafeta(N,ID,Z,MT,SumClassf/ClTotais,LE,P),
                                           estafeta(N,ID,Z,MT,SumClassf/ClTotais,LE,P), R).
/*... uma certa numero de classificacoes*/
estafeta_clTotais(ClTotais,R) :- findall(estafeta(N,ID,Z,MT,SumClassf/ClTotais,LE,P),
                                         estafeta(N,ID,Z,MT,SumClassf/ClTotais,LE,P), R).
/*... uma certa lista de entregas */
estafeta_LEntrega(LE,R) :- findall(estafeta(Nome,ID,Z,MT,Cl,LE,P),
                                   estafeta(Nome,ID,Z,MT,Cl,LE,P), R).
/*... um certo tipo de penalização */
estafeta_Penaliz(Penaliz,R) :- findall(estafeta(Nome,ID,Z,MT,Cl,LE,Penaliz),
                                       estafeta(Nome,ID,Z,MT,Cl,LE,Penaliz), R).

% (2) Meio de transporte -------------------------------------------------------

% Procura todos os meios de transporte por -------------------------------------
/*... uma certa matricula */
meioTransporte_matricula(Matr,R) :- findall(meio_transporte(Matr,Tipo,V,Peso),
                                            estafeta(_,_,_,meio_transporte(Matr,Tipo,V,Peso),_,_,_), R).
/*... um certo tipo */
meioTransporte_tipo(Tipo,R) :- findall(meio_transporte(Matr,Tipo,V,Peso),
                                            estafeta(_,_,_,meio_transporte(Matr,Tipo,V,Peso),_,_,_), R).
/*... uma certa velocidade */
meioTransporte_vel(V,R) :- findall(meio_transporte(Matr,Tipo,V,Peso),
                                            estafeta(_,_,_,meio_transporte(Matr,Tipo,V,Peso),_,_,_), R).
/*... um certo peso */
meioTransporte_peso(Peso,R) :- findall(meio_transporte(Matr,Tipo,V,Peso),
                                            estafeta(_,_,_,meio_transporte(Matr,Tipo,V,Peso),_,_,_), R).

% (3) Pedido -------------------------------------------------------------------

% Procura todos os pedidos por -------------------------------------------------

pedido_id(ID,R) :- findall(LE, 
                            estafeta(_,_,_,_,_,LE,_), LAux),
                    filter_by_ID(ID,LAux,[],R).

pedido_cliente(ID_Cli,R) :- findall(LE, 
                                    estafeta(_,_,_,_,_,LE,_), LAux),
                            filter_by_IDC(ID_Cli,LAux,[],R).
/*... prazo */
pedido_prazo(Prazo,R) :- findall(LE, 
                                estafeta(_,_,_,_,_,LE,_), LAux),
                         filter_by_Prazo(Prazo,LAux,[],R).

pedido_rua(Rua,R) :- findall(LE, 
                                estafeta(_,_,_,_,_,LE,_), LAux),
                         filter_by_Rua(Rua,LAux,[],R).

pedido_zona(Zona,R) :- findall(LE, 
                                estafeta(_,_,_,_,_,LE,_), LAux),
                         filter_by_Zona(Zona,LAux,[],R).
/*... peso */
pedido_peso(Peso,R) :- findall(LE, 
                                estafeta(_,_,_,_,_,LE,_), LAux),
                         filter_by_Peso(Peso,LAux,[],R).
/*... data */
pedido_data(Data,R) :- findall(LE, 
                                estafeta(_,_,_,_,_,LE,_), LAux),
                         filter_by_DataPed(Data,LAux,[],R).
/*... estado */
pedido_estado(Estado,R) :- findall(LE, 
                                estafeta(_,_,_,_,_,LE,_), LAux),
                         filter_by_Estado(Estado,LAux,[],R).