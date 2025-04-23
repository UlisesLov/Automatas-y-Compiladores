%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    extern int yylval;
    #undef yywrap
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return PLUS; }
"-"	    { return MINUS; }
"*"	    { return TIMES; }
"/"	    { return DIVIDE; }

\n          { return EOL; }
[ \t\r]+    { /* skip whitespace */ }

%%

int yywrap(void) {
    return 1;
}
