:- use_module(library(dcgs)).
:- use_module(library(pio)).
:- use_module(library(assoc)).
:- use_module(library(debug)).

:- use_module(parsing).

topjson_assoc_satpreds(Json, Assoc, Satpreds) :-
  json_attribute_value(Json, "rfdump", R),  % Drill down to "rfdump"
  json_attribute_value(R, _, V),            % Then to its child objects
  json_attribute_value(V, "conditions", C), % Finally, find the condition statements
  phrase(statement(S), C),                  % Parse these into an AST
  empty_assoc(A0),                          % Keep the assoc list for reference later
  phrase(ast_clpbchars(S, A0, Assoc), CC),  % From the AST to character strings
  phrase(clpbchars_satchars(CC), Satpreds). % Wrap these strings inside sat predicates

% This is still not working.
main :- 
  json(J),
  findall(Assoc-S, topjson_assoc_satpreds(J, Assoc, S), Solutions),
  pairs_keys_values(Solutions, A),
  phrase_to_file(string_to_write("experiment", Solutions, A), "testingtesting.pl").


