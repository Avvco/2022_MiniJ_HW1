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

%expect 42

%%
prog	:	mainc cdcls
		{ printf("Program -> MainClass ClassDecl*\n");
		  printf("Parsed OK!\n"); }
	|
		{ printf("****** Parsing failed!\n"); }
	;

mainc	:	CLASS ID LBP PUB STATIC VOID MAIN LP STR LSP RSP ID RP LBP stmts RBP RBP
		{ printf("MainClass -> class id lbp public static void main lp string lsp rsp id rp lbp Statemet* rbp rbp\n"); }
	;

cdcls	:	cdcl cdcls
		{ printf("(for ClassDecl*) cdcls : cdcl cdcls\n"); }
	|
		{ printf("(for ClassDecl*) cdcls : \n"); }
	;

cdcl	:	CLASS ID LBP vdcls mdcls RBP
		{ printf("ClassDecl -> class id lbp VarDecl* MethodDecl* rbp\n"); }
	;

vdcls	:	vdcl vdcls
		{ printf("(for VarDecl*) vdcls : vdcl vdcls\n"); }
	|
		{ printf("(for VarDecl*) vdcls : \n"); }
	;

vdcl	:	type ID SEMI
		{ printf("VarDecl -> Type id semi\n"); }
	;

mdcls	:	mdcl mdcls
		{ printf("(for MethodDecl*) mdcls : mdcl mdcls\n"); }
	|
		{ printf("(for MethodDecl*) mdcls : \n"); }
	;

mdcl	:	PUB type ID LP formals RP LBP vdcls stmts RETURN exp SEMI RBP
		{ printf("MethodDecl -> public Type id lp FormalList rp lbp Statements* return Exp semi rbp\n"); }
	;

formals	:	type ID frest
		{ printf("FormalList -> Type id FormalRest*\n"); }
	|
		{ printf("FormalList -> \n"); }
	;

frest	:	COMMA type ID frest
		{ printf("FormalRest -> comma Type id FormalRest\n"); }
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

		|
        { printf("Type ->\n"); }
    ;

stmts :	stmt stmts
		{ printf("(for VarDecl*) stmts : stmt stmts\n"); }
	|
		{ printf("(for VarDecl*) stmts : \n"); }
	;
stmt   :LBP stmts RBP
		{ printf("Stmts -> {Stmts}\n"); }

        |   IF LP exp RP stmts ELSE stmts
		{ printf("Stmts -> if(exp) Stmts else Stmts\n"); }

        |   WHILE LP exp RP stmts
		{ printf("Stmts -> while(Exp) Stmts\n"); }

        |   PRINT LP exp RP SEMI
		{ printf("Stmts -> print(Exp) semi\n"); }

        |   ID ASSIGN exp SEMI
		{ printf("Stmts -> id = Exp semi\n"); }

        |   ID LSP exp RSP ASSIGN exp SEMI
		{ printf("Stmts -> id[Exp] = Exp semi\n"); }

        |   vdcls
		{ printf("Stmts -> Vdcls\n"); }

        |
		{ printf("Stmts -> \n"); }
    ;

exp     :exp ADD exp
		{ printf("Exp -> Exp + Exp\n"); }

        |   exp MINUS exp
		{ printf("Exp -> Exp - Exp\n"); }

        |   exp TIMES exp
		{ printf("Exp -> Exp * Exp\n"); }

        |   exp AND exp
		{ printf("Exp -> Exp && Exp\n"); }

        |   exp OR exp
		{ printf("Exp -> Exp || Exp\n"); }

        |   exp LT exp
		{ printf("Exp -> Exp < Exp\n"); }

        |   exp LE exp
		{ printf("Exp -> Exp <= Exp\n"); }

        |   exp EQ exp
		{ printf("Exp -> Exp == Exp\n"); }

        |   ID LSP exp RSP
		{ printf("Exp -> [Exp]\n"); }

        |   ID LP exp RP
		{ printf("Exp -> (Exp)\n"); }

        |   LP exp RP
		{ printf("Exp -> (Exp)\n"); }

        |   exp DOT exp
		{ printf("Exp -> Exp.Exp\n"); }

        |   LIT
		{ printf("Exp -> lit\n"); }

        |   TRUE
		{ printf("Exp -> true\n"); }

        |   FALSE
		{ printf("Exp -> false\n"); }

        |   ID
		{ printf("Exp -> id\n"); }

        |   THIS
		{ printf("Exp -> this\n"); }

        |   NEW INT LSP exp RSP
		{ printf("Exp -> new int[Exp]\n"); }

        |   NEW ID LP RP
		{ printf("Exp -> new id()\n"); }

        |   NOT exp
		{ printf("Exp -> not Exp\n"); }

		|
		{ printf("Exp -> \n"); }
    ;


explist : exp exprests
		{ printf("ExpList -> Exprest*\n"); }

		|
        { printf("ExpList ->\n"); }
    ;

exprests	:	exprest exprests
		{ printf("(for Exprest*) exprests : exprest exprests\n"); }
	|
		{ printf("(for Exprest*) exprest : \n"); }
	;
exprest : COMMA exp
		{ printf("exprest -> comma Exp\n"); }
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

