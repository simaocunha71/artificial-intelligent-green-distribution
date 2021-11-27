% ------------------------ Invariantes------------------------------ %

% consultar -> https://www.swi-prolog.org/pldoc/man?predicate=op/3
:- op(900, xfy, '::').
:- ensure_loaded(querys).

% (a) Estafetas
% Id do estafeta é unico e é um Integer
+estafeta(_,ID,_,_,_/_,_) :: (integer(ID),
                              findall(ID,estafeta(_,ID,_,_,_/_,_),S),
                              length(S,L),
                              L == 1).

%verificar se meios de transporte sao os disponiveis na base de conhecimento

%verificar se os pedidos de um estafeta existem na base de conhecimento

% Remoção do estafeta só é possível se existir na base de conhecimento
-estafeta(_,ID,_,_,_/_,_) :: (findall(ID,estafeta(_,ID,_,_,_/_,_),S),
                              length(S,L),
                              L == 0).
% (b) Meios de transporte

% (c) Pedidos_