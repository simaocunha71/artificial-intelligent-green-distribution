CC=swipl
FLAGS=--goal=main --stand_alone=true 
EXE=prog
FILE=src/greenDistributionApp.pl

$(EXE): $(FILE)
	$(CC) $(FLAGS) -o $@ -c $^

clean:
	-@$(RM) $(EXE) 2>/dev/null 