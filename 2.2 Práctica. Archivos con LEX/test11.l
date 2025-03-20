%{
/* Programa para reconocer comentarios y texto que se presenta en pantalla en C */
#include <stdio.h>
#include <string.h>
%}

%%
"/*"[^*]*"*/"            { printf("\033[33m%s\033[0m - Comentario de bloque\n", yytext); }

"//"[^\n]*               { printf("\033[32m%s\033[0m - Comentario de línea\n", yytext); }

"printf"[ ]+"("[^)]*")"  { printf("\033[36m%s\033[0m - Función printf\n", yytext); }

"puts"[ ]+"("[^)]*")"    { printf("\033[36m%s\033[0m - Función puts\n", yytext); }

"fprintf"[ ]+"("[ ]*"stdout"[ ]*","[^)]*")" { 
    printf("\033[36m%s\033[0m - Función fprintf\n", yytext); 
}

\"[^\"]*\"               { printf("\033[34m%s\033[0m - Cadena de texto\n", yytext); }

[a-zA-Z_][a-zA-Z0-9_]*   { /* identificadores - ignoramos */ }
[ \t\n]+                 { /* espacios en blanco - ignoramos */ }
.                        { /* otros caracteres - ignoramos */ }

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
    
    printf("=== Analisis de comentarios y textos en pantalla en C ===\n");
    yylex();
    printf("=== Fin del analisis ===\n");
    
    if (argc > 1) {
        fclose(yyin);
    }
    
    return 0;
}