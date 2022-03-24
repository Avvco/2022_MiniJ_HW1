%{
#include "minij.h"
#include "minij_parse.h"
%}

ID  [A-Za-z][A-Za-z0-9_]*
LIT [0-9][0-9]*
NONNL [^\n]

%%

class			{return CLASS;}
public			{return PUB;}
static			{return STATIC;}
String			{return STR;}
void			{return VOID;}
main			{return MAIN;}
int			{return INT;}
if			{return IF;}
else			{return ELSE;}
while			{return WHILE;}
new			{return NEW;}
return			{return RETURN;}
this			{return THIS;}
true			{return TRUE;}
false			{return FALSE;}
"&&"			{return AND;}
"<"			{return LT;}
"<="			{return LE;}
"+"			{return ADD;}
"-"			{return MINUS;}
"*"			{return TIMES;}
"("			{return LP;}
")"			{return RP;}
"{"			{return LBP;}
"}"			{return RBP;}
","			{return COMMA;}
"."			{return DOT;}

// Practice on writing the lexical rules for
// 1. PRINT (System.Out.println)
// 2. OR (||)
// 3. EQ (==)
// 4. LSP ([)
// 5. RSP (])
// 6. SEMI (;)
// 7. ASSIGN (=)
// 8. COMMENT (see the description in Programming Assignment #1)
// 9. ID (see the description in Programming Assignment #1)
// 10. LIT (see the description in Programming Assignment #1)

System.Out.println              {return PRINT;}
"||"                            {return OR;}
"=="                            {return EQ;}
"["                             {return LSP;}
"]"                             {return RSP;}
";"                             {return SEMI;}
"="                             {return ASSIGN;}
"//"                            {return COMMENT;}
[A-Za-z][A-Za-z0-9_]*           {return ID;}
[0-9][0-9]*                     {return LIT;}
[ \t\n]			{/* skip BLANK */}
.			{/* skip redundant characters */}

%%

int yywrap() {return 1;}

