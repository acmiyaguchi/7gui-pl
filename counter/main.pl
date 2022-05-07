:- use_module(library(pce)).

:- initialization main.

:- dynamic count/1.

counter :-
    new(D, dialog('Counter')),
    count(Count),
    send(D, append, new(CountItem, text_item(count, Count))),
    send(D, append, button(ok, message(@prolog, update_count, CountItem))),
    send(D, default_button, ok),
    get(D, confirm, Value),
    Value \== @nil.

update_count(CountItem) :-
    get(CountItem, selection, Value),
    retract(count(_)),
    NewValue is Value + 1,
    assert(count(NewValue)),
    send(CountItem, clear),
    send(CountItem, selection, NewValue).

main:-
    assert(count(0)),
    counter.