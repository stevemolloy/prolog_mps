json({a: 1, b: {c: 2, d:3}, e: 4}).

json_list({}) --> [].
json_list({A}) --> and_list(A).

and_list((A,B)) --> !, [A], and_list(B).
and_list(Last)  --> [Last].

