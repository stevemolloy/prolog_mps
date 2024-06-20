% :- use_module(library(dicts)).

json({ "name": "John Doe", "age": 30, "city": "New York" }).
% json({name: "John Doe", age: 30, city: "New York"}).

extract_name({"name": Name, "age": _, "city": _}, Name).
extract_age({"name": _, "age": Age, "city": _}, Age).
extract_city({"name": _, "age": _, "city": City}, City).

