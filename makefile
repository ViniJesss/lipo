syntax: lexem.l syntax.y
		bison -d syntax.y
		flex lexem.l
		cc -o $@ syntax.tab.c lex.yy.c -lfl