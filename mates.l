%option noyywrap
%{
    #include <stdio.h>
    #include <string.h>
    
    int cont_lineas = 0;      
    int cont_palabras = 0;    
    int cont_caracteres = 0;  
    int cont_palabras_ni = 0;
    int cont_palabras_num = 0;
    int cont_palabras_bto = 0;
    int cont_palabras_jo = 0;
    int cont_digitos = 0;
%}

%%
"ni"[a-zA-Z0-9]* { 
    cont_palabras_ni++; 
    cont_palabras++;
    cont_caracteres += yyleng;
}
"núm"[a-zA-Z0-9]* { 
    cont_palabras_num++; 
    cont_palabras++;
    cont_caracteres += yyleng;
}
"b"[a-zA-Z0-9]*"to" { 
    cont_palabras_bto++; 
    cont_palabras++;
    cont_caracteres += yyleng;
}
[a-zA-Z0-9]*"jo" { 
    /* Verifica que no empiece con "ni" o "núm" o "b" y termine con "to" */
    if (!(strncmp(yytext, "ni", 2) == 0 || 
          strncmp(yytext, "núm", 4) == 0 || 
          (yytext[0] == 'b' && yytext[yyleng-2] == 't' && yytext[yyleng-1] == 'o'))) {
        cont_palabras_jo++; 
        cont_palabras++;
        cont_caracteres += yyleng;
    }
}
^[0-9]+$ {
    cont_digitos++;
    cont_palabras++;
    cont_caracteres += yyleng;
}
[a-zA-Z][a-zA-Z0-9]* { 
    /* Palabras que no entran en ninguna categoría anterior */
    if (!(strncmp(yytext, "ni", 2) == 0 || 
          strncmp(yytext, "núm", 4) == 0 || 
          yytext[0] == 'b' || 
          (yytext[yyleng-2] == 'j' && yytext[yyleng-1] == 'o'))) {
        cont_palabras++; 
        cont_caracteres += yyleng;
    }
}
\n { 
    cont_lineas++; 
    cont_caracteres++;
}
[ \t\r\f\v] { 
    cont_caracteres++; 
}
. { 
    cont_caracteres++; 
}

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            fprintf(stderr, "No se pudo abrir el archivo '%s'\n", argv[1]);
            return 1;
        }
        yyin = file;
    } else {
        printf("Uso: %s <archivo>\n", argv[0]);
        printf("Archivo no proprocionado\n");
    }
    
    yylex();
    
    printf("----- RESULTADOS DEL ANALISIS -----\n");
    printf("Total de lineas: %d\n", cont_lineas);
    printf("Total de palabras: %d\n", cont_palabras);
    printf("Total de caracteres: %d\n", cont_caracteres);
    printf("Total de palabras que son digitos: %d\n", cont_digitos);
    printf("\n----- CONTADORES ESPECIFICOS -----\n");
    printf("Palabras que empiezan con 'ni': %d\n", cont_palabras_ni);
    printf("Palabras que empiezan con 'num': %d\n", cont_palabras_num);
    printf("Palabras que empiezan con 'b' y terminan con 'to': %d\n", cont_palabras_bto);
    printf("Palabras que terminan con 'jo': %d\n", cont_palabras_jo);
    
    if (argc > 1) {
        fclose(yyin);  
    }
    
    return 0;
}