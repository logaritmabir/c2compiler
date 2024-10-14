%{
#include <stdio.h>
#include <string.h>
%}


IDENTIFIER [a-zA-Z][a-zA-Z0-9]*
NUMBER {DIGIT}+
DIGIT [0-9]


%%

abc { printf("abc found: %s",yytext); }
abc* { printf("abc* found: %s",yytext); }
ab*c { printf("abc found: %s",yytext); }

{IDENTIFIER}\@[a-z]+\.[a-z]{2,}(\.[a-z]{2,})? {
    printf("email: %s\n", yytext);
}

asd123 {
    printf("asd123 found: %s\n", yytext);
}

\"asd123\" {
    printf("\"asd123\" found: %s\n", yytext);
}

x {
    printf("I found unbound x: %s\n", yytext);
}

[xy] {
    printf("I found x or y: %s\n", yytext);
}

. {}
\n {}

%%

int main(int argc, char **argv) {
    yylex(); 
    return 0;
}