%{
#include <stdio.h>
#include <string.h>
%}
%%

\+90[0-9]{10} {printf("Rule 1: Phone number without spaces: %s\n", yytext);}
\+90\s[0-9]{3}\s[0-9]{3}\s[0-9]{2}\s[0-9]{2} {printf("RULE 2: Phone number with spaces: %s\n", yytext);}

[a-zA-Z\.\-\_0-9]+\@[a-z]+\.[a-z]{2,}(\.[a-z]{2,})? {printf("RULE 4: Email: %s\n", yytext);}

%%

int main(int argc, char **argv) {
    yylex(); 
    return 0;
}