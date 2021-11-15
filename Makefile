CC=swipl
FLAGS=--goal=main --stand_alone=true --quiet
EXE=prog
FILE=main.pl

$(EXE): $(FILE)
	$(CC) $(FLAGS) -o $@ -c $^

clean:
	-@$(RM) $(EXE) 2>/dev/null