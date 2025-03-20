%{
/* Programa para convertir texto a minúsculas */
#include <stdio.h>
#include <ctype.h>
%}

%%
[A-Z]    { putchar(tolower(yytext[0])); }
.|\n     { ECHO; }
%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file;
        file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "No se puede abrir %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }
    
    yylex();
    
    if (argc > 1) {
        fclose(yyin);
    }
    
    return 0;
}