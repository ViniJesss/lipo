
%{
#include <stdio.h>
#include <string.h>

#ifndef YYSTYPE
#define YYSTYPE char*
#endif
extern YYSTYPE yylval;
extern FILE *yyin;
int yylex(void);
%}




%token VAR
%token ID NUMBER
%token PLUS MINUS MUL DIV ASSIGN 
%token OPBRACKET CLBRACKET
%token COMMA SEMICOLON




%%
PROGRAM: 
    VAR_DECL VAR_ASSIGNMENT {  $$ = strcat($1, $2); $$ = strcat($$, "]\n");  printf("%s", $$); }
    ;

VAR_DECL:
    VAR VAR_DECL_LIST SEMICOLON { $$ = strcat($1, " "); $$ = strcat($$, $2); $$ = strcat($$, $3); $$ = strcat($$, "\n[");   }
    ;

VAR_DECL_LIST: ID
    | ID COMMA VAR_DECL_LIST { $$ = strcat($1, $2); $$ = strcat($$, $3);}
    ;

VAR_ASSIGNMENT: VAR_ASSIGN_LIST {  $$ = $1; }
    ;

VAR_ASSIGN_LIST: ASSIGNMENT
    | ASSIGNMENT VAR_ASSIGN_LIST { $$ = strcat($1, $2); }
    ;

ASSIGNMENT: ID ASSIGN EXPR SEMICOLON { $$ = strcat($1, "="); $$ = strcat($$, $3); $$ = strcat($$, $4); $$ = strcat($$, "\n");}
    ;

EXPR: UNO SUBEXPR { $$ = strcat($1, $2); }
    | SUBEXPR
    ;

SUBEXPR: OPBRACKET EXPR CLBRACKET { $$ = strcat($1, $2); $$ = strcat($$, $3); }
    | OPERAND
    | SUBEXPR BIN SUBEXPR { $$ = strcat($1, $2); $$ = strcat($$, $3); }
    ;

UNO: MINUS;

BIN: MINUS
    | PLUS
    | MUL
    | DIV
    ;

OPERAND: ID
    | NUMBER
    ;
%%

void yyerror (char *s) {
    fprintf(stderr, "error: %s\n", s);
}

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    yyin = fopen("test.txt", "r");
    yyparse();
    fclose(yyin);
    return 0;
}