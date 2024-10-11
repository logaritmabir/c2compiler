../email-regex

$ flex flexparser.l
$ gcc -o parser lex.yy.c
$ ./parser < input.txt