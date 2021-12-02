:- consult(base_de_conhecimento).
:- consult(invariantes).


%------------------------------------------
evolucao(T) :- findall(I,+T::I,Li),
               add_bc(T),
               teste(Li).

evolucao_troca(TA,TN) :-
    retract(TA),
    evolucao(TN).
        

    

add_bc(T) :- assert(T).
add_bc(T) :- retract(T),!, fail.

%------------------------------------------
involucao(T) :- findall(I,-T::I,Li),
                  remove_bc(T),
                  teste(Li).

remove_bc(T) :- retract(T),!, fail.

teste([]).
teste([I|Is]):-I,teste(Is).