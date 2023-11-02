# Etapa2: Compiladores

> **Início**: 26 de outubro de 2023.

> **Fim**: 13 de novembro de 2023

[Regras da etapa 2](https://moodle.ufrgs.br/pluginfile.php/6321067/mod_resource/content/9/E2.pdf)

[Regras gerais de projeto](https://moodle.ufrgs.br/pluginfile.php/6321006/mod_resource/content/3/Projeto.pdf)

Primeiramente o bison
Depois o flex
Compilar arquivos '.c' gerados por parser.y e scanner.l
    gcc - lex.yy.c parser.tab.c main.c
    gcc -o parser lex.yy.o parser.tab.o -lfl

scanner.l deve incluir "parser.tab.h"