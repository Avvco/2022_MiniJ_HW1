%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "minij.h"
	#include "minij_parse.h"
%}

%token CLASS PUB STATIC
%left  AND OR
%left  EQ NE LT GT LE GE
%left  ADD MINUS
%left  DIV TIMES
%token LBP RBP LSP RSP LP RP
%token INT BOOL NOT
%token IF ELSE
%token WHILE PRINT
%token ASSIGN
%token VOID MAIN STR
%token RETURN
%token SEMI COMMA
%token THIS NEW DOT
%token ID LIT TRUE FALSE
%token COMMENT

%expect 0

%%
prog	:	mainc cdcls
		{ printf("Program -> MainClass ClassDecl*\n");
		  printf("Parsed OK!\n"); }
	|
		{ printf("****** Parsing failed!\n"); }
	;

mainc	:	CLASS ID LBP PUB STATIC VOID MAIN LP STR LSP RSP ID RP LBP stmts RBP RBP
		{ printf("MainClass -> class id { public static void main ( string [ ] id ) {Statements*} }\n"); }
	;

cdcls	:	cdcl cdcls
		{ printf("(for ClassDecl*) cdcls : cdcl cdcls\n"); }
	|
		{ printf("(for ClassDecl*) cdcls : \n"); }
	;

cdcl	:	CLASS ID LBP vdcls mdcls RBP
		{ printf("ClassDecl -> class id { VarDecl* MethodDecl* }\n"); }
	;

vdcls	:	vdcl vdcls
		{ printf("(for VarDecl*) vdcls : vdcl vdcls\n"); }
	|
		{ printf("(for VarDecl*) vdcls : \n"); }
	;

vdcl	:	type ID SEMI
		{ printf("VarDecl -> Type id ;\n"); }
	;

mdcls	:	mdcl mdcls
		{ printf("(for MethodDecl*) mdcls : mdcl mdcls\n"); }
	|
		{ printf("(for MethodDecl*) mdcls : \n"); }
	;

mdcl	:	PUB type ID LP formals RP LBP vdcls stmts RETURN exp SEMI RBP
		{ printf("MethodDecl -> public Type id ( FormalList ) { Statements* return Exp ; }\n"); }
	;

formals	:	type ID frest
		{ printf("FormalList -> Type id FormalRest*\n"); }
	|
		{ printf("FormalList -> \n"); }
	;

frest	:	COMMA type ID frest
		{ printf("FormalRest -> , Type id FormalRest\n"); }
	|
		{ printf("FormalRest -> \n"); }
	;

type    : INT LSP RSP
		{ printf("Type -> int []\n"); }

        |   BOOL
		{ printf("Type -> bool\n"); }

        |   INT
		{ printf("Type -> int\n"); }

        |   ID
		{ printf("Type -> id\n"); }
    ;

stmts :	stmt stmts
		{ printf("(for Statements*) stmts : stmt stmts\n"); }
	;
stmt  :	LBP stmts RBP
		{ printf("Stmt -> {stmts}\n"); }

        |   IF LP exp RP stmt ELSE stmt
		{ printf("Stmt -> if(exp) stmts else stmts\n"); }

        |   WHILE LP exp RP stmt
		{ printf("Stmt -> while(exp) stmt\n"); }

        |   PRINT LP exp RP SEMI
		{ printf("Stmt -> print(exp) ;\n"); }

        |   ID ASSIGN exp SEMI
		{ printf("Stmt -> id = exp ;\n"); }

        |   ID LSP exp RSP ASSIGN exp SEMI
		{ printf("Stmt -> id[exp] = exp;\n"); }

        |   vdcl
		{ printf("Stmt -> vdcls\n"); }

        |
		{ printf("Stmt -> \n"); }
    ;

exp     :exp ADD exp
		{ printf("Exp -> Exp + Exp \n"); }

        |   exp MINUS exp
		{ printf("Exp -> Exp - Exp \n"); }

        |   exp TIMES exp
		{ printf("Exp -> Exp * Exp \n"); }

        |   exp AND exp
		{ printf("Exp -> Exp && Exp \n"); }

        |   exp OR exp
		{ printf("Exp -> Exp || Exp \n"); }

        |   exp LT exp
		{ printf("Exp -> Exp < Exp \n"); }

        |   exp LE exp
		{ printf("Exp -> Exp <= Exp \n"); }

        |   exp EQ exp
		{ printf("Exp -> Exp == Exp \n"); }

        |   ID LSP exp RSP
		{ printf("Exp -> [ Exp ]\n"); }

        |   ID LP exp RP
		{ printf("Exp -> id ( Exp )\n"); }

        |   LP exp RP
		{ printf("Exp -> ( Exp )\n"); }

        |   exp DOT exp
		{ printf("Exp -> Exp.Exp\n"); }

        |   LIT
		{ printf("Exp -> LIT\n"); }

        |   TRUE
		{ printf("Exp -> TRUE\n"); }

        |   FALSE
		{ printf("Exp -> FALSE\n"); }

        |   ID
		{ printf("Exp -> ID\n"); }

        |   THIS
		{ printf("Exp -> THIS\n"); }

        |   NEW INT LSP exp RSP
		{ printf("Exp -> new INT [ Exp ]\n"); }

        |   NEW ID LP RP
		{ printf("Exp -> new ID ( )\n"); }

        |   NOT exp
		{ printf("Exp -> ! Exp\n"); }

	  |
		{ printf("Exp -> \n"); }
    ;


explist : exp exprests
		{ printf("exp list -> exprest*\n"); }

		|
        { printf("ExpList ->\n"); }
    ;

exprests :	exprest exprests
		{ printf("(for exprest*) exprests : exprest exprests\n"); }
	|
		{ printf("(for exprest*) exprest : \n"); }
	;
exprest  : 	COMMA exp
		{ printf("exprest -> , exp\n"); }
    ;
// Practice on writing the grammar rules for
// 1. type
// 2. statement
// 3. exp
// 4. explist
// 5. exprest
// (see the description in Programming Assignment #1)

%%

int yyerror(char *s)
{
	printf("%s\n",s);
	return 1;
}

