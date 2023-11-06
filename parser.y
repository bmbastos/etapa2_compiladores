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
tipo: TK_PR_INT | TK_PR_FLOAT | TK_PR_BOOL;                                                                             /* Regras para variaveis globais */
id: TK_IDENTIFICADOR;
lista_variaveis_globais: ',' id lista_variaveis_globais | ';';
variavel_global: tipo id lista_variaveis_globais;


programa: variavel_global;


%%