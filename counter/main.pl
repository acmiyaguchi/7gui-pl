:- use_module(library(pce)).

:- initialization main.

counter :-
    new(D, dialog('Counter')),
    new(CountItem, text_item(count, 0)),
    send(CountItem, type, int),
    send(CountItem, length, 12),
    send(CountItem, show_label, @off),
    send(D, append, CountItem),
    send(D, append, button(count, message(@prolog, update_count, CountItem)), right),
    get(D, confirm, Value),
    Value \== @nil.

update_count(CountItem) :-
    get(CountItem, selection, Value),
    NewValue is Value + 1,
    send(CountItem, clear),
    send(CountItem, selection, NewValue).

main:-
    counter.