# Integrantes do grupo V:
# Bruno Marques Bastos (314518)
# Gustavo Lopes Noll (322864)

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
$(EXECUTABLE): $(OBJECTS)
	$(CC) $(CFLAGS) -o $(EXECUTABLE) $(OBJECTS)

parser.tab.c: parser.y
	bison -d parser.y

lex.yy.c: scanner.l
	flex scanner.l

main.o: main.c
	$(CC) $(CFLAGS) -c main.c

functions.o: functions.c
	$(CC) $(CFLAGS) -c functions.c

clean:
	rm -f $(OBJECTS) $(EXECUTABLE) parser.tab.*