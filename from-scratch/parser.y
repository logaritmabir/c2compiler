%{
    #include <stdio.h>
    void yyerror(char *s);
%}

%union {
    int intval;
}

%token <intval> NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

%type <intval> terminal
%type <intval> factor
%type <intval> expression

%%

program: 
|program expression EOL { printf("= %d\n", $2); }
;
expression: factor
| expression ADD factor { $$ = $1 + $3; }
| expression SUB factor { $$ = $1 - $3; }
;

factor: terminal
| factor MUL terminal { $$ = $1 * $3; }
| factor DIV terminal { $$ = $1 / $3; }
;

terminal: NUMBER
| ABS terminal { $$ = $2 >= 0? $2 : - $2; }
;
%%

int main(int argc, char **argv){
    yyparse();
}

void yyerror(char *s){
    fprintf(stderr, "error: %s\n", s);
}