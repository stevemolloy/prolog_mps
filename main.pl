:- use_module(library(dcgs)).
:- use_module(library(pio)).
:- use_module(library(assoc)).
:- use_module(library(pairs)).
:- use_module(library(debug)).

:- use_module(parsing).

run :-
  json(J),
  findall(A-G, topjson_assoc_goal(J, A, G), Solutions).

