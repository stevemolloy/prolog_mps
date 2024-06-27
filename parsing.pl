:- module(parsing, [statement//1, ast_clpbexpr/2]).

:- use_module(library(dcgs)).
:- use_module(library(charsio)).
:- use_module(library(lists)).

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

ast_clpbexpr(id(Id), Id).
ast_clpbexpr(not(T1), Expr) :-
  ast_clpbexpr(T1, Expr1),
  append(["( ~ ", Expr1, " )"], Expr).
ast_clpbexpr(or(T1, T2), Expr) :-
  ast_clpbexpr(T1, Expr1),
  ast_clpbexpr(T2, Expr2),
  append(["(", Expr1, " + ", Expr2, ")"], Expr).
ast_clpbexpr(and(T1, T2), Expr) :-
  ast_clpbexpr(T1, Expr1),
  ast_clpbexpr(T2, Expr2),
  append(["(", Expr1, " * ", Expr2, ")"], Expr).

