:- consult(circuitos).
:- consult('../view/view_menu').

connect(Zona,X,Y):- aresta(Zona,X,Y,_).
connect(Zona,X,Y):- aresta(Zona,Y,X,_).

%------ Predicados auxiliares ---------
% Devolve todos os pontos de entrega de um estafeta
getTodosPontosEntrega(estafeta(_, _, _, _, _, LE, _), R) :-
    extract(LE, [], Aux),
    remove_dups(Aux, R).

extract([], R, R).
extract([pedido(_, _, _, Rua, _, _, _, _)|T], Acc, R) :-
    extract(T, [Rua|Acc], R).

% Remove os elementos duplicados de uma lista
remove_dups([], []).
remove_dups([H|T], R) :-
    member(H, T), !,
    remove_dups(T, R).
remove_dups([H|T], [H|R]) :-
    remove_dups(T, R).


remove_instancias_iguais([],R,R).

remove_instancias_iguais([H|L],XS,NewDest):-
    write("Pontos a retirar : "),writeln([H|L]),
    write("Lista original : "),writeln(XS),
    delete(XS,H,New),
    write("Lista Modificada : "),
    writeln(New),
    remove_instancias_iguais(L,New,NewDest).


%Inverte a lista Xs
inverso(Xs, Ys) :-
    inverso(Xs, [], Ys).
inverso([], Xs, Xs).
inverso([X|Xs], Ys, Zs) :-
    inverso(Xs, [X|Ys], Zs).


%Valor da estima de um vertice
estima(Zona,Nodo,Est) :-
    vertice(Zona,Nodo,X/Y), 
    Est is sqrt(X^2 + Y^2).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).

%-----------------------------------------
% Percorre todos os pontos de entrega do estafeta segundo o algoritmo de pesquisa em profundidade

% Por exemplo, os pontos de entrega são [A,B,C]

% O algoritmo emProfundidade vai fazer o seguinte:

% dfs(Zona,"Centro de distribuiçoes",A,Cam).
% dfs(Zona,A,B,Cam).
% dfs(Zona,B,C,Cam).
% dfs(Zona,C,"Centro de distribuiçoes",Cam).

emProfundidade(Zona,[H],DestinoFinal, Acc,R):-
    dfs(Zona, H, DestinoFinal, L),
    append(Acc, L, R),
    printOnePath(L).


emProfundidade(Zona, [H, X|T],DestinoFinal, Acc, Cam) :-
    dfs(Zona, H, X, L),
    subtract(T,L,Result),
    append([X],Result,NewDest),
    append(Acc, L, NewL),
    printOnePath(L), 
    emProfundidade(Zona, NewDest,DestinoFinal, NewL, Cam).
    
emLargura(Zona,[H],DestinoFinal, Acc,R):-
    bfs(Zona, H, DestinoFinal, L),
    append(Acc, L, R),
    printOnePath(L).


emLargura(Zona, [H, X|T],DestinoFinal, Acc, Cam) :-
    bfs(Zona, H, X, L),
    subtract(T,L,Result),
    append([X],Result,NewDest),
    append(Acc, L, NewL),
    printOnePath(L),
    emLargura(Zona, NewDest,DestinoFinal, NewL, Cam).

embilp(_,_,_,_) :- writeln("Nao implementado").
emgulosa(_,_,_,_) :- writeln("Nao implementado").
em_a_estrela(_,_,_,_) :- writeln("Nao implementado"). 







%------ Pesquisa em profundidade ---------

dfs(Zona, Orig, Dest, Cam) :-
    dfs2(Zona, Orig, Dest, [Orig], Cam). %condicao final: nó actual = destino
dfs2(_,Dest,Dest,LA,Cam):- reverse(LA,Cam). %caminho actual esta invertido
dfs2(Zona, Act, Dest, LA, Cam) :-
    connect(Zona, Act, X), %testar ligacao entre ponto actual e um qualquer X
    \+ member(X, LA), %testar nao circularidade p/evitar nós ja visitados
    dfs2(Zona, X, Dest, [X|LA], Cam). %chamada recursiva

%------ Pesquisa em largura ---------

bfs(Zona, Orig, Dest, Cam) :-
    bfs2(Zona, Dest, [[Orig]], Cam).
bfs2(_,Dest,[[Dest|T]|_],Cam):- reverse([Dest|T],Cam). %o caminho aparece pela ordem inversa
bfs2(Zona, Dest, [LA|Outros], Cam) :-
    LA=[Act|_],
    findall([X|LA],
            ( Dest\==Act,
              connect(Zona, Act, X),
              \+ member(X, LA)
            ),
            Novos),
    append(Outros, Novos, Todos),
    bfs2(Zona, Dest, Todos, Cam).

%------Busca Iterativa Limitada em Profundidade -----
%nao funciona
bilp(Zona, Orig, Dest,Cam) :- 
    bilpAux(Zona, Orig, Dest, 0, Cam).

bilpAux(Zona, Orig, Dest, SizeInicial, Cam) :-
    dfs(Zona, Orig, Dest, Cam),
    length(Cam, S),
    (   S==0
    ->  NewSize is SizeInicial+1,
        bilpAux(Zona, Orig, Dest, NewSize, Cam)
    ).




% https://edisciplinas.usp.br/pluginfile.php/4121068/mod_resource/content/1/ia_6_busca_nao_informada_parte1.pdf

%Não funcional

%------Pesquisa gulosa-----
%Tirado das fichas. A Pesquisa gulosa (greedy algorithm) escolhe sempre o próximo nodo que oferece o melhor benificio no imediato

resolve_gulosa(Zona,Nodo,CaminhoDistancia/CustoDist) :-
    estima(Zona,Nodo, EstimaD),
    agulosa_distancia_g(Zona,[[Nodo]/0/EstimaD], InvCaminho/CustoDist/_),
    inverso(InvCaminho, CaminhoDistancia).

agulosa_distancia_g(Zona,Caminhos, Caminho) :-
    obtem_melhor_distancia_g(Caminhos, Caminho),
    Caminho = [Nodo|_]/_/_,
    aresta(Zona,_,Nodo,_).
    

agulosa_distancia_g(Zona,Caminhos, SolucaoCaminho) :-
    obtem_melhor_distancia_g(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expande_agulosa_distancia_g(Zona,MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
        agulosa_distancia_g(Zona,NovoCaminhos, SolucaoCaminho).  

obtem_melhor_distancia_g([Caminho], Caminho) :- !.
obtem_melhor_distancia_g([Caminho1/Custo1/Est1,_/_/Est2|Caminhos], MelhorCaminho) :-
    Est1 =< Est2, !,
    obtem_melhor_distancia_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho). 
obtem_melhor_distancia_g([_|Caminhos], MelhorCaminho) :- 
    obtem_melhor_distancia_g(Caminhos, MelhorCaminho).
    

expande_agulosa_distancia_g(Zona,Caminho, ExpCaminhos) :-
    findall(NovoCaminho, adjacente_distancia(Zona,Caminho,NovoCaminho), ExpCaminhos).
    


adjacente_distancia(Zona,[Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/EstDist) :-
    aresta(Zona,Nodo, ProxNodo, PassoCustoDist),
    NovoCusto is Custo + PassoCustoDist,
    estima(Zona,ProxNodo, EstDist).



%------Pesquisa A*-----

%Não adaptada ao nosso problema

%Tirado das fichas

%Valor da estima de um vertice

estimaEstrela(X1/Y1,X2/Y2,Est) :- 
    Aux is (X2 - X1)^2,
    Aux2 is (Y2 - Y1)^2,
    Aux3 is Aux+Aux2,
    Est is sqrt(Aux3).


%em_a_estrela("Ferreiros",["Centro de distribuições","Rua 11","Rua 10","Rua 18"],"Centro de distribuições",[]/0,R/CR).

em_a_estrela(Zona,[H],DestinoFinal,Acc/CustoAcc,R/CR):-
    resolve_aestrela(Zona,H,DestinoFinal,Caminho/Custo),
    printOnePath(Caminho),
    append(Acc,Caminho,R),
    CR is CustoAcc + Custo.

em_a_estrela(Zona,[H,X|T],DestinoFinal,Acc/CustoAcc,R/CR):-
    resolve_aestrela(Zona,H,X,Caminho/Custo),
    subtract(T,Caminho,NovoDestinos),
    printOnePath(Caminho),
    append(Acc,Caminho,NovoAcc),
    NovoCusto is CustoAcc + Custo,
    em_a_estrela(Zona,[X|NovoDestinos],DestinoFinal,NovoAcc/NovoCusto,R/CR).
 
%resolve_aestrela("Ferreiros","Centro de distribuições","Rua 11",R/CR). 

resolve_aestrela(Zona,Origem,Destino,CaminhoDistancia/CustoDist) :-
    vertice(Zona,Origem,X),
    vertice(Zona,Destino,Y),
    estimaEstrela(X, Y,Est),
    aestrela_distancia([[Origem]/0/Est],Destino, InvCaminho/CustoDist/_,Y),
    inverso(InvCaminho, CaminhoDistancia).


aestrela_distancia(Caminhos,Destino, Caminho,CoordenadasDestino) :-
    obtem_melhor_distancia(Caminhos, Caminho),
    Caminho = [Destino|_]/_/_.

aestrela_distancia(Caminhos,Destino, SolucaoCaminho,CoordenadasDestino) :-
    obtem_melhor_distancia(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expande_aestrela_distancia(Zona,MelhorCaminho, ExpCaminhos,CoordenadasDestino),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
        aestrela_distancia(NovoCaminhos,Destino, SolucaoCaminho,CoordenadasDestino).   

obtem_melhor_distancia([Caminho], Caminho) :- !.
obtem_melhor_distancia([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
    Custo1 + Est1 =< Custo2 + Est2, !,
    obtem_melhor_distancia([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho). 
obtem_melhor_distancia([_|Caminhos], MelhorCaminho) :- 
    obtem_melhor_distancia(Caminhos, MelhorCaminho).
    

expande_aestrela_distancia(Zona,Caminho, ExpCaminhos,CoordenadasDestino) :-
    findall(NovoCaminho, adjacente_distancia_estrela(Zona,Caminho,NovoCaminho,CoordenadasDestino), ExpCaminhos).
    

adjacente_distancia_estrela(Zona,[Nodo|Caminho]/Custo/_, [ProxNodo,Nodo|Caminho]/NovoCusto/EstDist,CoordenadasDestino) :-
    connect(Zona,Nodo,ProxNodo,PassoCustoDist),
    \+ member(ProxNodo,Caminho),
    NovoCusto is Custo + PassoCustoDist,
    vertice(Zona,ProxNodo,X),
    estimaEstrela(X,CoordenadasDestino,EstDist).


connect(Zona,X,Y,C):- aresta(Zona,X,Y,C).
connect(Zona,X,Y,C):- aresta(Zona,Y,X,C).