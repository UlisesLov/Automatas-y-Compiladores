%{
/* Programa para reconocer elementos gramaticales y verbos de la taxonomía de Bloom - analizar */
#include <stdio.h>
#include <string.h>
%}

%%
"analizar"    { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"categorizar" { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"clasificar"  { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"comparar"    { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"contrastar"  { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"criticar"    { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"debatir"     { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"deducir"     { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"descomponer" { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"descubrir"   { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"desmenuzar"  { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"detectar"    { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }
"diferenciar" { printf("\033[34m%s\033[0m - Verbo de análisis (Bloom)\n", yytext); }

"agradable"   { printf("\033[32m%s\033[0m - Adjetivo calificativo positivo\n", yytext); }
"amable"      { printf("\033[32m%s\033[0m - Adjetivo calificativo positivo\n", yytext); }
"asombroso"   { printf("\033[32m%s\033[0m - Adjetivo calificativo positivo\n", yytext); }
"atento"      { printf("\033[32m%s\033[0m - Adjetivo calificativo positivo\n", yytext); }
"atractivo"   { printf("\033[32m%s\033[0m - Adjetivo calificativo positivo\n", yytext); }
"bueno"       { printf("\033[32m%s\033[0m - Adjetivo calificativo positivo\n", yytext); }
"excelente"   { printf("\033[32m%s\033[0m - Adjetivo calificativo positivo\n", yytext); }
"fantástico"  { printf("\033[32m%s\033[0m - Adjetivo calificativo positivo\n", yytext); }
"hermoso"     { printf("\033[32m%s\033[0m - Adjetivo calificativo positivo\n", yytext); }
"increíble"   { printf("\033[32m%s\033[0m - Adjetivo calificativo positivo\n", yytext); }

"y"           { printf("\033[33m%s\033[0m - Conjunción\n", yytext); }
"e"           { printf("\033[33m%s\033[0m - Conjunción\n", yytext); }
"ni"          { printf("\033[33m%s\033[0m - Conjunción\n", yytext); }
"que"         { printf("\033[33m%s\033[0m - Conjunción\n", yytext); }
"o"           { printf("\033[33m%s\033[0m - Conjunción\n", yytext); }
"u"           { printf("\033[33m%s\033[0m - Conjunción\n", yytext); }
"pero"        { printf("\033[33m%s\033[0m - Conjunción\n", yytext); }
"mas"         { printf("\033[33m%s\033[0m - Conjunción\n", yytext); }
"aunque"      { printf("\033[33m%s\033[0m - Conjunción\n", yytext); }
"si"          { printf("\033[33m%s\033[0m - Conjunción\n", yytext); }

"a"           { printf("\033[35m%s\033[0m - Preposición\n", yytext); }
"ante"        { printf("\033[35m%s\033[0m - Preposición\n", yytext); }
"bajo"        { printf("\033[35m%s\033[0m - Preposición\n", yytext); }
"con"         { printf("\033[35m%s\033[0m - Preposición\n", yytext); }
"de"          { printf("\033[35m%s\033[0m - Preposición\n", yytext); }
"desde"       { printf("\033[35m%s\033[0m - Preposición\n", yytext); }
"en"          { printf("\033[35m%s\033[0m - Preposición\n", yytext); }
"entre"       { printf("\033[35m%s\033[0m - Preposición\n", yytext); }
"hacia"       { printf("\033[35m%s\033[0m - Preposición\n", yytext); }
"hasta"       { printf("\033[35m%s\033[0m - Preposición\n", yytext); }

"yo"          { printf("\033[36m%s\033[0m - Pronombre\n", yytext); }
"tú"          { printf("\033[36m%s\033[0m - Pronombre\n", yytext); }
"él"          { printf("\033[36m%s\033[0m - Pronombre\n", yytext); }
"ella"        { printf("\033[36m%s\033[0m - Pronombre\n", yytext); }
"nosotros"    { printf("\033[36m%s\033[0m - Pronombre\n", yytext); }
"vosotros"    { printf("\033[36m%s\033[0m - Pronombre\n", yytext); }
"ellos"       { printf("\033[36m%s\033[0m - Pronombre\n", yytext); }
"ellas"       { printf("\033[36m%s\033[0m - Pronombre\n", yytext); }
"me"          { printf("\033[36m%s\033[0m - Pronombre\n", yytext); }
"te"          { printf("\033[36m%s\033[0m - Pronombre\n", yytext); }

[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+    { /* Otras palabras - no hacemos nada */ }
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
    
    printf("=== Analisis lexico de elementos gramaticales ===\n");
    yylex();
    printf("=== Fin del analisis ===\n");
    
    if (argc > 1) {
        fclose(yyin);
    }
    
    return 0;
}