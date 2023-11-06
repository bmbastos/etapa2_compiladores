%{
    /*
    Integrantes do grupo V:
    - Bruno Marques Bastos (314518)
    - Gustavo Lopes Noll (cartão)
    */
    #include <stdio.h>
    int yylex(void);
    void yyerror (char const *mensagem);
%}
%{
#include <stdio.h>
%}

%token TK_PR_INT
%token TK_PR_FLOAT
%token TK_PR_BOOL
%token TK_PR_IF
%token TK_PR_ELSE
%token TK_PR_WHILE
%token TK_PR_RETURN
%token TK_OC_LE
%token TK_OC_GE
%token TK_OC_EQ
%token TK_OC_NE
%token TK_OC_AND
%token TK_OC_OR
%token TK_IDENTIFICADOR
%token TK_LIT_INT
%token TK_LIT_FLOAT
%token TK_LIT_FALSE
%token TK_LIT_TRUE
%token TK_ERRO


%%

programa: elementos
        ;

elementos: elementos elemento
         | elemento
         ;

elemento: declaracoes_globais
        | definicao_funcao
        ;

declaracoes_globais: declaracao_variaveis_globais
                 ;

declaracao_variaveis_globais: tipo lista_identificadores ';'
                        ;

tipo: TK_PR_INT
    | TK_PR_FLOAT
    | TK_PR_BOOL
    ;

lista_identificadores: TK_IDENTIFICADOR
                   | lista_identificadores ',' TK_IDENTIFICADOR
                   ;

definicao_funcao: cabecalho_funcao corpo_funcao
               ;

cabecalho_funcao: parametros TK_OC_GE tipo '!' TK_IDENTIFICADOR
               | tipo '!' TK_IDENTIFICADOR TK_OC_GE tipo '!' TK_IDENTIFICADOR
               ;

parametros: '(' lista_parametros ')'
          ;

lista_parametros: /* vazio */
               | parametro
               | lista_parametros ',' parametro
               ;

parametro: tipo TK_IDENTIFICADOR
         ;

corpo_funcao: '{' comandos '}'
            ;

comandos: comando
        | comandos comando
        ;

comando: /* vazio */ 
       | declaracao_variavel_local
       | atribuicao
       | condicao
       | repeticao
       | retorno
       | bloco_comandos
       | chamada_funcao_init
       ;


declaracao_variavel_local: tipo lista_identificadores ';'
                       ;

atribuicao: TK_IDENTIFICADOR '=' expressao ';'
         ;

condicao: TK_PR_IF '(' expressao ')' comando
        | TK_PR_IF '(' expressao ')' comando TK_PR_ELSE comando
        ;

repeticao: TK_PR_WHILE '(' expressao ')' comando
         ;

retorno: TK_PR_RETURN expressao ';'
       ;

bloco_comandos: '{' comandos '}'
             ;

chamada_funcao_init: TK_IDENTIFICADOR '(' argumentos ')' ';'
chamada_funcao: TK_IDENTIFICADOR '(' argumentos ')' 
             ;

argumentos: 
          | expressao
          | argumentos ',' expressao
          ;

expressao: expressao '<' expressao
         | expressao '>' expressao
         | expressao TK_OC_LE expressao
         | expressao TK_OC_GE expressao
         | expressao TK_OC_EQ expressao
         | expressao TK_OC_NE expressao
         | expressao TK_OC_AND expressao
         | expressao TK_OC_OR expressao
         | expressao '+' termo
         | expressao '-' termo
         | termo
         ;

termo: termo '*' fator
     | termo '/' fator
     | termo '%' fator
     | fator
     ;

fator: '-' fator %prec '-'
     | '!' fator %prec '!'
     | primario
     ;

primario: '(' expressao ')'
        | TK_IDENTIFICADOR
        | literais
        | chamada_funcao
        ;

literais: TK_LIT_INT
        | TK_LIT_FLOAT
        | TK_LIT_TRUE
        | TK_LIT_FALSE

%%
