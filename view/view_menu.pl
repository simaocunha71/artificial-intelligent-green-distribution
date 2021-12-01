%-------------------------------------------------------------------------------------%
menuPrincipal :-
    write('\n'),
    write('-----------MENU-------------\n'),
    write('Seleciona um número (não te esqueças do ponto final):\n'),
    write('>   1. Efetuar listagens\n'),
    write('>   2. Efetuar querys\n'),
    write('>   3. Sair\n').
%-------------------------------------------------------------------------------------%
menuListas :-
    write('\n'),
    write('-----------Listagens-----------\n'),
    write(' 1. Listar estafetas\n'),
    write(' 2. Listar meios de transporte\n'),
    write(' 3. Listar pedidos\n'),
    write(' 0. Sair\n').

menuListar_estafetas :-
    write('Listar estafetas por:\n'),
    write('  1.Nome \n'),
    write('  2.ID \n'),
    write('  3.Zona \n'),
    write('  4.Meio de Transporte \n'),
    write('  5.Somatório de classificações \n'),
    write('  6.Número de classificações totais \n'),
    write('  7.Pedido \n'),
    write('  8.Nível de penalização \n\n'),
    write('  0. Sair\n').

menuListar_MT :-
    write('\nListar meios de transporte por:\n'),
    write('  8.Matricula\n'),
    write('  9.Tipo \n'),
    write(' 10.Velocidade \n'),
    write(' 11.Peso \n\n'),
    write('  0. Sair\n').

menuListar_Pedidos :-
    write('\nListar pedidos por:\n'),
    write(' 12.ID do pedido \n'),
    write(' 13.ID do cliente \n'),
    write(' 14.Valor \n'),
    write(' 15.Data limite \n'),
    write(' 16.Rua \n'),
    write(' 17.Freguesia \n'),
    write(' 18.Peso \n'),
    write(' 19.Data do pedido \n'),
    write(' 20.Estado \n\n'),
    write('0.Sair \n').

%-------------------------------------------------------------------------------------%
menuQuery_view :-
    write('\n'),
    write('-----------Querys-----------\n'),
    write(' 1. Identificar o estafeta que utilizou mais vezes um meio de transporte mais ecológico\n'),
    write(' 2. Identificar que estafetas entregaram determinada(s) encomenda(s) a um determinado cliente\n'),
    write(' 3. Identificar os clientes servidos por um determinado estafeta\n'),
    write(' 4. Calcular o valor faturado pela Green Distribution num determinado dia\n'),
    write(' 5. Identificar quais as zonas com maior volume de entregas por parte da Green Distribution\n'),
    write(' 6. Calcular a classificação média de satisfação de cliente para um determinado estafeta\n'),
    write(' 7. Identificar o número total de entregas pelos diferentes meios de transporte, num determinado intervalo de tempo\n'),
    write(' 8. Identificar o número total de entregas pelos estafetas, num determinado intervalo de tempo\n'),
    write(' 9. Calcular o número de encomendas entregues e não entregues pela Green Distribution, num determinado período de tempo\n'),
    write('10. Calcular o peso total transportado por estafeta num determinado dia\n'),
    write('11. Calcular o peso total transportado por um dado estafeta num determinado dia\n\n'),
    write(' 0.Sair \n').

%-------------------------------------------------------------------------------------%
%                           Pretty print dos termos 
%-------------------------------------------------------------------------------------%

writeEstafeta(estafeta(Nome,ID,Zona,MeioT,CL,LE,Penaliz)) :-
  write('Nome do estafeta: '), write(Nome), writeln(';'),
  write('ID: '), write(ID), writeln(';'),
  write('Zona: '), write(Zona), writeln(';'),
  writeln('Meio de transporte: '), writeMT(MeioT), writeln(';'),
  write('Somatório/Número de classificações: '), write(CL), writeln(';'),
  writeln('Pedidos associados: '), printPedidos(LE),
  write('Nível de penalização: '), write(Penaliz), write('\n').


write_lista_estafeta([],_).

write_lista_estafeta([H|T],Option):-
    (Option == 0 ->
        writeEstafeta(H);
        H = estafeta(Nome,_,_,_,_,_,_),
        write('Nome do estafeta: '), write(Nome), writeln(';'),
        writeln('-----------------------------------------------')
        ),
    write_lista_estafeta(T,Option).

write_lista_estafPesos([]).
write_lista_estafPesos([Name/Peso|T]):-
    writeln(Name),write("-"),write(Peso),write('nl'),
    write_lista_estafPesos(T).



writeMT(meio_transporte(ID,T,P,V)) :-
  write('> Matricula: '), write(ID), writeln('; '),  
  write('> Tipo: '), write(T), writeln('; '),
  write('> Peso máximo: '), write(P), writeln('; '),
  write('> Velocidade máxima: '), write(V).

printMts([]).
printMts([H|T]) :-
    writeMT(H),
    printMts(T).

printPedidos([]).
printPedidos([H|T]) :-
    writePedido(H),
    printPedidos(T).

writePedido(pedido(ID_Cl, ID_Ped, DataEnt, Rua, Freg, Peso, DataPed, Est)) :-
  write('> ID do pedido: '), write(ID_Ped), write('; '),
  write('ID do cliente: ' ), write(ID_Cl), write('; '),
  write('Data de entrega: '), write(DataEnt), write('; '),
  write('Rua: '), write(Rua), write('; '),
  write('Freguesia: '), write(Freg), write('; '),
  write('Peso: '), write(Peso), write('; '),
  write('Data do pedido: '), write(DataPed), write('; '),
  write('Estado: '), write(Est), writeln('.').

% limpar tela
limpaT :-
    write('\033[H\033[2J').