%{
#ifndef YYSTYPE
#define YYSTYPE char*
#endif
extern YYSTYPE yylval;

#include "syntax.tab.h"
%}



%%
"Var"      yylval = strdup(yytext); return VAR;
[a-zA-Z]+  yylval = strdup(yytext); return ID;
"+"        yylval = strdup(yytext); return PLUS;
"-"        yylval = strdup(yytext); return MINUS;
"*"        yylval = strdup(yytext); return MUL;
"/"        yylval = strdup(yytext); return DIV;
":="       yylval = strdup(yytext); return ASSIGN;
"("        yylval = strdup(yytext); return OPBRACKET;
")"        yylval = strdup(yytext); return CLBRACKET;
","        yylval = strdup(yytext); return COMMA;
";"        yylval = strdup(yytext); return SEMICOLON;
[0-9]+     yylval = strdup(yytext); return NUMBER;
[ \t\n\r\s]+   ;
.          return *yytext;
%%