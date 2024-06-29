:- module(parsing, [statement//1, ast_clpbchars//1, clpbchars_satchars//1]).

:- use_module(library(dcgs)).
:- use_module(library(charsio)).
:- use_module(library(lists)).
:- use_module(library(assoc)).
:- use_module(library(clpb)).
:- use_module(library(reif)).

ws --> [W], { char_type(W, whitespace) }, !, ws.
ws --> [].

statement(T) --> term(T).
statement(and(Id1, Id2))    --> term(Id1), ws, "AND", ws, statement(Id2).
statement(or(Id1, Id2))     --> term(Id1), ws, "OR", ws, statement(Id2).
statement(equals(Id1, Id2)) --> term(Id1), ws, "=", ws, statement(Id2).

term(id(Id))  --> ident(Id).
term(not(Id)) --> ws, "NOT", ws, term(Id).
term(S)       --> ws, "(", statement(S), ")", ws.

ident([L|Ls])  --> ws, [L], { char_type(L, alpha)}, symbol(Ls), ws.
symbol([L|Ls]) --> [L], { char_type(L, ascii_graphic) }, symbol(Ls).
symbol([])     --> [].

ast_clpbchars(id(Id0)) --> { tfilter(dif(.), Id0, Id) }, Id.
ast_clpbchars(not(T1)) --> "( ~ ", ast_clpbchars(T1), " )".
ast_clpbchars(or(T1,T2)) -->
        "(", ast_clpbchars(T1), " + ", ast_clpbchars(T2), ")".
ast_clpbchars(and(T1,T2)) -->
        "(", ast_clpbchars(T1), " * ", ast_clpbchars(T2), ")".

clpbchars_satchars(C) --> "sat(", C, ").".

