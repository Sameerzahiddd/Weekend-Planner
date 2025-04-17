% Define the recommendation rules for SF Weekend Planner

:- dynamic known/3.

% Main recommendation predicate
recommendation(X) :-
    place(X),
    meets_criteria(X).

% Check if a place meets all user criteria
meets_criteria(X) :-
    % Check location type
    check_preference(X, location_type),
    % Check payment preference
    check_preference(X, payment_preference),
    % Check vibes
    check_vibe_preferences(X),
    % Check distance
    check_distance_preferences(X),
    % Check amenities
    check_preference(X, food_available),
    check_preference(X, plug_needed),
    check_preference(X, wifi_needed),
    % Check ambience
    check_preference(X, ambience),
    % Check wheelchair accessibility
    check_preference(X, wheelchair_accessible).

% Check vibes (any of the selected vibes should match)
check_vibe_preferences(X) :-
    (known(yes, vibe_chill, _) -> attribute_value(X, vibe_chill, yes); true),
    (known(yes, vibe_social, _) -> attribute_value(X, vibe_social, yes); true),
    (known(yes, vibe_study, _) -> attribute_value(X, vibe_study, yes); true),
    (known(yes, vibe_romantic, _) -> attribute_value(X, vibe_romantic, yes); true),
    (known(yes, vibe_sport, _) -> attribute_value(X, vibe_sport, yes); true).

% Check distance preferences
check_distance_preferences(X) :-
    check_preference(X, walking_distance),
    % If not within walking distance, check travel distance
    (known(no, walking_distance, _) -> check_preference(X, travel_distance); true).

% Check if a place satisfies a specific preference
check_preference(X, Attribute) :-
    % Get the value of the attribute for the place
    attribute_value(X, Attribute, Value),
    % Ask the user about their preference for this attribute
    ask(Value, Attribute, Response),
    % The place satisfies the preference if the response is "yes"
    Response = yes.

% Ask the user about their preference
ask(V, A, Y) :-
    known(V, A, Y), !.  % If already known, use the known value
ask(V, A, Y) :-
    \+ known(_, A, _),  % If not already asked
    read_py(A, V, Y),   % Ask the user through Python
    asserta(known(V, A, Y)).  % Store the user's response

% Place definitions and attributes will be filled in here
% These are just placeholders to demonstrate the structure

% List of places
place(dolores_park).
place(sightglass_coffee).
place(golden_gate_park).
place(sf_moma).
place(ferry_building).
place(palace_of_fine_arts).
place(lands_end).
place(crissy_field).
place(presidio).
place(japanese_tea_garden).
place(exploratorium).
place(twin_peaks).
place(mission_district).
place(fishermans_wharf).
place(alcatraz).

% Define attributes for each place
% These are placeholder values - replace with actual data

% Location type (indoor/outdoor)
attribute_value(dolores_park, location_type, outdoor).
attribute_value(sightglass_coffee, location_type, indoor).
attribute_value(golden_gate_park, location_type, outdoor).
attribute_value(sf_moma, location_type, indoor).
attribute_value(ferry_building, location_type, indoor).
attribute_value(palace_of_fine_arts, location_type, outdoor).
attribute_value(lands_end, location_type, outdoor).
attribute_value(crissy_field, location_type, outdoor).
attribute_value(presidio, location_type, outdoor).
attribute_value(japanese_tea_garden, location_type, outdoor).
attribute_value(exploratorium, location_type, indoor).
attribute_value(twin_peaks, location_type, outdoor).
attribute_value(mission_district, location_type, outdoor).
attribute_value(fishermans_wharf, location_type, outdoor).
attribute_value(alcatraz, location_type, outdoor).

% Payment preference (free/paid)
attribute_value(dolores_park, payment_preference, free).
attribute_value(sightglass_coffee, payment_preference, paid).
attribute_value(golden_gate_park, payment_preference, free).
attribute_value(sf_moma, payment_preference, paid).
attribute_value(ferry_building, payment_preference, free).
attribute_value(palace_of_fine_arts, payment_preference, free).
attribute_value(lands_end, payment_preference, free).
attribute_value(crissy_field, payment_preference, free).
attribute_value(presidio, payment_preference, free).
attribute_value(japanese_tea_garden, payment_preference, paid).
attribute_value(exploratorium, payment_preference, paid).
attribute_value(twin_peaks, payment_preference, free).
attribute_value(mission_district, payment_preference, free).
attribute_value(fishermans_wharf, payment_preference, free).
attribute_value(alcatraz, payment_preference, paid).

% Vibes (chill, social, study, romantic, sport)
attribute_value(dolores_park, vibe_chill, yes).
attribute_value(dolores_park, vibe_social, yes).
attribute_value(dolores_park, vibe_study, no).
attribute_value(dolores_park, vibe_romantic, yes).
attribute_value(dolores_park, vibe_sport, yes).

attribute_value(sightglass_coffee, vibe_chill, yes).
attribute_value(sightglass_coffee, vibe_social, no).
attribute_value(sightglass_coffee, vibe_study, yes).
attribute_value(sightglass_coffee, vibe_romantic, no).
attribute_value(sightglass_coffee, vibe_sport, no).

% Add other vibe attributes for remaining places...

% Walking distance
attribute_value(dolores_park, walking_distance, yes).
attribute_value(sightglass_coffee, walking_distance, yes).
attribute_value(golden_gate_park, walking_distance, no).
attribute_value(sf_moma, walking_distance, no).
attribute_value(ferry_building, walking_distance, no).
attribute_value(palace_of_fine_arts, walking_distance, no).
attribute_value(lands_end, walking_distance, no).
attribute_value(crissy_field, walking_distance, no).
attribute_value(presidio, walking_distance, no).
attribute_value(japanese_tea_garden, walking_distance, no).
attribute_value(exploratorium, walking_distance, no).
attribute_value(twin_peaks, walking_distance, no).
attribute_value(mission_district, walking_distance, yes).
attribute_value(fishermans_wharf, walking_distance, no).
attribute_value(alcatraz, walking_distance, no).

% Travel distance
attribute_value(dolores_park, travel_distance, less_than_5km).
attribute_value(sightglass_coffee, travel_distance, less_than_5km).
attribute_value(golden_gate_park, travel_distance, more_than_5km).
attribute_value(sf_moma, travel_distance, less_than_5km).
attribute_value(ferry_building, travel_distance, less_than_5km).
attribute_value(palace_of_fine_arts, travel_distance, more_than_5km).
attribute_value(lands_end, travel_distance, more_than_5km).
attribute_value(crissy_field, travel_distance, more_than_5km).
attribute_value(presidio, travel_distance, more_than_5km).
attribute_value(japanese_tea_garden, travel_distance, more_than_5km).
attribute_value(exploratorium, travel_distance, less_than_5km).
attribute_value(twin_peaks, travel_distance, more_than_5km).
attribute_value(mission_district, travel_distance, less_than_5km).
attribute_value(fishermans_wharf, travel_distance, more_than_5km).
attribute_value(alcatraz, travel_distance, more_than_5km).

% Food available
attribute_value(dolores_park, food_available, yes).
attribute_value(sightglass_coffee, food_available, yes).
attribute_value(golden_gate_park, food_available, yes).
attribute_value(sf_moma, food_available, yes).
attribute_value(ferry_building, food_available, yes).
attribute_value(palace_of_fine_arts, food_available, no).
attribute_value(lands_end, food_available, no).
attribute_value(crissy_field, food_available, yes).
attribute_value(presidio, food_available, yes).
attribute_value(japanese_tea_garden, food_available, yes).
attribute_value(exploratorium, food_available, yes).
attribute_value(twin_peaks, food_available, no).
attribute_value(mission_district, food_available, yes).
attribute_value(fishermans_wharf, food_available, yes).
attribute_value(alcatraz, food_available, yes).

% Plug needed
attribute_value(dolores_park, plug_needed, no).
attribute_value(sightglass_coffee, plug_needed, yes).
attribute_value(golden_gate_park, plug_needed, no).
attribute_value(sf_moma, plug_needed, no).
attribute_value(ferry_building, plug_needed, no).
attribute_value(palace_of_fine_arts, plug_needed, no).
attribute_value(lands_end, plug_needed, no).
attribute_value(crissy_field, plug_needed, no).
attribute_value(presidio, plug_needed, no).
attribute_value(japanese_tea_garden, plug_needed, no).
attribute_value(exploratorium, plug_needed, no).
attribute_value(twin_peaks, plug_needed, no).
attribute_value(mission_district, plug_needed, no).
attribute_value(fishermans_wharf, plug_needed, no).
attribute_value(alcatraz, plug_needed, no).

% WiFi needed
attribute_value(dolores_park, wifi_needed, no).
attribute_value(sightglass_coffee, wifi_needed, yes).
attribute_value(golden_gate_park, wifi_needed, no).
attribute_value(sf_moma, wifi_needed, yes).
attribute_value(ferry_building, wifi_needed, no).
attribute_value(palace_of_fine_arts, wifi_needed, no).
attribute_value(lands_end, wifi_needed, no).
attribute_value(crissy_field, wifi_needed, no).
attribute_value(presidio, wifi_needed, no).
attribute_value(japanese_tea_garden, wifi_needed, no).
attribute_value(exploratorium, wifi_needed, yes).
attribute_value(twin_peaks, wifi_needed, no).
attribute_value(mission_district, wifi_needed, no).
attribute_value(fishermans_wharf, wifi_needed, no).
attribute_value(alcatraz, wifi_needed, no).

% Ambience
attribute_value(dolores_park, ambience, crowded).
attribute_value(sightglass_coffee, ambience, quiet).
attribute_value(golden_gate_park, ambience, crowded).
attribute_value(sf_moma, ambience, quiet).
attribute_value(ferry_building, ambience, crowded).
attribute_value(palace_of_fine_arts, ambience, quiet).
attribute_value(lands_end, ambience, quiet).
attribute_value(crissy_field, ambience, crowded).
attribute_value(presidio, ambience, quiet).
attribute_value(japanese_tea_garden, ambience, quiet).
attribute_value(exploratorium, ambience, crowded).
attribute_value(twin_peaks, ambience, crowded).
attribute_value(mission_district, ambience, crowded).
attribute_value(fishermans_wharf, ambience, crowded).
attribute_value(alcatraz, ambience, crowded).

% Wheelchair accessible
attribute_value(dolores_park, wheelchair_accessible, yes).
attribute_value(sightglass_coffee, wheelchair_accessible, yes).
attribute_value(golden_gate_park, wheelchair_accessible, yes).
attribute_value(sf_moma, wheelchair_accessible, yes).
attribute_value(ferry_building, wheelchair_accessible, yes).
attribute_value(palace_of_fine_arts, wheelchair_accessible, yes).
attribute_value(lands_end, wheelchair_accessible, no).
attribute_value(crissy_field, wheelchair_accessible, yes).
attribute_value(presidio, wheelchair_accessible, yes).
attribute_value(japanese_tea_garden, wheelchair_accessible, yes).
attribute_value(exploratorium, wheelchair_accessible, yes).
attribute_value(twin_peaks, wheelchair_accessible, no).
attribute_value(mission_district, wheelchair_accessible, yes).
attribute_value(fishermans_wharf, wheelchair_accessible, yes).
attribute_value(alcatraz, wheelchair_accessible, no).

% Add your additional places and attributes based on your database