:- use_module(library(dcgs)).
:- use_module(library(pio)).
:- use_module(library(assoc)).
:- use_module(library(pairs)).
:- use_module(library(debug)).

:- use_module(parsing).

assocs_vars([]) --> [].
assocs_vars([A | As]) --> { assoc_to_values(A, Vals) }, Vals, assocs_vars(As).

topjson_assoc_satpreds(Json, Assoc, Satpreds) :-
  json_attribute_value(Json, "rfdump", R),  % Drill down to "rfdump"
  json_attribute_value(R, _, V),            % Then to its child objects
  json_attribute_value(V, "conditions", C), % Finally, find the condition statements
  phrase(statement(S), C),                  % Parse these into an AST
  empty_assoc(A0),                          % Keep the assoc list for reference later
  phrase(ast_clpbchars(S, A0, Assoc), CC),  % From the AST to character strings
  phrase(clpbchars_satchars(CC), Satpreds). % Wrap these strings inside sat predicates

run :-
  json(J),
  findall(Assoc-S, topjson_assoc_satpreds(J, Assoc, S), Solutions),
  pairs_keys_values(Solutions, As, S),
  phrase(assocs_vars(As), Vals),
  sort(Vals, Sortedvals),
  phrase_to_file(string_to_write("experiment", S, Sortedvals), "testingtesting.pl").


