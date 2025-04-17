% Dynamic declarations for known facts
:- dynamic known/3.

% Define the askable attributes
location_type(X) :- ask(location_type, X).
payment_preference(X) :- ask(payment_preference, X).
food_available(X) :- ask(food_available, X).
walking_distance(X) :- ask(walking_distance, X).
travel_distance(X) :- ask(travel_distance, X).
plug_needed(X) :- ask(plug_needed, X).
wifi_needed(X) :- ask(wifi_needed, X).
ambience(X) :- ask(ambience, X).
wheelchair_accessible(X) :- ask(wheelchair_accessible, X).

% Recommendation rules
recommendation(cafe_reveille) :- 
    location_type(indoor),
    payment_preference(paid),
    food_available(yes),
    walking_distance(yes),
    plug_needed(yes),
    wifi_needed(yes),
    ambience(quiet),
    wheelchair_accessible(yes).

recommendation(dolores_park) :- 
    location_type(outdoor),
    payment_preference(free),
    food_available(yes),
    walking_distance(yes),
    wifi_needed(no),
    ambience(crowded),
    wheelchair_accessible(yes).

recommendation(blue_bottle) :- 
    location_type(indoor),
    payment_preference(paid),
    food_available(yes),
    walking_distance(yes),
    plug_needed(yes),
    wifi_needed(yes),
    ambience(quiet),
    wheelchair_accessible(yes).

recommendation(mission_bay_branch_library) :- 
    location_type(indoor),
    payment_preference(free),
    food_available(no),
    walking_distance(yes),
    plug_needed(yes),
    wifi_needed(yes),
    ambience(quiet),
    wheelchair_accessible(yes).

recommendation(golden_gate_park) :- 
    location_type(outdoor),
    payment_preference(free),
    walking_distance(no),
    travel_distance(more_than_5km),
    ambience(quiet),
    wheelchair_accessible(yes).

% Handle no preference cases
location_type(indoor) :- known(yes, location_type, no_preference).
location_type(outdoor) :- known(yes, location_type, no_preference).

payment_preference(free) :- known(yes, payment_preference, no_preference).
payment_preference(paid) :- known(yes, payment_preference, no_preference).

food_available(yes) :- known(yes, food_available, no_preference).
food_available(no) :- known(yes, food_available, no_preference).

walking_distance(yes) :- known(yes, walking_distance, no_preference).
walking_distance(no) :- known(yes, walking_distance, no_preference).

plug_needed(yes) :- known(yes, plug_needed, no_preference).
plug_needed(no) :- known(yes, plug_needed, no_preference).

wifi_needed(yes) :- known(yes, wifi_needed, no_preference).
wifi_needed(no) :- known(yes, wifi_needed, no_preference).

ambience(quiet) :- known(yes, ambience, no_preference).
ambience(crowded) :- known(yes, ambience, no_preference).

wheelchair_accessible(yes) :- known(yes, wheelchair_accessible, no_preference).
wheelchair_accessible(no) :- known(yes, wheelchair_accessible, no_preference).

% Asking clauses
ask(A, V):-
    known(yes, A, V), % succeed if true
    !.  % stop looking

ask(A, V):-
    known(_, A, V), % fail if false
    !, fail.

% if it is already known to be something else, the user does not need to be asked again
ask(A, V):-
    known(yes, A, V2),
    V \== V2,
    !, fail.

ask(A, V):-
    read_py(A, V, Y), % obtain the answer with that python function
    assertz(known(Y, A, V)), % save it for future reference
    Y == yes.   % succeed or fail