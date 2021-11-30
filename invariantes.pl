% ------------------------ Invariantes------------------------------ %

:- op(900, xfy, '::').
:- ensure_loaded(querys).

%--------------------------- Adição ---------------------------
+estafeta(_,ID,_,_,_,_,_) :: (integer(ID),
                              findall(ID,estafeta(_,ID,_,_,_,_,_),S),
                              length(S,L),
                              L == 1).

+pedido(_,ID,_,_,_,_,_,_) :: (integer(ID),
                              findall(ID,pedido(_,ID,_,_,_,_,_,_),S),
                              length(S,L),
                              L == 1).

+meio_transporte(ID,_,_,_) :: (integer(ID),
                              findall(ID,meio_transporte(ID,_,_,_),S),
                              length(S,L), L == 1).

+meio_transporte(_,T,V,P) :: (is_transporte(T),
                              valida_transporte(T,V,P)).

+cliente(_,ID) :: (integer(ID),
                   findall(ID,cliente(_,ID),S),
                           length(S,L),
                           L == 1).
                        
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
