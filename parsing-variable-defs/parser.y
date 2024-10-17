%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}
%}

%union {
    int ival;
    char* sval;
}

%token SEMICOLON LPARAN RPARAN LBRACE RBRACE
%token PLUS MINUS MULTIPLY DIVIDE ASSIGN
%token EQ NEQ LT GT LEQ GEQ MOD
%token INCREMENT DECREMENT PLUSEQ MINUSEQ MULTEQ DIVEQ
%token AND OR NOT
%token IF ELSE WHILE
%token IDENTIFIER NUMBER STRING
%token KEYWORD

%type <sval> IDENTIFIER STRING
%type <ival> NUMBER
%type <ival> expression

%left OR
%left AND
%left EQ NEQ
%left LT GT LEQ GEQ
%left PLUS MINUS
%left MULTIPLY DIVIDE MOD
%right ASSIGN

%start program

%%

program:
    statement_list
    ;

statement_list:
    statement_list statement
    | statement
    ;

statement:
    expression_statement
    | if_statement
    | while_statement
    | block_statement
    ;

block_statement:
    LBRACE statement_list RBRACE
    ;

expression_statement:
    expression SEMICOLON
    ;

if_statement:
    IF LPARAN expression RPARAN statement
    | IF LPARAN expression RPARAN statement ELSE statement
    ;

while_statement:
    WHILE LPARAN expression RPARAN statement
    ;

expression:
    IDENTIFIER ASSIGN expression     { printf("Assignment\n"); }
    | expression PLUS expression     { printf("Addition\n"); }
    | expression MINUS expression    { printf("Subtraction\n"); }
    | expression MULTIPLY expression { printf("Multiplication\n"); }
    | expression DIVIDE expression   { printf("Division\n"); }
    | LPARAN expression RPARAN       { $$ = $2; }
    | NUMBER                         { $$ = $1; }
    | IDENTIFIER                     { $$ = $1; }
    ;

%%

int main() {
    yyparse();
    return 0;
}
