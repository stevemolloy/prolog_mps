:- use_module(library(dcgs)).
:- use_module(library(format)).
:- use_module(library(lists)).

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

