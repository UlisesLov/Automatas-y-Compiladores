%{
/* Programa para reconocer palabras reservadas, variables y tipos de datos en C */
#include <stdio.h>
#include <string.h>
%}

%%
"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"    { 
    printf("\033[1;31m%s\033[0m - Palabra reservada\n", yytext); 
}

"char"|"int"|"float"|"double"|"void"|"long"|"short"|"signed"|"unsigned"|"bool"|"size_t"|"_Bool"|"_Complex"|"_Imaginary"    { 
    printf("\033[1;32m%s\033[0m - Tipo de dato\n", yytext); 
}

[a-zA-Z_][a-zA-Z0-9_]*    { 
    printf("\033[1;34m%s\033[0m - Posible identificador/variable\n", yytext); 
}

[0-9]+    { 
    printf("\033[1;35m%s\033[0m - Constante numérica entera\n", yytext); 
}

[0-9]+"."[0-9]+    { 
    printf("\033[1;35m%s\033[0m - Constante numérica flotante\n", yytext); 
}

\"[^\"]*\"    { 
    printf("\033[1;33m%s\033[0m - Cadena de texto\n", yytext); 
}

\{|\}|\[|\]|\(|\)|;|,|\.|\+|-|\*|\/|%|=|<|>|!|&|\||\^|~|\?|:    { 
    printf("\033[1;36m%s\033[0m - Operador o símbolo\n", yytext); 
}

[ \t\n]+    { /* Ignorar espacios en blanco */ }

.    { printf("\033[1;30m%s\033[0m - No reconocido\n", yytext); }

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
    
    printf("=== Analisis lexico de codigo C ===\n");
    yylex();
    printf("=== Fin del analisis ===\n");
    
    if (argc > 1) {
        fclose(yyin);
    }
    
    return 0;
}