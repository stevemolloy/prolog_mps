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
statement([Id1, Op, Id2]) --> statement(Id1), binop(Op), statement(Id2).
statement([Op, Id2]) --> unop(Op), statement(Id2).

statement(S) --> ws, seq("("), statement(S), seq(")"), ws.

binop(and)    --> "AND".
binop(or)     --> "OR".
binop(equals) --> "=".
unop(not)     --> "NOT".

