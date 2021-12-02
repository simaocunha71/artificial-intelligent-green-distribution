:- consult(base_de_conhecimento).
:- consult(invariantes).

:- (dynamic estafeta/7). 
:- (dynamic meio_transporte/4). 
:- (dynamic pedido/8). 
adiciona_classificacao(estafeta(A, B, C, D, E, Somatorio/Total, F), Classificacao, estafeta(A, B, C, D, E, NovoSomatorio/NovoTotal, F)) :-
    NovoSomatorio is Somatorio+Classificacao,
    NovoTotal is Total+1.
%------------------------------------------
evolucao(T) :- findall(I,+T::I,Li),
               add_bc(T),
               teste(Li).

evolucao_backup(TA,TN) :-
    retract(TA),
    findall(I,+TN::I,Li),
    add_bc(TN),
    teste(Li).
        

    

add_bc(T) :- assert(T).
add_bc(T) :- retract(T),!, fail.

%------------------------------------------
involucao(T) :- findall(I,-T::I,Li),
                  remove_bc(T),
                  teste(Li).

remove_bc(T) :- retract(T),!, fail.

teste([]).
teste([I|Is]):-I,teste(Is).