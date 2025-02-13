#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <regex>

using namespace std;

int main() {

    string nombreArchivo;
    cout << "Ingrese el nombre del archivo de texto: ";
    getline(cin, nombreArchivo);


    ifstream archivo(nombreArchivo);
    if (!archivo.is_open()) {
        cout << "No se pudo abrir el archivo." << endl;
        return 1;
    }


    string contenido((istreambuf_iterator<char>(archivo)), istreambuf_iterator<char>());
    archivo.close();


    int totalConEspacios = contenido.size();

    string sinEspacios;
    for (char c : contenido) {
        if (c != ' ')
            sinEspacios.push_back(c);
    }
    int totalSinEspacios = sinEspacios.size();


    int totalLexemas = 0, totalNumeros = 0, totalPalabras = 0, totalCompuestas = 0;


    regex regexNumero("^[0-9]+$");
    regex regexPalabra("^[A-Za-z]+$");
    regex regexCompuesta("^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]+$");


    stringstream ss(contenido);
    string token;
    while (ss >> token) {
        totalLexemas++;

        if (regex_match(token, regexNumero)) {
            totalNumeros++;
        } else if (regex_match(token, regexPalabra)) {
            totalPalabras++;
        } else if (regex_match(token, regexCompuesta)) {
            totalCompuestas++;
        }
    }


    cout << "Total de caracteres (con espacios): " << totalConEspacios << endl;
    cout << "Total de caracteres (sin espacios): " << totalSinEspacios << endl;
    cout << "Total de lexemas: " << totalLexemas << endl;
    cout << "Total de palabras: " << totalPalabras << endl;
    cout << "Total de números: " << totalNumeros << endl;
    cout << "Total de combinadas: " << totalCompuestas << endl;

    return 0;
}