%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    int yyerror(const char *s) {
        fprintf(stderr, "Error: %s\n", s);
        return 0;
    }
%}

%token NUMBER PLUS MINUS TIMES DIVIDE EOL
%start statements

%%

statements:
      statements statement
    | statement
    ;

statement:
      expression EOL        { printf("= %d\n", $1); }
    ;

expression:
      NUMBER                { $$ = $1; printf("number: %d\n", $$); }

    | expression TIMES expression
                            { $$ = $1 * $3; printf("* %d\n", $$); }

    ;

%%

int main(void) {
    return yyparse();
}
