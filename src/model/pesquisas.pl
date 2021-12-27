:- consult(circuitos).
:- consult(src/view/view_menu).

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

%Inverte a lista Xs
inverso(Xs, Ys) :-
    inverso(Xs, [], Ys).
inverso([], Xs, Xs).
inverso([X|Xs], Ys, Zs) :-
    inverso(Xs, [X|Ys], Zs).


%Valor da estima de um vertice
estima(vertice(_,_,X/Y),Est) :- 
    Aux is X^2,
    Aux2 is Y^2,
    Aux3 is Aux+Aux2,
    Est is sqrt(Aux3).

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

emProfundidade(_, [_], R,R).

emProfundidade(Zona, [H, X|T], Acc, Cam) :-
    dfs(Zona, H, X, L),
    append(Acc, L, NewL),
    printOnePath(L), 
    emProfundidade(Zona, [X|T], NewL, Cam).
    
emLargura(_, [_], R, R).
emLargura(Zona, [H, X|T], Acc, Cam) :-
    bfs(Zona, H, X, L),
    append(Acc, L, NewL),
    printOnePath(L),
    emLargura(Zona, [X|T], NewL, Cam).

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
bilp(_,_,_,_):- write("Procura não implementada").

% https://edisciplinas.usp.br/pluginfile.php/4121068/mod_resource/content/1/ia_6_busca_nao_informada_parte1.pdf

%Não funcional

%------Pesquisa gulosa-----
%Tirado das fichas. A Pesquisa gulosa (greedy algorithm) escolhe sempre o próximo nodo que oferece o melhor benificio no imediato
resolve_gulosa(Zona, NodoInicial, NodoFinal, Caminho/Custo) :-
    V = vertice(Zona,NodoInicial,_), % encontrar o vertice com a zona e o nodo inicial que quero
    estima(V, Estima),
    agulosa(Zona, NodoInicial, NodoFinal, [[NodoInicial]/0/Estima], InvCaminho/Custo/_),
    inverso(InvCaminho, Caminho).

agulosa(Zona, NodoInicial, NodoFinal,Caminhos, Caminho) :-
    obtem_melhor_g(Zona, Caminhos, Caminho),
    Caminho=[NodoInicial|_]/_/_,
    aresta(Zona,_,NodoFinal,_).

agulosa(Zona, Caminhos, SolucaoCaminho) :-
    obtem_melhor_g(Caminhos, MelhorCaminho),
    seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
    expande_gulosa(Zona, MelhorCaminho, ExpCaminhos),
    append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    agulosa(Zona, NovoCaminhos, SolucaoCaminho).		

obtem_melhor_g([Caminho], Caminho) :- !.

obtem_melhor_g([Caminho1/Custo1/Est1,_/_/Est2|Caminhos], MelhorCaminho) :-
	Est1 =< Est2, !,
	obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho).
	
obtem_melhor_g(Zona, [_|Caminhos], MelhorCaminho) :- 
	obtem_melhor_g(Zona, Caminhos, MelhorCaminho).

expande_gulosa(Zona, Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente2(Zona,Caminho,NovoCaminho), ExpCaminhos).	

adjacente2(Zona, [NodoInicial|Caminho]/Custo/_, [ProxNodoInicial,NodoInicial|Caminho]/NovoCusto/Est) :-
	aresta(Zona,NodoInicial, ProxNodoInicial, PassoCusto),
	\+member(ProxNodoInicial, Caminho),
	NovoCusto is Custo + PassoCusto,
	estima(ProxNodoInicial, Est).


%------Pesquisa A*-----

%Não adaptada ao nosso problema

%Tirado das fichas
a_estrela(NodoInicial,CaminhoDistancia/CustoDist, CaminhoTempo/CustoTempo) :-
	estima(NodoInicial, EstimaD, EstimaT),
	aestrela_distancia([[NodoInicial]/0/EstimaD], InvCaminho/CustoDist/_),
	aestrela_tempo([[NodoInicial]/0/EstimaT], InvCaminhoTempo/CustoTempo/_),
	inverso(InvCaminho, CaminhoDistancia),
	inverso(InvCaminhoTempo, CaminhoTempo).

aestrela_distancia(Caminhos, Caminho) :-
	obtem_melhor_distancia(Caminhos, Caminho),
	Caminho = [NodoInicial|_]/_/_,goal(NodoInicial).

aestrela_distancia(Caminhos, SolucaoCaminho) :-
	obtem_melhor_distancia(Caminhos, MelhorCaminho),
	seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
	expande_aestrela_distancia(MelhorCaminho, ExpCaminhos),
	append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
        aestrela_distancia(NovoCaminhos, SolucaoCaminho).	

obtem_melhor_distancia([Caminho], Caminho) :- !.
obtem_melhor_distancia([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2, !,
	obtem_melhor_distancia([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho). 
obtem_melhor_distancia([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor_distancia(Caminhos, MelhorCaminho).
	

expande_aestrela_distancia(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente_distancia(Caminho,NovoCaminho), ExpCaminhos).