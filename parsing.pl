:- module(parsing, [statement//1]).

:- use_module(library(dcgs)).
:- use_module(library(charsio)).

ws --> [W], { char_type(W, whitespace) }, !, ws.
ws --> [].

statement(T) --> term(T).
statement([Id1, Op, Id2]) --> term(Id1), binop(Op), statement(Id2).

term(Id)        --> ident(Id).
term([Unop,Id]) --> unop(Unop), term(Id).
term(S)         --> ws, "(", statement(S), ")", ws.

ident([L|Ls])  --> ws, [L], { char_type(L, alpha)}, symbol(Ls), ws.
symbol([L|Ls]) --> [L], { char_type(L, ascii_graphic) }, symbol(Ls).
symbol([])     --> [].

binop(and)    --> ws, "AND", ws.
binop(or)     --> ws, "OR", ws.
binop(equals) --> ws, "=", ws.
unop(not)     --> ws, "NOT", ws.

