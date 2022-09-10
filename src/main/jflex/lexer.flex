package lyc.compiler;

import java_cup.runtime.Symbol;
import lyc.compiler.ParserSym;
import lyc.compiler.model.*;
import static lyc.compiler.constants.Constants.*;

%%

%public
%class Lexer
%unicode
%cup
%line
%column
%throws CompilerException
%eofval{
  return symbol(ParserSym.EOF);
%eofval}


%{
	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}
	private Symbol symbol(int type, Object value) {
		return new Symbol(type, yyline, yycolumn, value);
	}
%}


LineTerminator		=	\r|\n|\r\n
InputCharacter		= 	[^\r\n]
Identation			=	[ \t\f]

LETRA				=   [A-Za-z]
DIGITO				=   [0-9]

OP_MAS				=	"+"
OP_MENOS			= 	"-"
OP_MULT				=	"*"
OP_DIV				=	"/"
PUNTO_COMA			=	";"
ID					=	{LETRA} ({LETRA}|{DIGITO})*
CONST_INT			=	"0" | [1-9]{DIGITO}*
PARENTESIS_ABRE		=	"("
PARENTESIS_CIERRA	=	")"
OP_ASIGNACION		=	":="

%%


/* keywords */

<YYINITIAL> {
	{ID}				{System.out.println("Se retorna ID: \"" + yytext() + "\""); return symbol(ParserSym.ID, yytext()); }
    {PUNTO_COMA}		{System.out.println("Se retorna PUNTO_COMA: \"" + yytext() + "\""); return symbol(ParserSym.PUNTO_COMA, yytext()); }
    {CONST_INT}			{System.out.println("Se retorna CONST_INT: \"" + yytext() + "\""); return symbol(ParserSym.CONST_INT, yytext());}
    {PARENTESIS_ABRE}	{System.out.println("Se retorna PARENTESIS_ABRE: \"" + yytext() + "\""); return symbol(ParserSym.PARENTESIS_ABRE, yytext());}
    {PARENTESIS_CIERRA}	{System.out.println("Se retorna PARENTESIS_CIERRA: \"" + yytext() + "\""); return symbol(ParserSym.PARENTESIS_CIERRA, yytext());}
    {OP_ASIGNACION}		{System.out.println("Se retorna OP_ASIGNACION: \"" + yytext() + "\""); return symbol(ParserSym.OP_ASIGNACION, yytext());}
    {OP_MAS}			{System.out.println("Se retorna OP_MAS: \"" + yytext() + "\""); return symbol(ParserSym.OP_MAS, yytext());}
    {OP_MENOS}			{System.out.println("Se retorna OP_MENOS: \"" + yytext() + "\""); return symbol(ParserSym.OP_MENOS, yytext());}
    {OP_DIV}			{System.out.println("Se retorna OP_DIV: \"" + yytext() + "\""); return symbol(ParserSym.OP_DIV, yytext());}
	{OP_MULT}			{System.out.println("Se retorna OP_MULT: \"" + yytext() + "\""); return symbol(ParserSym.OP_MULT, yytext());}

	{Identation}								{ /* ignore */ }
}

/* error fallback */
	[^]											{ throw new UnknownCharacterException(yytext()); }
