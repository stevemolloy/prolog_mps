:- use_module(library(dcgs)).
:- use_module(library(charsio)).

ws --> [W], { char_type(W, whitespace) }, ws.
ws --> [].

ident([L|Ls])  --> [L], { char_type(L, alpha)}, symbol(Ls).
symbol([L|Ls]) --> [L], { char_type(L, ascii_graphic) }, symbol(Ls).
symbol([])     --> [].

statement([Id1, Op, Id2]) --> ident(Id1), ws, operator(Op), ws, ident(Id2).

operator(Ws) --> seq(Ws), { Ws="AND" }.
operator(Ws) --> seq(Ws), { Ws="OR" }.

