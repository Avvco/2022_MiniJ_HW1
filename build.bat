set mypath=%cd%
@echo %mypath%
docker run -it --rm -v %mypath%:/tmp -w /tmp knordman/bison-flex-builder make clean
docker run -it --rm -v %mypath%:/tmp -w /tmp knordman/bison-flex-builder make debug
docker run -it --rm -v %mypath%:/tmp -w /tmp knordman/bison-flex-builder flex -o minij_lex.c minij_lex.l
docker run -it --rm -v %mypath%:/tmp -w /tmp knordman/bison-flex-builder gcc -c minij_lex.c
docker run -it --rm -v %mypath%:/tmp -w /tmp knordman/bison-flex-builder gcc -c minij_parse.c
docker run -it --rm -v %mypath%:/tmp -w /tmp knordman/bison-flex-builder gcc -c minij.c
docker run -it --rm -v %mypath%:/tmp -w /tmp knordman/bison-flex-builder gcc -o mjparse.exe minij.o minij_lex.o minij_parse.o
PAUSE