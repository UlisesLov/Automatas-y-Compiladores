#include <iostream>
#include <cctype>
#include <string>
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
    for (char c : cadena) {
        if (!isalnum(c)) return false;
    }
    return true;
}

string clasificarCadena(const string& cadena) {
    if (esNumeroEntero(cadena)) return "Número entero";
    if (esPalabra(cadena)) return "Palabra";
    if (esCompuesta(cadena)) return "Compuesta";
    return "No clasificada";
}

int main() {
    string cadena;
    cout << "Ingrese una cadena: ";
    cin >> cadena;
    cout << clasificarCadena(cadena) << endl;
    return 0;
}