lexer: tokenizer.l demo.c
	flex tokenizer.l
	gcc -o lexer lex.yy.c -lfl
	./lexer < demo.c
	rm -r lexer