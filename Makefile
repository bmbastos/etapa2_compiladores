# Integrantes do grupo V:
# Bruno Marques Bastos (314518)
# Gustavo Lopes Noll (cartão)

# Makefile para compilar o analisador léxico

# Compilador a ser usado
CC = gcc

# Opções de compilação
CFLAGS = -Wall -Wextra

# Nome do executável
EXECUTABLE = etapa2

# Listagem de arquivos fonte
SOURCES = parser.y main.c

# Objetos gerados
OBJECTS = lex.yy.c main.o functions.o

# Alvo padrão
all: $(EXECUTABLE)

parser.tab.h: parser.y
	bison -d parser.y

main.o: main.c
	$(CC) $(CFLAGS) -c main.c

clean:
	rm -f $(OBJECTS) $(EXECUTABLE) parser.tab.h
