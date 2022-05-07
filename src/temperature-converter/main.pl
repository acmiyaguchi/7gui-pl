:- use_module(library(pce)).
:- initialization main.

main :-
    new(D, dialog('Temperature Converter')),
    InitC = 100,
    c_to_f(InitC, InitF),

    % configure the main text boxes with values
    numeric_item(Celsius, InitC),
    numeric_item(Fahrenheit, InitF),
    send(Celsius, message, message(@prolog, update_farhrenheit, Celsius, Fahrenheit)),
    send(Fahrenheit, message, message(@prolog, update_celsius, Celsius, Fahrenheit)),

    % generate the labels. We have three, with the = having it's own label to
    % ensure padding looks roughly correct
    label(CelsiusLabel, 'Celsius'),
    label(EqualsLabel, '='),
    label(FahrenheitLabel, 'Fahrenheit'),

    % build the layout
    send(D, append, Celsius),
    send(D, append, CelsiusLabel, right),
    send(D, append, EqualsLabel, right),
    send(D, append, Fahrenheit, right),
    send(D, append, FahrenheitLabel, right),
    
    % block on the ui
    get(D, confirm, _). 

label(Label, Text) :-
    new(Label, label(label, Text)),
    send(Label, length, 0).

numeric_item(Item, Init) :-
    new(Item, text_item(count, Init)),
    send(Item, type, real),
    send(Item, length, 8),
    send(Item, show_label, @off).

% helpers
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


