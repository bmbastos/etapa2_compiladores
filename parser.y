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

%token comma ","
%token semicolon ";"

%start programa

%%

programa: variavel_global

tipo: TK_PR_INT | TK_PR_FLOAT | TK_PR_BOOL;                                                                             /* Regras para variaveis globais */
id: TK_IDENTIFICADOR;
lista_variaveis_globais: id | id comma lista_variaveis_globais;
variavel_global: tipo lista_variaveis_globais semicolon

abertura_parenteses: "(";                                                                                               /* Regras para funções */
fechamento_parenteses: ")";
abertura_chaves: "{"
fechamento_chaves: "}";
lista_parametros: | tipo id | tipo id lista_parametros;
bloco_comandos: '{' comandos_simples '}'
funcoes: tipo TK_IDENTIFICADOR abertura_parenteses lista_parametros fechamento_parenteses bloco_comandos ;

literais_numericos: TK_LIT_INT | TK_LIT_FLOAT;
literais_logicos: TK_LIT_TRUE | TK_LIT_FALSE;
operandos: id | literais_numericos | literais_logicos | funcoes;
operadores: 
expressao: 
atribuicao: id '=' expressao;
comandos: variavel_global | atribuicao |

%%