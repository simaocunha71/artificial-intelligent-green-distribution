% ------------------------ Invariantes------------------------------ %

:- op(900, xfy, '::').
:- ensure_loaded(queries).

%--------------------------- Adição ---------------------------
% estafetas com ids unicos
+estafeta(_,ID,_,_,_,_,_) :: (integer(ID),
                              findall(ID,estafeta(_,ID,_,_,_,_,_),S),
                              length(S,L),
                              L == 1).

% estafetas com peso das encomendas menor ou igual ao peso maximo do seu transporte
+estafeta(_,_,_,meio_transporte(_,_,_,P),_,LE,_) :: (pesoMenores(LE,P)).

% estafetas com transportes únicos
+estafeta(_,_,_,meio_transporte(ID,_,_,_),_,_,_) :: (integer(ID),
                                                      findall(ID,estafeta(_,_,_,meio_transporte(ID,_,_,_),_,_,_),S),
                                                      length(S,L),
                                                      L == 1).
% estafeta so entrega na sua zona associada
+estafeta(_,_,Z,_,_,LE,_) :: (morada(Z,_),
                              dentroZona(LE,Z)).



%--------------------------------------------------------
% pedidos com ids unicos
+pedido(_,ID,_,_,_,_,_,_) :: (integer(ID),
                              findall(ID,pedido(_,ID,_,_,_,_,_,_),S),
                              length(S,L),
                              L == 1).

% pedido associado a uma morada correta
+pedido(_,_,_,Rua,Zona,_,_,_) :: (morada(Zona,Rua)).

% data de entrega tem de ser posterior à data de pedido
+pedido(_,_,DataE,_,_,_,DataP,_) :: (valida_data(DataE),
                                     valida_data(DataP),
                                     data_valor(DataE,VE),
                                     data_valor(DataP,VP),
                                     VE > VP).


+meio_transporte(ID,_,_,_) :: (integer(ID),
                              findall(ID,meio_transporte(ID,_,_,_),S),
                              length(S,L), L == 1).

+meio_transporte(_,T,V,P) :: (transporte(T),
                              velMed(T,V),
                              pesoMax(T,P)
                              ).

+cliente(Nome,ID) :: (integer(ID),
                     findall(X,cliente(X,ID),S),
                     length(S,L),
                     (L == 1;
                     clienteUnico(S,Nome))).
                        
%--------------------------- Remoção ---------------------------
-estafeta(Nome,ID,Z,MT,Cl,LE,Penaliz) :: (findall(estafeta(Nome,ID,Z,MT,Cl,LE,Penaliz),
                                                  estafeta(Nome,ID,Z,MT,Cl,LE,Penaliz),S),
                                          length(S,L),
                                          L > 0).

-pedido(Cl,ID,DataE,R,Z,Pes,DataP,Est) :: (findall(pedido(Cl,ID,DataE,R,Z,Pes,DataP,Est),
                                                   pedido(Cl,ID,DataE,R,Z,Pes,DataP,Est),S),
                                            length(S,L),
                                            L > 0).

-meio_transporte(ID,T,P,V) :: (findall(meio_transporte(ID,T,P,V),
                                       meio_transporte(ID,T,P,V),S),
                                       length(S,L),
                                       L > 0).
