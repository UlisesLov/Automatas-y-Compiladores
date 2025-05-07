/* scanner.l */
%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "y.tab.h"
    extern int yylval;
    #undef yywrap
%}

%%

[0-9]+      { 
                yylval = atoi(yytext); 
                return NUMBER; 
            }

"*"         { return TIMES; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"/"         { return DIVIDE; }

\n          { return EOL; }
[ \t\r]+    { }

.           { fprintf(stderr, "Carácter no válido: '%s'\n", yytext); }

%%

int yywrap(void) {
    return 1;
}

