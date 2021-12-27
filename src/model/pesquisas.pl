:- consult(circuitos).
:- consult(src/view/view_menu).


connect(Zona,X,Y):- aresta(Zona,X,Y,_).
connect(Zona,X,Y):- aresta(Zona,Y,X,_).

% Devolve todos os pontos de entrega de um estafeta
getTodosPontosEntrega(estafeta(_, _, _, _, _, LE, _), R) :-
    extract(LE, [], R).

extract([], R, R).
extract([pedido(_, _, _, Rua, _, _, _, _)|T], Acc, R) :-
    extract(T, [Rua|Acc], R).



emProfundidade(_,[],_).

emProfundidade(Zona,[H],Cam):-
    dfs(Zona,H,"Centro de distribuições",Cam).

emProfundidade(Zona,[H|T],Cam) :-
    emProfundidadeAux(Zona,[H|T],"Centro de distribuições",Cam).

%ver se é preciso retirar o ultimo elemento da lista H|T
emProfundidadeAux(Zona,[H|T],Prev,Cam) :-
    dfs(Zona,Prev,H,Cam),
    emProfundidadeAux(Zona,T,H,Cam).

emLargura(_,_,_) :- writeln("Nao implementado").
embilp(_,_,_) :- writeln("Nao implementado").
emgulosa(_,_,_) :- writeln("Nao implementado").
em_a_estrela(_,_,_) :- writeln("Nao implementado"). 







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

%------Pesquisa gulosa-----
%Tirado das fichas. A Pesquisa gulosa (greedy algorithm) escolhe sempre o próximo nodo que oferece o melhor benificio no imediato
resolvegulosa(Nodo,Caminho/Custo):-
    estima(Nodo,Estima),
    agulosa([[Nodo]/0/Estima],InvCaminho/Custo/),
    inverso(InvCaminho,Caminho).

agulosa(Caminhos,Caminho):-
    obtem_melhorg(Caminhos,Caminho),
    Caminho = [Nodo|]//,goal(Nodo).

agulosa(Caminhos,SolucaoCaminho):-
    obtem_melhor_g(Caminhos,MelhorCaminho),
    seleciona(MelhorCaminho,Caminhos,OutrosCaminhos),
    expande_gulosa(MelhorCaminho,ExpCaminhos),
    append(OutrosCaminhos,ExpCaminhos,NovoCaminhos),
    agulosa(NovoCaminhos,SolucaoCaminho).

obtem_melhor_g([Caminho],Caminho):-!.

obtem_melhorg([Caminho1/Custo1/Est1,/Custo2/Est2|Caminhos],MelhorCaminho):-
    Est1=<Est2,
    !,
    obtem_melhor_g([Caminho1/Custo1/Est1|Caminhos],MelhorCaminho).

obtem_melhorg([|Caminhos],MelhorCaminho):-
    obtem_melhor_g(Caminhos,MelhorCaminho).

expandegulosa(Caminho,ExpCaminhos):-
    findall(NovoCaminho,adjacente2(Caminho,NovoCaminho),ExpCaminhos).

inverso(XS,Ys):-
    inverso(Xs,[],Ys).

inverso([],Xs,Ys).
inverso([X|Xs],Ys,Zs):-
    inverso(Xs,[X|Ys],Zs).


seleciona(E,[E|Xs],Xs).
seleciona(E,[X|Xs],[X|Ys]):-seleciona(E,Xs,Ys).



adjacente2([Nodo|Caminho]/Custo/,[ProxNodo,Nodo|Caminho]/NovoCusto/Est):-
    arco(Nodo,ProxNodo,PassoCusto),
    + member(ProxNodo,Caminho),
    NovoCusto is Custo + PassoCusto,
    estima(ProxNodo,Est).


%------Pesquisa A*-----
%Tirado das fichas
a_estrela(_,_,_,_) :- write("Procura não implementada").
resolve_aestrela(Nodo,CaminhoDistancia/CustoDist, CaminhoTempo/CustoTempo) :-
	estima(Nodo, EstimaD, EstimaT),
	aestrela_distancia([[Nodo]/0/EstimaD], InvCaminho/CustoDist/_),
	aestrela_tempo([[Nodo]/0/EstimaT], InvCaminhoTempo/CustoTempo/_),
	inverso(InvCaminho, CaminhoDistancia),
	inverso(InvCaminhoTempo, CaminhoTempo).

aestrela_distancia(Caminhos, Caminho) :-
	obtem_melhor_distancia(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,goal(Nodo).

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