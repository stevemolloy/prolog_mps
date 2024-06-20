% :- consult(plc01).

flowmeter(Flowmeter) :-
  json(J),
  J = {"flow_meter": Flowmeter, "ion_pump": _, "rfdump": _, "switch": _, "thermocouple": _, "unidentified objects": _, "vacuum_gauge": _, "valve": _}.

ion_pump(Ionpump) :-
  json(J),
  J = {"flow_meter": _, "ion_pump": Ionpump, "rfdump": _, "switch": _, "thermocouple": _, "unidentified objects": _, "vacuum_gauge": _, "valve": _}.

rfdump(Rfdump) :-
  json(J),
  J = {"flow_meter": _, "ion_pump": _, "rfdump": Rfdump, "switch": _, "thermocouple": _, "unidentified objects": _, "vacuum_gauge": _, "valve": _}.

switch(Switch) :-
  json(J),
  J = {"flow_meter": _, "ion_pump": _, "rfdump": _, "switch": Switch, "thermocouple": _, "unidentified objects": _, "vacuum_gauge": _, "valve": _}.

thermocouple(TC) :-
  json(J),
  J = {"flow_meter": _, "ion_pump": _, "rfdump": _, "switch": _, "thermocouple": TC, "unidentified objects": _, "vacuum_gauge": _, "valve": _}.

unidentified(Unident) :-
  json(J),
  J = {"flow_meter": _, "ion_pump": _, "rfdump": _, "switch": _, "thermocouple": _, "unidentified objects": Unident, "vacuum_gauge": _, "valve": _}.

vacuum_gauge(Vac) :-
  json(J),
  J = {"flow_meter": _, "ion_pump": _, "rfdump": _, "switch": _, "thermocouple": _, "unidentified objects": _, "vacuum_gauge": Vac, "valve": _}.

valve(Valve) :-
  json(J),
  J = {"flow_meter": _, "ion_pump": _, "rfdump": _, "switch": _, "thermocouple": _, "unidentified objects": _, "vacuum_gauge": _, "valve": Valve}.

