:- module(parsing, [ast//3, ast_goal/3, astlist//3, goallist//2]).

:- use_module(library(dcgs)).
:- use_module(library(charsio)).
:- use_module(library(lists)).
:- use_module(library(assoc)).
:- use_module(library(clpb)).
:- use_module(library(reif)).

ws --> [W], { char_type(W, whitespace) }, !, ws.
ws --> [].

ast(T, A0, A)                --> term(T, A0, A).
ast(and(Id1, Id2), A0, A)    --> term(Id1, A0, A1), ws, "AND", ws, ast(Id2, A1, A).
ast(or(Id1, Id2), A0, A)     --> term(Id1, A0, A1), ws, "OR", ws, ast(Id2, A1, A).
ast(equals(Id1, Id2), A0, A) --> term(Id1, A0, A1), ws, "=", ws, ast(Id2, A1, A).

term(id(Id), A0, A)  --> ident(Id), {put_assoc(Id, A0, _, A)}.
term(not(Id), A0, A) --> ws, "NOT", ws, term(Id, A0, A).
term(S, A0, A)       --> ws, "(", ast(S, A0, A), ")", ws.

ident([L|Ls])  --> ws, [L], { char_type(L, alpha)}, symbol(Ls), ws.
symbol([L|Ls]) --> [L], { char_type(L, ascii_graphic) }, symbol(Ls).
symbol([])     --> [].

ast_term(id(Id0), Assoc, Id) :-
  get_assoc(Id0, Assoc, Id).
ast_term(or(Tree1, Tree2), Assoc, T1 + T2) :-
  ast_term(Tree1, Assoc, T1),
  ast_term(Tree2, Assoc, T2).
ast_term(and(Tree1, Tree2), Assoc, T1 * T2) :-
  ast_term(Tree1, Assoc, T1),
  ast_term(Tree2, Assoc, T2).
ast_term(not(Tree), Assoc, T) :-
  T = ~T0,
  ast_term(Tree, Assoc, T0).

ast_goal(Ast, Assoc, Goal) :-
  ast_term(Ast, Assoc, Term),
  Goal = sat(~ Term).

astlist([Cond | Conds], A0, A) --> {phrase(ast(Ast, A0, A1), Cond)}, [Ast], astlist(Conds, A1, A).
astlist([], A, A) --> [].

goallist([Ast | Asts], A) --> {ast_goal(Ast, A, Goal)}, [Goal], goallist(Asts, A).
goallist([], _) --> [].

