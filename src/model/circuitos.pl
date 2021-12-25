:- (discontiguous aresta/4).
:- (discontiguous vertice/3).
% ------------------------ Circuitos ------------------------------ %

% ------------------------ Ruilhe ------------------------------ %
aresta("Ruilhe","Rua 1", "Rua 8", 15).
aresta("Ruilhe","Rua 1","Rua 18",14).

aresta("Ruilhe","Rua 8","Rua 10",5).
aresta("Ruilhe","Rua 8","Rua 3" ,14).
aresta("Ruilhe","Rua 8","Rua 5" ,10).
aresta("Ruilhe","Rua 8","Rua 6" ,14).

aresta("Ruilhe","Rua 3","Rua 4" ,1).
aresta("Ruilhe","Rua 3", "Rua 6", 8).

aresta("Ruilhe","Rua 4","Rua 19",18).

aresta("Ruilhe","Rua 5","Rua 10",6).
aresta("Ruilhe","Rua 5","Rua 6" ,14).

aresta("Ruilhe","Rua 18","Rua 19",15).
aresta("Ruilhe","Rua 18","Rua 6", 7).

vertice("Ruilhe", "Rua 1", 3/10).
vertice("Ruilhe", "Rua 3", 1/9).
vertice("Ruilhe", "Rua 4", 3/8).
vertice("Ruilhe", "Rua 5", 5/8).
vertice("Ruilhe", "Rua 6", 4/1).
vertice("Ruilhe", "Rua 8", 4/8).
vertice("Ruilhe", "Rua 10", 6/8).
vertice("Ruilhe", "Rua 18", 9/9).
vertice("Ruilhe", "Rua 19", 7/2).


% ------------------------ Lomar ------------------------------ %
aresta("Lomar","Rua 0", "Rua 11", 19).
aresta("Lomar","Rua 0","Rua 10", 14).
aresta("Lomar","Rua 0", "Rua 3", 1).
aresta("Lomar","Rua 0","Rua 16", 16).

aresta("Lomar","Rua 1", "Rua 9", 16).
aresta("Lomar","Rua 1", "Rua 10", 4).
aresta("Lomar","Rua 1", "Rua 11", 11).

aresta("Lomar","Rua 3","Rua 16", 6).

aresta("Lomar","Rua 9", "Rua 10", 7).
aresta("Lomar","Rua 9", "Rua 11", 10).
aresta("Lomar","Rua 9", "Rua 3", 15).

vertice("Lomar","Rua 0", 1/5).
vertice("Lomar","Rua 1", 5/7).
vertice("Lomar","Rua 3", 2/2).
vertice("Lomar","Rua 9", 10/6).
vertice("Lomar","Rua 10", 9/1).
vertice("Lomar","Rua 11", 12/2).
vertice("Lomar","Rua 16", 4/6).

% ------------------------ Cabreiros ------------------------------ %
aresta("Cabreiros","Rua 1", "Rua 4", 3).
aresta("Cabreiros","Rua 1", "Rua 10",4).
aresta("Cabreiros","Rua 4", "Rua 10",2).

vertice("Cabreiros","Rua 1", 2/3).
vertice("Cabreiros","Rua 4", 4/7).
vertice("Cabreiros","Rua 10", 6/2).

% ------------------------ Ferreiros ------------------------------ %
aresta("Ferreiros","Rua 10", "Rua 11", 7).
aresta("Ferreiros","Rua 10", "Rua 18", 6).
aresta("Ferreiros","Rua 11", "Rua 18", 2).

vertice("Ferreiros","Rua 10", 3/3).
vertice("Ferreiros","Rua 11", 6/4).
vertice("Ferreiros","Rua 18", 4/1).

% ------------------------ Semelhe ------------------------------ %
aresta("Semelhe","Rua 1", "Rua 0", 2).
aresta("Semelhe","Rua 1", "Rua 7", 2).
aresta("Semelhe","Rua 1", "Rua 15", 12).
aresta("Semelhe","Rua 0", "Rua 15", 14).
aresta("Semelhe","Rua 0", "Rua 3", 18).
aresta("Semelhe","Rua 0", "Rua 19", 19).
aresta("Semelhe","Rua 0", "Rua 8", 16).
aresta("Semelhe","Rua 0", "Rua 12", 7).
aresta("Semelhe","Rua 15", "Rua 16", 10).
aresta("Semelhe","Rua 12", "Rua 13", 10).
aresta("Semelhe","Rua 12", "Rua 16", 19).
aresta("Semelhe","Rua 12", "Rua 3", 12).
aresta("Semelhe","Rua 3", "Rua 7", 6).
aresta("Semelhe","Rua 3", "Rua 19", 17).
aresta("Semelhe","Rua 3", "Rua 11", 6).
aresta("Semelhe","Rua 11", "Rua 8", 17).
aresta("Semelhe","Rua 19", "Rua 16", 16).
aresta("Semelhe","Rua 7", "Rua 18", 14).
aresta("Semelhe","Rua 13", "Rua 18", 10).

vertice("Semelhe","Rua 0", 1/5).
vertice("Semelhe","Rua 1", 3/8).
vertice("Semelhe","Rua 3", 5/8).
vertice("Semelhe","Rua 7", 6/5).
vertice("Semelhe","Rua 8", 8/4).
vertice("Semelhe","Rua 11", 7/8).
vertice("Semelhe","Rua 12", 4/4).
vertice("Semelhe","Rua 13", 8/4).
vertice("Semelhe","Rua 15", 4/2).
vertice("Semelhe","Rua 16", 6/1).
vertice("Semelhe","Rua 18", 9/4).
vertice("Semelhe","Rua 19", 6/6).