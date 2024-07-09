:- module(parsing, [ast//1, ast_goal/4, asts_goals//1]).

:- use_module(library(dcgs)).
:- use_module(library(charsio)).
:- use_module(library(lists)).
:- use_module(library(assoc)).
:- use_module(library(clpb)).
:- use_module(library(reif)).

ws --> [W], { char_type(W, whitespace) }, !, ws.
ws --> [].

ast(T) --> term(T).
ast(and(Id1, Id2))    --> term(Id1), ws, "AND", ws, ast(Id2).
ast(or(Id1, Id2))     --> term(Id1), ws, "OR", ws, ast(Id2).
ast(equals(Id1, Id2)) --> term(Id1), ws, "=", ws, ast(Id2).

term(id(Id))  --> ident(Id).
term(not(Id)) --> ws, "NOT", ws, term(Id).
term(S)       --> ws, "(", ast(S), ")", ws.

ident([L|Ls])  --> ws, [L], { char_type(L, alpha)}, symbol(Ls), ws.
symbol([L|Ls]) --> [L], { char_type(L, ascii_graphic) }, symbol(Ls).
symbol([])     --> [].

ast_term(id(Id0), Id, A0, A) :-
  put_assoc(Id0, A0, _, A),
  get_assoc(Id0, A, Id).
ast_term(or(Tree1, Tree2), T, A0, A) :-
  T = T1 + T2,
  ast_term(Tree1, T1, A0, A1),
  ast_term(Tree2, T2, A1, A).
ast_term(and(Tree1, Tree2), T, A0, A) :-
  T = T1 * T2,
  ast_term(Tree1, T1, A0, A1),
  ast_term(Tree2, T2, A1, A).
ast_term(not(Tree), T, A0, A) :-
  T = ~T0,
  ast_term(Tree, T0, A0, A).

ast_goal(Ast, Goal, A0, A) :-
  ast_term(Ast, Term, A0, A),
  Goal = sat(Term).

asts_goals([]) --> [].
asts_goals([A | As]) --> {ast_goal(A, G)}, [G], asts_goals(As).

