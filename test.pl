:- use_module(library(dcgs)).
:- use_module(library(format)).
:- use_module(library(charsio)).

term(Str) --> [Var], { phrase(format_("~s", [Var]), Str) }.
expression(Str) --> [not], expression(T), { phrase(format_("~~~s", [T]), Str) }.
expression(Str) --> term(Str).
expression(Str) --> term(T1), keyword(K), term(T2), { phrase(format_("~s ~s ~s", [T1, K, T2]), Str) }.

keyword("*") --> [and].
keyword("+") --> [or].

