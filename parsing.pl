:- use_module(library(dcgs)).
:- use_module(library(charsio)).

ws --> [W], { char_type(W, whitespace) }, ws.
ws --> [].

ident([L|Ls])  --> [L], { char_type(L, alpha)}, symbol(Ls).
symbol([L|Ls]) --> [L], { char_type(L, ascii_graphic) }, symbol(Ls).
symbol([])     --> [].

statement([Id1, Op, Id2]) --> ws, ident(Id1), ws, binop(Op), ws, ident(Id2), ws.
statement([Id1, Op, Id2]) --> ws, ident(Id1), ws, equalop(Op), ws, ident(Id2), ws.
statement([Id1, Op, Id2]) --> ws, unop(Op), ws, ident(Id2), ws.

binop(Ws) --> seq(Ws), { Ws="AND" }.
binop(Ws) --> seq(Ws), { Ws="OR" }.
unop(Ws) --> seq(Ws), { Ws="NOT" }.

equalop(Ws) --> seq(Ws), { Ws="="}.

