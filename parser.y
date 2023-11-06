%{
    /*
    Integrantes do grupo V:
    - Bruno Marques Bastos (314518)
    - Gustavo Lopes Noll (cartão)
    */
    
    int yylex(void);
    void yyerror (char const *mensagem);
%}

%define parse.error verbose

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

%start programa

%%
tipo:                       TK_PR_INT | TK_PR_FLOAT | TK_PR_BOOL;                                   /* Regras para variaveis globais */
id:                         TK_IDENTIFICADOR;
lista_variaveis_globais:     | ',' id lista_variaveis_globais;
variavel_global:            tipo id lista_variaveis_globais ';';

lista_parametros:           ',' tipo id lista_parametros                                            /* Regras para cabeçalhos funções */
                            |
cabecalho_funcao:           '(' lista_parametros ')' TK_OC_GE tipo '!'
                            | '(' tipo id lista_parametros ')' TK_OC_GE tipo '!';




                                                                                                    /* FOCAR NESSA PARTE */
termo:                      fator
                            | termo '*' fator
                            | termo '/' fator
                            | termo '%' fator
fator:                      id | '(' expressao ')';
literais:                   TK_LIT_INT | TK_LIT_FLOAT | TK_LIT_TRUE | TK_LIT_FALSE;
operandos:                  id
                            | literais
                            | chamada_funcao
operador_unario:            '-' | '!';
operador_binario:           '*' | '/' | '%' | '+' | '-' | '<' | '>' | TK_OC_LE | TK_OC_GE | TK_OC_EQ | TK_OC_NE | TK_OC_AND | TK_OC_OR; 
expressao:                  termo
                            | operador_unario termo






fluxo_condicional:          TK_PR_IF '(' expressao ')' corpo_funcao                                 /* Regras de controle de fluxo */
                            | TK_PR_IF '(' expressao ')' corpo_funcao TK_PR_ELSE corpo_funcao
fluxo_iterativo:            TK_PR_WHILE '(' expressao ')' '{' bloco_comandos '}'
controle_fluxo:             fluxo_condicional | fluxo_iterativo;
retorno:                    TK_PR_RETURN expressao                                                  /* Regra retorno */
lista_argumentos:           id lista_argumentos                                                     /* Regra chamada de função */
                            | expressao lista_argumentos
                            | 
argumentos:                 id lista_argumentos 
                            | expressao lista_argumentos
chamada_funcao:             id '(' argumentos ')'
atribuicao:                 id '=' expressao                                                        /* Regra atribuição */
lista_variaveis_locais:      | ',' id lista_variaveis_locais                                        /* Regra declaração de variaveis */
variavel_local:             tipo id lista_variaveis_locais

bloco_comandos:             comando_simples ';' bloco_comandos                                      /* Regra de bloco de comandos */
                            | 
comando_simples:            variavel_local                                                          /* Regra dos comandos simples */
                            | atribuicao
                            | chamada_funcao
                            | retorno
                            | controle_fluxo
corpo_funcao:               '{' comando_simples '}'                                                 /* Regra corpo da função */
funcoes:                    cabecalho_funcao corpo_funcao;                                          /* Regra de definição de função */

programa:                   | variavel_global programa | funcoes programa;                          /* ARRUMAR para aceitar qualquer ordem */


%%