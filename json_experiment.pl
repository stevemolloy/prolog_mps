:- use_module(library(http/json)).
:- use_module(library(dicts)).

fname_json(Filename, JSON_Term) :-
  open(Filename, read, Stream),
  json_read_dict(Stream, JSON_Term),
  close(Stream).

jsonfile_rfdumpinfo(Filename, RfJson) :-
  fname_json(Filename, JT),
  RfJson = JT.rfdump.
