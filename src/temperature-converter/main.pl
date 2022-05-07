:- use_module(library(pce)).
:- initialization main.

main :-
    new(D, dialog('TempConv')),
    InitC = 100,
    c_to_f(InitC, InitF),
    numeric_item(Celsius, InitC),
    numeric_item(Fahrenheit, InitF),
    send(Celsius, message, message(@prolog, update_farhrenheit, Celsius, Fahrenheit)),
    send(Fahrenheit, message, message(@prolog, update_celsius, Celsius, Fahrenheit)),
    send(D, append, Celsius),
    send(D, append, label('Celsius = ')),
    send(D, append, Fahrenheit),
    send(D, append, label('Fahrenheit')),
    get(D, confirm, _). 

numeric_item(Item, Init) :-
    new(Item, text_item(count, Init)),
    send(Item, type, real),
    % We choose 12 because it allows the dialog title to be visible.
    send(Item, length, 12),
    send(Item, show_label, @off).

c_to_f(C, F):- F is C * (9/5) + 32.
f_to_c(C, F):- C is (F - 32) * (5/9).

update_farhrenheit(Celsius, Fahrenheit) :-
    get(Celsius, selection, C),
    c_to_f(C, F),
    send(Fahrenheit, selection, F).

update_celsius(Celsius, Fahrenheit) :-
    get(Fahrenheit, selection, F),
    f_to_c(C, F),
    send(Celsius, selection, C).


