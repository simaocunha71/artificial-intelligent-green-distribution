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

%------Pesquisa gulosa-----
gulosa(_,_,_,_) :- write("Procura não implementada").

%------Pesquisa A*-----
a_estrela(_,_,_,_) :- write("Procura não implementada").