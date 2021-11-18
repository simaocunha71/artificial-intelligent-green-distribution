:-[dados].


run_opt(1) :-
    menu.

run_opt(2) :- write('Adeus\n'), halt.

run_opt(_) :- write('Opção Inválida\n').


main :-
    write('\n'),
    write('-----------MENU-------------\n'),
    write('Seleciona um número (não te esqueças do ponto final):'), nl,
    write('>   1. Executar uma query'), nl,
    write('>   2. Sair'), 
    write('\n'),
    import,
    read(Choice),
    run_opt(Choice).


% ------------------------------ Menu auxiliar ------------------------------------------

menu :-
    write('\n'),
    write('-----------Listagens-----------\n'),
    write('Listar estafetas por:\n'),
    write(' 1.Nome \n'),
    write(' 2.ID \n'),
    write(' 3.Zona \n'),
    write(' 4.Meio de Transporte \n'),
    write(' 5.Classificação Média \n'),
    write(' 6.Classificação Total \n'),

    write('\nListar meios de transporte por:\n'),
    write(' 7.Tipo \n'),
    write(' 8.Velocidade \n'),
    write(' 9.Peso \n'),

    write('\nListar pedidos por:\n'),
    write(' 10.Cliente \n'),
    write(' 11.Prazo \n'),
    write(' 12.Zona \n'),
    write(' 13.Peso \n'),
    write(' 14.Data \n'),
    write(' 15.Estado \n'),
    write('\n'),
    write('0.Sair \n'),
    read(Option),
    executar(Option).

executar(Option) :-(Option=:=1, estafeta_nome;
                    Option=:=2, estafeta_id;
                    Option=:=3, estafeta_zona;
                    Option=:=4, estafeta_meioT;
                    Option=:=5, estafeta_clMedia;
                    Option=:=6, estafeta_clTotais;
                    Option=:=7, meioTransporte_tipo;
                    Option=:=8, meioTransporte_vel;
                    Option=:=9, meioTransporte_peso;
                    Option=:=10, pedido_cliente;
                    Option=:=11, pedido_prazo;
                    Option=:=12, pedido_zona;  
                    Option=:=13, pedido_peso;
                    Option=:=14, pedido_data; 
                    Option=:=15, pedido_estado;   
                    
                    Option=:=0, true,write('BYE'),nl,halt
                   ),main.

/*------------------------------ Estafeta ---------------------------------- */
estafeta_nome :-
    write('Nome:'),
    read(Nome),
    estafeta_nome(Nome, R),
    writeln(R).
  %  append('\n> ',R,RES),
  %  write(RES),

estafeta_id :-
    write('Id:'),
    read(ID),
    estafeta_id(ID, R),
    write('ola'),
    write(R),
    write('\n').

estafeta_zona :-
    write('Zona:'),
    read(Zona),
    estafeta_zona(Zona, R),
    write(R),
    write('\n').

estafeta_meioT :-
    write('Meio de transporte:'),
    read(MTranp),
    estafeta_meioT(MTranp, R),
    write(R),
    write('\n').

estafeta_clMedia :-
    write('Classificação média:'),
    read(ClMedia),
    estafeta_clMedia(ClMedia, R),
    write(R),
    write('\n').

estafeta_clTotais :-
    write('Opçao a implementar'),
    write('Classificação total: '),
    read(ClTotal),
    estafeta_clTotais(ClTotal, R),
    write(R),
    write('\n').

/*------------------------------ Meios de transporte ---------------------------------- */
meioTransporte_tipo :-
    write('Tipo de transporte:'),
    read(Tipo),
    meioTransporte_tipo(Tipo, R),
    write(R),
    write('\n').

meioTransporte_vel :-
    write('Velocidade do transporte:'),
    read(Vel),
    meioTransporte_vel(Vel, R),
    write(R),
    write('\n').


meioTransporte_peso :-
    write('Peso do transporte:'),
    read(Peso),
    meioTransporte_peso(Peso, R),
    write(R),
    write('\n').


/*------------------------------ Pedidos ---------------------------------- */
pedido_cliente :-
    write('Cliente: '),
    read(Cliente),
    pedido_cliente(Cliente, R),
    write(R),
    write('\n').


pedido_prazo :-
    write('Prazo: '),
    read(Prazo),
    pedido_prazo(Prazo, R),
    write(R),
    write('\n').

pedido_zona :-
    write('Zona: '),
    read(Zona),
    pedido_zona(Zona, R),
    write(R),
    write('\n').

pedido_peso :-
    write('Peso: '),
    read(Peso),
    pedido_peso(Peso, R),
    write(R),
    write('\n').

pedido_data :-
    write('Data: '),
    read(Data),
    pedido_data(Data, R),
    write(R),
    write('\n').

pedido_estado :-
    write('Estado: '),
    read(Estado),
    pedido_estado(Estado, R),
    write(R),
    write('\n').