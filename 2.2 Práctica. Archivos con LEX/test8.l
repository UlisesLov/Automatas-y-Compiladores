%{
/* Programa para reconocer verbos de la taxonomía de Bloom - categoría aplicación */
#include <stdio.h>
#include <string.h>
%}

%%
aplicar|calcular|cambiar|computar|construir|demostrar|desarrollar|descubrir|dibujar|dramatizar|emplear|esbozar|establecer|experimentar|ilustrar|implementar|manipular|modificar|operar|organizar|practicar|predecir|preparar|producir|programar|resolver|solucionar|usar|utilizar    { 
    printf("\033[32m%s\033[0m - Verbo de aplicación\n", yytext); 
}

[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+    { /* Otras palabras */ }
.|\n                        { /* Ignorar otros caracteres */ }

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
    
    printf("=== Verbos de la taxonomia de Bloom - Categoria Aplicacion ===\n");
    yylex();
    printf("=== Fin del analisis ===\n");
    
    if (argc > 1) {
        fclose(yyin);
    }
    
    return 0;
}