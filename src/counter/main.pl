:- use_module(library(pce)).

:- initialization counter.

% A textbox that is side-by-side with a button that increments the count.
counter :-
    new(D, dialog('Counter')),
    % Create a new counter. The only downside of using a pre-defined text_item
    % is that it is always editable. There doesn't seem to be a way to make this
    % field read-only.
    new(CountItem, text_item(count, 0)),
    send(CountItem, type, int),
    % We choose 12 because it allows the dialog title to be visible.
    send(CountItem, length, 12),
    send(CountItem, show_label, @off),
    send(D, append, CountItem),
    % Add a callback to update the value of the text_item.
    send(D, append, button(count, message(@prolog, update_count, CountItem)), right),
    get(D, confirm, Value),
    Value \== @nil.

% Clear and update the value of the text_item by the value incremented by 1.
update_count(CountItem) :-
    get(CountItem, selection, Value),
    NewValue is Value + 1,
    send(CountItem, clear),
    send(CountItem, selection, NewValue).
