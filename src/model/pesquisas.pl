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
    dfs(Zona,H,"Centro de distribuições",Cam),
    printPath(Cam).

emProfundidade(Zona,[H|T],Cam) :-
    dfs(Zona,"Centro de distribuições",H,Cam),
    printPath(Cam),
    emProfundidadeAux(Zona,T,H,Cam).

emProfundidadeAux(Zona,[H|T],Prev,Cam) :-
    dfs(Zona,Prev,H,Cam),
    printPath(Cam),
    emProfundidadeAux(Zona,T,H,Cam).









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
gulosa(_,_,_,_) :- write("Procura não implementada").

%------Pesquisa A*-----
a_estrela(_,_,_,_) :- write("Procura não implementada").