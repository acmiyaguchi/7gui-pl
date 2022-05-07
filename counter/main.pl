:- use_module(library(pce)).

:- initialization counter(_).

counter(Value) :-
    new(D, dialog('Counter')),
    send(D, append, new(CountItem, text_item(count))),
    send(D, append, button(ok, message(D, return, CountItem?selection))),
    send(D, default_button(ok)),
    get(D, confirm, Value),
    free(D),
    Value \== @nil.
