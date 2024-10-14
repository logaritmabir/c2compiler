lexer: flexparser.l input.txt
	flex flexparser.l
	gcc -o lexer lex.yy.c -lfl
	./lexer < input.txt
	rm -r lexer