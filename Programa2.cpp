#include <iostream>
#include <cctype>
#include <string>
#include <sstream>
using namespace std;

bool esNumeroEntero(const string& cadena) {
    for (char c : cadena) {
        if (!isdigit(c)) return false;
    }
    return true;
}

bool esPalabra(const string& cadena) {
    for (char c : cadena) {
        if (!isalpha(c)) return false;
    }
    return true;
}

bool esCompuesta(const string& cadena) {
    bool tieneLetra = false, tieneNumero = false;
    for (char c : cadena) {
        if (isalpha(c)) tieneLetra = true;
        if (isdigit(c)) tieneNumero = true;
    }
    return tieneLetra && tieneNumero;
}

void clasificarCadenas(const string& entrada) {
    istringstream stream(entrada);
    string palabra;
    int numEnteros = 0, numPalabras = 0, numCompuestas = 0;
    
    while (stream >> palabra) {
        if (esNumeroEntero(palabra)) numEnteros++;
        else if (esPalabra(palabra)) numPalabras++;
        else if (esCompuesta(palabra)) numCompuestas++;
    }
    
    cout << numEnteros << " - entero, " << numPalabras << " palabra, " << numCompuestas << " compuesta" << endl;
}

int main() {
    string entrada;
    cout << "Ingrese una línea de texto: ";
    getline(cin, entrada);
    clasificarCadenas(entrada);
    return 0;
}
