:-[dados].


run_opt(1) :-
    write('>   Enter a query followed by a period.'), nl,
    read(Query),
    print_query_true(Query),
    print_query_false(Query).

run_opt(2) :- write('Goodbye'), nl, halt.

run_opt(_) :- write('Invalid option'), nl, halt.

print_query_true(Q) :-
    forall(Q, writeln(true:Q)).

print_query_false(Q) :-
    forall(\+ Q, writeln(false:Q)).


main :-
    nl,
    write('>   Enter a selection followed by a period.'), nl,
    write('>   1. Run a query'), nl,
    write('>   2. Exit'), nl, nl,
    read(Choice),
    run_opt(Choice), main.
