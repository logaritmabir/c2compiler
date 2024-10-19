%{
    #include "parser.tab.h"
%}

%%
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"|" { return ABS; }
\n { return EOL;}
[0-9]+ { yylval.intval = atoi(yytext); return NUMBER; }

. {}

%%
