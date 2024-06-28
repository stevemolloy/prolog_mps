:- module(parsing, [statement//1, ast_clpbchars//2, clpbchars_satterm/2]).

:- use_module(library(dcgs)).
:- use_module(library(charsio)).
:- use_module(library(lists)).
:- use_module(library(assoc)).
:- use_module(library(clpb)).

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

ast_clpbchars(id(Id0), A0) --> {get_assoc(Id0, A0, Id)}, Id.
ast_clpbchars(not(T1), A0) --> {ast_clpbchars(T1, A0, Expr1)}, "( ~ ", Expr1, " )".
ast_clpbchars(or(T1, T2), A0) --> 
  {
    phrase(ast_clpbchars(T1, A0), Expr1),
    phrase(ast_clpbchars(T2, A0), Expr2)
  },
  "(", Expr1, " + ", Expr2, ")".
ast_clpbchars(and(T1, T2), A0) --> 
  {
    phrase(ast_clpbchars(T1, A0), Expr1),
    phrase(ast_clpbchars(T2, A0), Expr2)
  },
  "(", Expr1, " * ", Expr2, ")".

clpbchars_satterm(C, T) :-
  phrase(("sat(", C, ")."), S),
  read_from_chars(S, T).

