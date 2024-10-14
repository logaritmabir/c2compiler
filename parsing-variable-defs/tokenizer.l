%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct {
    char type[16];
    char value[32];
    struct Token* next;
}Token;

Token* head = NULL;
Token* tail = NULL;

void add_token(const char* token_type, const char* token_value) {
    Token* new_token = (Token*)malloc(sizeof(Token));
    strcpy(new_token->type, token_type);
    strcpy(new_token->value, token_value);
    new_token->next = NULL;

    if (head == NULL) {
        head = new_token;
        tail = new_token;
    } else {
        tail->next = new_token;
        tail = new_token;
    }
}

void print_tokens() {
    Token* current = head;
    while (current != NULL) {
        printf("Token Type: %s, Token Value: %s\n", current->type, current->value);
        current = current->next;
    }
}

void free_tokens() {
    Token* current = head;
    while (current != NULL) {
        Token* temp = current;
        current = current->next;
        free(temp);
    }
}

%}
STRING \"([^\"\\]|\\[\"\\nt])*\"
KEYWORD int|float|double|char|void|return|if|else|while|for|main
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
NUMBER [0-9]+(\.[0-9]+)?

%%

"//[^\n]*" { /*Command Line*/ }
"/\\*([^*]|\\*+[^*/])*\\*+/" { /* Multiline Commands */ }

";" { add_token("SEMICOLON", yytext); }
"(" { add_token("LPARAN", yytext); }
")" { add_token("RPARAN", yytext); }
"{" { add_token("LBRACE", yytext); }
"}" { add_token("RBRACE", yytext); }
"+" { add_token("PLUS", yytext); }
"-" { add_token("MINUS", yytext); }
"*" { add_token("MULTIPLY", yytext); }
"/" { add_token("DIVIDE", yytext); }
"=" { add_token("ASSIGN", yytext); }
"==" { add_token("EQ", yytext); }
"!=" { add_token("NEQ", yytext); }
"<=" { add_token("LEQ", yytext); }
">=" { add_token("GEQ", yytext); }
"%" { add_token("MOD", yytext); }
"++" { add_token("INCREMENT", yytext); }
"--" { add_token("DECREMENT", yytext); }
"+=" { add_token("PLUSEQ", yytext); }
"-=" { add_token("MINUSEQ", yytext); }
"*=" { add_token("MULTEQ", yytext); }
"/=" { add_token("DIVEQ", yytext); }
"<" { add_token("LT", yytext); }
">" { add_token("GT", yytext); }
"&&" { add_token("AND", yytext); }
"||" { add_token("OR", yytext); }
"!" { add_token("NOT", yytext); }

{KEYWORD} { add_token("KEYWORD", yytext); }
{IDENTIFIER} { add_token("IDENTIFIER", yytext); }
{NUMBER} { add_token("NUMBER", yytext); }
{STRING} { add_token("STRING", yytext); }

[\n\t\r ]+ {}
. { printf("Error: Unrecognized character '%s'\n", yytext); }
%%

int main(int argc, char **argv) {
    yylex(); 
    print_tokens();
    free_tokens();
    return 0;
}