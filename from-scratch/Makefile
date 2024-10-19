lexer: lexer.l parser.y test.txt
	flex lexer.l
	bison -d parser.y
	gcc -o parser parser.tab.c lex.yy.c -lfl
	./parser < test.txt
	rm -r ./parser

