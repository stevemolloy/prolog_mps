:- use_module(library(dcgs)).
:- use_module(library(charsio)).

ws --> [W], { char_type(W, whitespace) }, ws.
ws --> [].

ident([L|Ls])  --> ws, [L], { char_type(L, alpha)}, symbol(Ls), ws.
symbol([L|Ls]) --> [L], { char_type(L, ascii_graphic) }, symbol(Ls).
symbol([])     --> [].

statement([Id1, Op, Id2]) --> ident(Id1), binop(Op), ident(Id2).
statement([Id1, Op, Id2]) --> ident(Id1), equalop(Op), ident(Id2).
statement([Op, Id2]) --> unop(Op), ident(Id2).

binop(and) --> seq(Ws), { Ws="AND" }.
binop(or) --> seq(Ws), { Ws="OR" }.
unop(not) --> seq(Ws), { Ws="NOT" }.

equalop(testequals) --> seq(Ws), { Ws="="}.

