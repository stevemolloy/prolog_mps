:- use_module(library(dcgs)).
:- use_module(library(charsio)).
:- use_module(library(tabling)).
:- table statement/3.

ws --> [W], { char_type(W, whitespace) }, ws.
ws --> [].

ident([L|Ls])  --> ws, [L], { char_type(L, alpha)}, symbol(Ls), ws.
symbol([L|Ls]) --> [L], { char_type(L, ascii_graphic) }, symbol(Ls).
symbol([])     --> [].

statement(Id) --> ident(Id).
statement([Unop, Id]) --> unop(Unop), statement(Id).
statement([Id1, Op, Id2]) --> statement(Id1), binop(Op), statement(Id2).

statement(S) --> ws, seq("("), statement(S), seq(")"), ws.

binop(and)    --> ws, "AND", ws.
binop(or)     --> ws, "OR", ws.
binop(equals) --> ws, "=", ws.
unop(not)     --> ws, "NOT", ws.

