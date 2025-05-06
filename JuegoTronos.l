%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

// Estructuras para almacenar los conteos
typedef struct {
    char *nombre;
    int contador;
} Elemento;

// Lugares
Elemento lugares[] = {
    {"Westeros", 0},
    {"Invernalia", 0},
    {"Desembarco del Rey", 0},
    {"Nido de Águilas", 0},
    {"Altojardín", 0},
    {"Aguasdulces", 0},
    {"Rocadragón", 0},
    {"Roca Casterly", 0},
    {"Bastión de Tormentas", 0},
    {"Dorne", 0}
};
int num_lugares = sizeof(lugares) / sizeof(Elemento);

// Casas
Elemento casas[] = {
    {"Stark", 0},
    {"Arryn", 0},
    {"Tully", 0},
    {"Greyjoy", 0},
    {"Lannister", 0},
    {"Tyrell", 0},
    {"Martell", 0},
    {"Baratheon", 0},
    {"Targaryen", 0}
};
int num_casas = sizeof(casas) / sizeof(Elemento);

// Personajes
Elemento personajes[] = {
    {"Eddard", 0},
    {"Ned", 0},      // Apodo de Eddard
    {"Catelyn", 0},
    {"Arya", 0},
    {"Sansa", 0},
    {"Robb", 0},
    {"Bran", 0},
    {"Rickon", 0},
    {"Jon", 0},
    {"Robert", 0},
    {"Joffrey", 0},
    {"Stannis", 0},
    {"Renly", 0},
    {"Aegon", 0},
    {"Daenerys", 0},
    {"Dany", 0},     // Apodo de Daenerys
    {"Aerys", 0},
    {"Tywin", 0},
    {"Jaime", 0},
    {"Tyrion", 0},
    {"Cersei", 0},
    {"Lysa", 0},     // Arryn
    {"Robin", 0},    // Arryn
    {"Theon", 0},    // Greyjoy
    {"Balon", 0},    // Greyjoy
    {"Euron", 0},    // Greyjoy
    {"Victarion", 0},// Greyjoy
    {"Edmure", 0},   // Tully
    {"Brynden", 0},  // Tully (Pez Negro)
    {"Hoster", 0},   // Tully
    {"Mace", 0},     // Tyrell
    {"Loras", 0},    // Tyrell
    {"Margaery", 0}, // Tyrell
    {"Olenna", 0},   // Tyrell
    {"Doran", 0},    // Martell
    {"Oberyn", 0},   // Martell
    {"Elia", 0}      // Martell
};
int num_personajes = sizeof(personajes) / sizeof(Elemento);

// Función para convertir a minúsculas y normalizar el texto
void normalizar_texto(char *texto) {
    int i = 0;
    while (texto[i]) {
        texto[i] = tolower(texto[i]);
        i++;
    }
}

// Función para buscar coincidencias en el texto
void buscar_elementos(char *texto) {
    char texto_lower[strlen(texto) + 1];
    strcpy(texto_lower, texto);
    normalizar_texto(texto_lower);
    
    // Buscar lugares
    for (int i = 0; i < num_lugares; i++) {
        char lugar_lower[strlen(lugares[i].nombre) + 1];
        strcpy(lugar_lower, lugares[i].nombre);
        normalizar_texto(lugar_lower);
        
        char *pos = texto_lower;
        while ((pos = strstr(pos, lugar_lower)) != NULL) {
            lugares[i].contador++;
            pos++;
        }
    }
    
    // Buscar casas
    for (int i = 0; i < num_casas; i++) {
        char casa_lower[strlen(casas[i].nombre) + 1];
        strcpy(casa_lower, casas[i].nombre);
        normalizar_texto(casa_lower);
        
        char *pos = texto_lower;
        while ((pos = strstr(pos, casa_lower)) != NULL) {
            casas[i].contador++;
            pos++;
        }
    }
    
    // Buscar personajes
    for (int i = 0; i < num_personajes; i++) {
        char personaje_lower[strlen(personajes[i].nombre) + 1];
        strcpy(personaje_lower, personajes[i].nombre);
        normalizar_texto(personaje_lower);
        
        char *pos = texto_lower;
        while ((pos = strstr(pos, personaje_lower)) != NULL) {
            personajes[i].contador++;
            pos++;
        }
    }
}

// Función para imprimir resultados
void imprimir_resultados() {
    printf("\n=== MENCIONES DE LUGARES ===\n");
    for (int i = 0; i < num_lugares; i++) {
        printf("%s: %d\n", lugares[i].nombre, lugares[i].contador);
    }
    
    printf("\n=== MENCIONES DE CASAS ===\n");
    for (int i = 0; i < num_casas; i++) {
        printf("%s: %d\n", casas[i].nombre, casas[i].contador);
    }
    
    printf("\n=== MENCIONES DE PERSONAJES ===\n");
    for (int i = 0; i < num_personajes; i++) {
        printf("%s: %d\n", personajes[i].nombre, personajes[i].contador);
    }
}

%}

%option noyywrap
%option caseless

%%

[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ]+[^a-zA-ZáéíóúüñÁÉÍÓÚÜÑ]* { buscar_elementos(yytext); }
\n                                          { /* Ignorar saltos de línea */ }
.                                           { /* Ignorar otros caracteres */ }

%%

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Uso: %s <archivo_texto>\n", argv[0]);
        return 1;
    }
    
    FILE *archivo = fopen(argv[1], "r");
    if (!archivo) {
        printf("Error: No se pudo abrir el archivo %s\n", argv[1]);
        return 1;
    }
    
    yyin = archivo;
    yylex();
    
    fclose(archivo);
    
    imprimir_resultados();
    
    return 0;
}