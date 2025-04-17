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
    % The place satisfies the preference if the response is yes
    Response = yes.

% Ask the user about their preference
ask(V, A, Y) :-
    known(V, A, Y), !.  % If already known, use the known value
ask(V, A, Y) :-
    \+ known(_, A, _),  % If not already asked
    read_py(A, V, Y),   % Ask the user through Python
    asserta(known(V, A, Y)).  % Store the user's response

% List of places
place(cherry_blossom_festival).
place(earth_day_festival).
place(sf_art_fair).
place(sunset_dunes_park).
place(candlelight_concert).
place(sf_giants_home_game).
place(fat_ham_sf_playhouse).
place(emotionair_installations).
place(bay_area_brew_festival).
place(chess_night_game).
place(japanese_tea_garden).
place(dolores_park).
place(downtown_first_thursdays).
place(balloon_museum).
place(asian_art_museum).
place(queen_wilhelmina_tulip_garden).
place(painted_ladies).
place(fishermans_wharf).
place(golden_gate_park).
place(ina_coolbrith_park).
place(san_francisco_botanical_garden).
place(strawberry_hill).
place(pioneer_park).
place(andytown_salesforce).
place(sff_mission_bay).
place(benchmark_climbing).
place(ymca).
place(the_crossing).
place(lands_end).
place(china_camp_state_park).
place(joe_and_the_juice).
place(peets_coffee).
place(blue_bottle).
place(motoring_coffee).
place(cafe_reveille).
place(him_mark_lai_branch_library).
place(mission_bay_branch_library).
place(sf_public_library).
place(potrero_branch_library).
place(golden_gate_valley_branch_library).

% Location type (indoor/outdoor)
attribute_value(cherry_blossom_festival, location_type, outdoor).
attribute_value(earth_day_festival, location_type, outdoor).
attribute_value(sf_art_fair, location_type, indoor).
attribute_value(sunset_dunes_park, location_type, outdoor).
attribute_value(candlelight_concert, location_type, indoor).
attribute_value(sf_giants_home_game, location_type, outdoor).
attribute_value(fat_ham_sf_playhouse, location_type, indoor).
attribute_value(emotionair_installations, location_type, indoor).
attribute_value(bay_area_brew_festival, location_type, outdoor).
attribute_value(chess_night_game, location_type, outdoor).
attribute_value(japanese_tea_garden, location_type, outdoor).
attribute_value(dolores_park, location_type, outdoor).
attribute_value(downtown_first_thursdays, location_type, outdoor).
attribute_value(balloon_museum, location_type, indoor).
attribute_value(asian_art_museum, location_type, indoor).
attribute_value(queen_wilhelmina_tulip_garden, location_type, outdoor).
attribute_value(painted_ladies, location_type, outdoor).
attribute_value(fishermans_wharf, location_type, both).
attribute_value(golden_gate_park, location_type, outdoor).
attribute_value(ina_coolbrith_park, location_type, outdoor).
attribute_value(san_francisco_botanical_garden, location_type, outdoor).
attribute_value(strawberry_hill, location_type, outdoor).
attribute_value(pioneer_park, location_type, outdoor).
attribute_value(andytown_salesforce, location_type, indoor).
attribute_value(sff_mission_bay, location_type, outdoor).
attribute_value(benchmark_climbing, location_type, indoor).
attribute_value(ymca, location_type, indoor).
attribute_value(the_crossing, location_type, outdoor).
attribute_value(lands_end, location_type, outdoor).
attribute_value(china_camp_state_park, location_type, outdoor).
attribute_value(joe_and_the_juice, location_type, indoor).
attribute_value(peets_coffee, location_type, indoor).
attribute_value(blue_bottle, location_type, indoor).
attribute_value(motoring_coffee, location_type, indoor).
attribute_value(cafe_reveille, location_type, indoor).
attribute_value(him_mark_lai_branch_library, location_type, indoor).
attribute_value(mission_bay_branch_library, location_type, indoor).
attribute_value(sf_public_library, location_type, indoor).
attribute_value(potrero_branch_library, location_type, indoor).
attribute_value(golden_gate_valley_branch_library, location_type, indoor).

% Payment preference (free/paid)
attribute_value(cherry_blossom_festival, payment_preference, free).
attribute_value(earth_day_festival, payment_preference, free).
attribute_value(sf_art_fair, payment_preference, free).
attribute_value(sunset_dunes_park, payment_preference, free).
attribute_value(candlelight_concert, payment_preference, paid).
attribute_value(sf_giants_home_game, payment_preference, paid).
attribute_value(fat_ham_sf_playhouse, payment_preference, paid).
attribute_value(emotionair_installations, payment_preference, paid).
attribute_value(bay_area_brew_festival, payment_preference, paid).
attribute_value(chess_night_game, payment_preference, free).
attribute_value(japanese_tea_garden, payment_preference, paid).
attribute_value(dolores_park, payment_preference, free).
attribute_value(downtown_first_thursdays, payment_preference, free).
attribute_value(balloon_museum, payment_preference, paid).
attribute_value(asian_art_museum, payment_preference, paid).
attribute_value(queen_wilhelmina_tulip_garden, payment_preference, free).
attribute_value(painted_ladies, payment_preference, free).
attribute_value(fishermans_wharf, payment_preference, free).
attribute_value(golden_gate_park, payment_preference, free).
attribute_value(ina_coolbrith_park, payment_preference, free).
attribute_value(san_francisco_botanical_garden, payment_preference, free).
attribute_value(strawberry_hill, payment_preference, free).
attribute_value(pioneer_park, payment_preference, free).
attribute_value(andytown_salesforce, payment_preference, paid).
attribute_value(sff_mission_bay, payment_preference, free).
attribute_value(benchmark_climbing, payment_preference, paid).
attribute_value(ymca, payment_preference, paid).
attribute_value(the_crossing, payment_preference, paid).
attribute_value(lands_end, payment_preference, free).
attribute_value(china_camp_state_park, payment_preference, paid).
attribute_value(joe_and_the_juice, payment_preference, paid).
attribute_value(peets_coffee, payment_preference, paid).
attribute_value(blue_bottle, payment_preference, paid).
attribute_value(motoring_coffee, payment_preference, paid).
attribute_value(cafe_reveille, payment_preference, paid).
attribute_value(him_mark_lai_branch_library, payment_preference, free).
attribute_value(mission_bay_branch_library, payment_preference, free).
attribute_value(sf_public_library, payment_preference, free).
attribute_value(potrero_branch_library, payment_preference, free).
attribute_value(golden_gate_valley_branch_library, payment_preference, free).

% Vibes
% Chill
attribute_value(cherry_blossom_festival, vibe_chill, no).
attribute_value(earth_day_festival, vibe_chill, no).
attribute_value(sf_art_fair, vibe_chill, no).
attribute_value(sunset_dunes_park, vibe_chill, yes).
attribute_value(candlelight_concert, vibe_chill, no).
attribute_value(sf_giants_home_game, vibe_chill, no).
attribute_value(fat_ham_sf_playhouse, vibe_chill, yes).
attribute_value(emotionair_installations, vibe_chill, no).
attribute_value(bay_area_brew_festival, vibe_chill, yes).
attribute_value(chess_night_game, vibe_chill, yes).
attribute_value(japanese_tea_garden, vibe_chill, yes).
attribute_value(dolores_park, vibe_chill, yes).
attribute_value(downtown_first_thursdays, vibe_chill, no).
attribute_value(balloon_museum, vibe_chill, yes).
attribute_value(asian_art_museum, vibe_chill, yes).
attribute_value(queen_wilhelmina_tulip_garden, vibe_chill, yes).
attribute_value(painted_ladies, vibe_chill, yes).
attribute_value(fishermans_wharf, vibe_chill, no).
attribute_value(golden_gate_park, vibe_chill, yes).
attribute_value(ina_coolbrith_park, vibe_chill, yes).
attribute_value(san_francisco_botanical_garden, vibe_chill, yes).
attribute_value(strawberry_hill, vibe_chill, yes).
attribute_value(pioneer_park, vibe_chill, yes).
attribute_value(andytown_salesforce, vibe_chill, yes).
attribute_value(sff_mission_bay, vibe_chill, no).
attribute_value(benchmark_climbing, vibe_chill, no).
attribute_value(ymca, vibe_chill, no).
attribute_value(the_crossing, vibe_chill, no).
attribute_value(lands_end, vibe_chill, no).
attribute_value(china_camp_state_park, vibe_chill, yes).
attribute_value(joe_and_the_juice, vibe_chill, yes).
attribute_value(peets_coffee, vibe_chill, yes).
attribute_value(blue_bottle, vibe_chill, yes).
attribute_value(motoring_coffee, vibe_chill, yes).
attribute_value(cafe_reveille, vibe_chill, yes).
attribute_value(him_mark_lai_branch_library, vibe_chill, no).
attribute_value(mission_bay_branch_library, vibe_chill, no).
attribute_value(sf_public_library, vibe_chill, no).
attribute_value(potrero_branch_library, vibe_chill, no).
attribute_value(golden_gate_valley_branch_library, vibe_chill, no).

% Social
attribute_value(cherry_blossom_festival, vibe_social, yes).
attribute_value(earth_day_festival, vibe_social, yes).
attribute_value(sf_art_fair, vibe_social, yes).
attribute_value(sunset_dunes_park, vibe_social, yes).
attribute_value(candlelight_concert, vibe_social, no).
attribute_value(sf_giants_home_game, vibe_social, yes).
attribute_value(fat_ham_sf_playhouse, vibe_social, yes).
attribute_value(emotionair_installations, vibe_social, yes).
attribute_value(bay_area_brew_festival, vibe_social, yes).
attribute_value(chess_night_game, vibe_social, yes).
attribute_value(japanese_tea_garden, vibe_social, no).
attribute_value(dolores_park, vibe_social, yes).
attribute_value(downtown_first_thursdays, vibe_social, yes).
attribute_value(balloon_museum, vibe_social, yes).
attribute_value(asian_art_museum, vibe_social, no).
attribute_value(queen_wilhelmina_tulip_garden, vibe_social, no).
attribute_value(painted_ladies, vibe_social, yes).
attribute_value(fishermans_wharf, vibe_social, yes).
attribute_value(golden_gate_park, vibe_social, yes).
attribute_value(ina_coolbrith_park, vibe_social, yes).
attribute_value(san_francisco_botanical_garden, vibe_social, no).
attribute_value(strawberry_hill, vibe_social, no).
attribute_value(pioneer_park, vibe_social, yes).
attribute_value(andytown_salesforce, vibe_social, yes).
attribute_value(sff_mission_bay, vibe_social, yes).
attribute_value(benchmark_climbing, vibe_social, yes).
attribute_value(ymca, vibe_social, no).
attribute_value(the_crossing, vibe_social, yes).
attribute_value(lands_end, vibe_social, yes).
attribute_value(china_camp_state_park, vibe_social, yes).
attribute_value(joe_and_the_juice, vibe_social, yes).
attribute_value(peets_coffee, vibe_social, yes).
attribute_value(blue_bottle, vibe_social, yes).
attribute_value(motoring_coffee, vibe_social, yes).
attribute_value(cafe_reveille, vibe_social, yes).
attribute_value(him_mark_lai_branch_library, vibe_social, no).
attribute_value(mission_bay_branch_library, vibe_social, no).
attribute_value(sf_public_library, vibe_social, no).
attribute_value(potrero_branch_library, vibe_social, no).
attribute_value(golden_gate_valley_branch_library, vibe_social, no).

% Study
attribute_value(cherry_blossom_festival, vibe_study, no).
attribute_value(earth_day_festival, vibe_study, no).
attribute_value(sf_art_fair, vibe_study, no).
attribute_value(sunset_dunes_park, vibe_study, no).
attribute_value(candlelight_concert, vibe_study, no).
attribute_value(sf_giants_home_game, vibe_study, no).
attribute_value(fat_ham_sf_playhouse, vibe_study, no).
attribute_value(emotionair_installations, vibe_study, no).
attribute_value(bay_area_brew_festival, vibe_study, no).
attribute_value(chess_night_game, vibe_study, no).
attribute_value(japanese_tea_garden, vibe_study, no).
attribute_value(dolores_park, vibe_study, no).
attribute_value(downtown_first_thursdays, vibe_study, no).
attribute_value(balloon_museum, vibe_study, no).
attribute_value(asian_art_museum, vibe_study, no).
attribute_value(queen_wilhelmina_tulip_garden, vibe_study, no).
attribute_value(painted_ladies, vibe_study, no).
attribute_value(fishermans_wharf, vibe_study, no).
attribute_value(golden_gate_park, vibe_study, no).
attribute_value(ina_coolbrith_park, vibe_study, no).
attribute_value(san_francisco_botanical_garden, vibe_study, no).
attribute_value(strawberry_hill, vibe_study, no).
attribute_value(pioneer_park, vibe_study, no).
attribute_value(andytown_salesforce, vibe_study, no).
attribute_value(sff_mission_bay, vibe_study, no).
attribute_value(benchmark_climbing, vibe_study, no).
attribute_value(ymca, vibe_study, no).
attribute_value(the_crossing, vibe_study, no).
attribute_value(lands_end, vibe_study, no).
attribute_value(china_camp_state_park, vibe_study, no).
attribute_value(joe_and_the_juice, vibe_study, yes).
attribute_value(peets_coffee, vibe_study, yes).
attribute_value(blue_bottle, vibe_study, yes).
attribute_value(motoring_coffee, vibe_study, yes).
attribute_value(cafe_reveille, vibe_study, yes).
attribute_value(him_mark_lai_branch_library, vibe_study, yes).
attribute_value(mission_bay_branch_library, vibe_study, yes).
attribute_value(sf_public_library, vibe_study, yes).
attribute_value(potrero_branch_library, vibe_study, yes).
attribute_value(golden_gate_valley_branch_library, vibe_study, yes).

% Romantic
attribute_value(cherry_blossom_festival, vibe_romantic, no).
attribute_value(earth_day_festival, vibe_romantic, no).
attribute_value(sf_art_fair, vibe_romantic, no).
attribute_value(sunset_dunes_park, vibe_romantic, yes).
attribute_value(candlelight_concert, vibe_romantic, yes).
attribute_value(sf_giants_home_game, vibe_romantic, no).
attribute_value(fat_ham_sf_playhouse, vibe_romantic, yes).
attribute_value(emotionair_installations, vibe_romantic, yes).
attribute_value(bay_area_brew_festival, vibe_romantic, no).
attribute_value(chess_night_game, vibe_romantic, no).
attribute_value(japanese_tea_garden, vibe_romantic, yes).
attribute_value(dolores_park, vibe_romantic, yes).
attribute_value(downtown_first_thursdays, vibe_romantic, yes).
attribute_value(balloon_museum, vibe_romantic, yes).
attribute_value(asian_art_museum, vibe_romantic, yes).
attribute_value(queen_wilhelmina_tulip_garden, vibe_romantic, yes).
attribute_value(painted_ladies, vibe_romantic, yes).
attribute_value(fishermans_wharf, vibe_romantic, yes).
attribute_value(golden_gate_park, vibe_romantic, yes).
attribute_value(ina_coolbrith_park, vibe_romantic, yes).
attribute_value(san_francisco_botanical_garden, vibe_romantic, yes).
attribute_value(strawberry_hill, vibe_romantic, yes).
attribute_value(pioneer_park, vibe_romantic, yes).
attribute_value(andytown_salesforce, vibe_romantic, no).
attribute_value(sff_mission_bay, vibe_romantic, no).
attribute_value(benchmark_climbing, vibe_romantic, no).
attribute_value(ymca, vibe_romantic, no).
attribute_value(the_crossing, vibe_romantic, no).
attribute_value(lands_end, vibe_romantic, no).
attribute_value(china_camp_state_park, vibe_romantic, yes).
attribute_value(joe_and_the_juice, vibe_romantic, no).
attribute_value(peets_coffee, vibe_romantic, no).
attribute_value(blue_bottle, vibe_romantic, no).
attribute_value(motoring_coffee, vibe_romantic, no).
attribute_value(cafe_reveille, vibe_romantic, no).
attribute_value(him_mark_lai_branch_library, vibe_romantic, no).
attribute_value(mission_bay_branch_library, vibe_romantic, no).
attribute_value(sf_public_library, vibe_romantic, no).
attribute_value(potrero_branch_library, vibe_romantic, no).
attribute_value(golden_gate_valley_branch_library, vibe_romantic, no).

% Sport
attribute_value(cherry_blossom_festival, vibe_sport, no).
attribute_value(earth_day_festival, vibe_sport, no).
attribute_value(sf_art_fair, vibe_sport, no).
attribute_value(sunset_dunes_park, vibe_sport, no).
attribute_value(candlelight_concert, vibe_sport, no).
attribute_value(sf_giants_home_game, vibe_sport, yes).
attribute_value(fat_ham_sf_playhouse, vibe_sport, no).
attribute_value(emotionair_installations, vibe_sport, no).
attribute_value(bay_area_brew_festival, vibe_sport, no).
attribute_value(chess_night_game, vibe_sport, no).
attribute_value(japanese_tea_garden, vibe_sport, no).
attribute_value(dolores_park, vibe_sport, yes).
attribute_value(downtown_first_thursdays, vibe_sport, no).
attribute_value(balloon_museum, vibe_sport, no).
attribute_value(asian_art_museum, vibe_sport, no).
attribute_value(queen_wilhelmina_tulip_garden, vibe_sport, no).
attribute_value(painted_ladies, vibe_sport, no).
attribute_value(fishermans_wharf, vibe_sport, no).
attribute_value(golden_gate_park, vibe_sport, yes).
attribute_value(ina_coolbrith_park, vibe_sport, no).
attribute_value(san_francisco_botanical_garden, vibe_sport, no).
attribute_value(strawberry_hill, vibe_sport, no).
attribute_value(pioneer_park, vibe_sport, no).
attribute_value(andytown_salesforce, vibe_sport, no).
attribute_value(sff_mission_bay, vibe_sport, yes).
attribute_value(benchmark_climbing, vibe_sport, yes).
attribute_value(ymca, vibe_sport, yes).
attribute_value(the_crossing, vibe_sport, yes).
attribute_value(lands_end, vibe_sport, yes).
attribute_value(china_camp_state_park, vibe_sport, yes).
attribute_value(joe_and_the_juice, vibe_sport, no).
attribute_value(peets_coffee, vibe_sport, no).
attribute_value(blue_bottle, vibe_sport, no).
attribute_value(motoring_coffee, vibe_sport, no).
attribute_value(cafe_reveille, vibe_sport, no).
attribute_value(him_mark_lai_branch_library, vibe_sport, no).
attribute_value(mission_bay_branch_library, vibe_sport, no).
attribute_value(sf_public_library, vibe_sport, no).
attribute_value(potrero_branch_library, vibe_sport, no).
attribute_value(golden_gate_valley_branch_library, vibe_sport, no).

% Walking distance
attribute_value(cherry_blossom_festival, walking_distance, no).
attribute_value(earth_day_festival, walking_distance, yes).
attribute_value(sf_art_fair, walking_distance, yes).
attribute_value(sunset_dunes_park, walking_distance, no).
attribute_value(candlelight_concert, walking_distance, no).
attribute_value(sf_giants_home_game, walking_distance, yes).
attribute_value(fat_ham_sf_playhouse, walking_distance, yes).
attribute_value(emotionair_installations, walking_distance, no).
attribute_value(bay_area_brew_festival, walking_distance, yes).
attribute_value(chess_night_game, walking_distance, no).
attribute_value(japanese_tea_garden, walking_distance, no).
attribute_value(dolores_park, walking_distance, yes).
attribute_value(downtown_first_thursdays, walking_distance, yes).
attribute_value(balloon_museum, walking_distance, no).
attribute_value(asian_art_museum, walking_distance, yes).
attribute_value(queen_wilhelmina_tulip_garden, walking_distance, no).
attribute_value(painted_ladies, walking_distance, yes).
attribute_value(fishermans_wharf, walking_distance, no).
attribute_value(golden_gate_park, walking_distance, no).
attribute_value(ina_coolbrith_park, walking_distance, yes).
attribute_value(san_francisco_botanical_garden, walking_distance, no).
attribute_value(strawberry_hill, walking_distance, no).
attribute_value(pioneer_park, walking_distance, yes).
attribute_value(andytown_salesforce, walking_distance, yes).
attribute_value(sff_mission_bay, walking_distance, yes).
attribute_value(benchmark_climbing, walking_distance, yes).
attribute_value(ymca, walking_distance, yes).
attribute_value(the_crossing, walking_distance, yes).
attribute_value(lands_end, walking_distance, no).
attribute_value(china_camp_state_park, walking_distance, no).
attribute_value(joe_and_the_juice, walking_distance, yes).
attribute_value(peets_coffee, walking_distance, yes).
attribute_value(blue_bottle, walking_distance, yes).
attribute_value(motoring_coffee, walking_distance, yes).
attribute_value(cafe_reveille, walking_distance, yes).
attribute_value(him_mark_lai_branch_library, walking_distance, yes).
attribute_value(mission_bay_branch_library, walking_distance, yes).
attribute_value(sf_public_library, walking_distance, yes).
attribute_value(potrero_branch_library, walking_distance, yes).
attribute_value(golden_gate_valley_branch_library, walking_distance, yes).

% Travel distance
attribute_value(cherry_blossom_festival, travel_distance, more_than_5km).
attribute_value(earth_day_festival, travel_distance, less_than_5km).
attribute_value(sf_art_fair, travel_distance, less_than_5km).
attribute_value(sunset_dunes_park, travel_distance, more_than_5km).
attribute_value(candlelight_concert, travel_distance, less_than_5km).
attribute_value(sf_giants_home_game, travel_distance, less_than_5km).
attribute_value(fat_ham_sf_playhouse, travel_distance, less_than_5km).
attribute_value(emotionair_installations, travel_distance, less_than_5km).
attribute_value(bay_area_brew_festival, travel_distance, less_than_5km).
attribute_value(chess_night_game, travel_distance, less_than_5km).
attribute_value(japanese_tea_garden, travel_distance, more_than_5km).
attribute_value(dolores_park, travel_distance, less_than_5km).
attribute_value(downtown_first_thursdays, travel_distance, less_than_5km).
attribute_value(balloon_museum, travel_distance, less_than_5km).
attribute_value(asian_art_museum, travel_distance, less_than_5km).
attribute_value(queen_wilhelmina_tulip_garden, travel_distance, more_than_5km).
attribute_value(painted_ladies, travel_distance, less_than_5km).
attribute_value(fishermans_wharf, travel_distance, less_than_5km).
attribute_value(golden_gate_park, travel_distance, more_than_5km).
attribute_value(ina_coolbrith_park, travel_distance, less_than_5km).
attribute_value(san_francisco_botanical_garden, travel_distance, more_than_5km).
attribute_value(strawberry_hill, travel_distance, more_than_5km).
attribute_value(pioneer_park, travel_distance, less_than_5km).
attribute_value(andytown_salesforce, travel_distance, less_than_5km).
attribute_value(sff_mission_bay, travel_distance, less_than_5km).
attribute_value(benchmark_climbing, travel_distance, less_than_5km).
attribute_value(ymca, travel_distance, less_than_5km).
attribute_value(the_crossing, travel_distance, less_than_5km).
attribute_value(lands_end, travel_distance, less_than_5km).
attribute_value(china_camp_state_park, travel_distance, more_than_5km).
attribute_value(joe_and_the_juice, travel_distance, less_than_5km).
attribute_value(peets_coffee, travel_distance, less_than_5km).
attribute_value(blue_bottle, travel_distance, less_than_5km).
attribute_value(motoring_coffee, travel_distance, less_than_5km).
attribute_value(cafe_reveille, travel_distance, less_than_5km).
attribute_value(him_mark_lai_branch_library, travel_distance, less_than_5km).
attribute_value(mission_bay_branch_library, travel_distance, less_than_5km).
attribute_value(sf_public_library, travel_distance, less_than_5km).
attribute_value(potrero_branch_library, travel_distance, less_than_5km).
attribute_value(golden_gate_valley_branch_library, travel_distance, less_than_5km).

% Food available
attribute_value(cherry_blossom_festival, food_available, yes).
attribute_value(earth_day_festival, food_available, yes).
attribute_value(sf_art_fair, food_available, yes).
attribute_value(sunset_dunes_park, food_available, no).
attribute_value(candlelight_concert, food_available, yes).
attribute_value(sf_giants_home_game, food_available, yes).
attribute_value(fat_ham_sf_playhouse, food_available, no).
attribute_value(emotionair_installations, food_available, no).
attribute_value(bay_area_brew_festival, food_available, yes).
attribute_value(chess_night_game, food_available, no).
attribute_value(japanese_tea_garden, food_available, yes).
attribute_value(dolores_park, food_available, yes).
attribute_value(downtown_first_thursdays, food_available, yes).
attribute_value(balloon_museum, food_available, yes).
attribute_value(asian_art_museum, food_available, yes).
attribute_value(queen_wilhelmina_tulip_garden, food_available, no).
attribute_value(painted_ladies, food_available, no).
attribute_value(fishermans_wharf, food_available, yes).
attribute_value(golden_gate_park, food_available, yes).
attribute_value(ina_coolbrith_park, food_available, no).
attribute_value(san_francisco_botanical_garden, food_available, yes).
attribute_value(strawberry_hill, food_available, no).
attribute_value(pioneer_park, food_available, no).
attribute_value(andytown_salesforce, food_available, yes).
attribute_value(sff_mission_bay, food_available, yes).
attribute_value(benchmark_climbing, food_available, no).
attribute_value(ymca, food_available, no).
attribute_value(the_crossing, food_available, yes).
attribute_value(lands_end, food_available, no).
attribute_value(china_camp_state_park, food_available, yes).
attribute_value(joe_and_the_juice, food_available, yes).
attribute_value(peets_coffee, food_available, yes).
attribute_value(blue_bottle, food_available, yes).
attribute_value(motoring_coffee, food_available, yes).
attribute_value(cafe_reveille, food_available, yes).
attribute_value(him_mark_lai_branch_library, food_available, no).
attribute_value(mission_bay_branch_library, food_available, no).
attribute_value(sf_public_library, food_available, no).
attribute_value(potrero_branch_library, food_available, no).
attribute_value(golden_gate_valley_branch_library, food_available, no).

% Plug needed
attribute_value(cherry_blossom_festival, plug_needed, no).
attribute_value(earth_day_festival, plug_needed, no).
attribute_value(sf_art_fair, plug_needed, no).
attribute_value(sunset_dunes_park, plug_needed, no).
attribute_value(candlelight_concert, plug_needed, no).
attribute_value(sf_giants_home_game, plug_needed, no).
attribute_value(fat_ham_sf_playhouse, plug_needed, no).
attribute_value(emotionair_installations, plug_needed, no).
attribute_value(bay_area_brew_festival, plug_needed, no).
attribute_value(chess_night_game, plug_needed, no).
attribute_value(japanese_tea_garden, plug_needed, no).
attribute_value(dolores_park, plug_needed, no).
attribute_value(downtown_first_thursdays, plug_needed, no).
attribute_value(balloon_museum, plug_needed, no).
attribute_value(asian_art_museum, plug_needed, no).
attribute_value(queen_wilhelmina_tulip_garden, plug_needed, no).
attribute_value(painted_ladies, plug_needed, no).
attribute_value(fishermans_wharf, plug_needed, no).
attribute_value(golden_gate_park, plug_needed, no).
attribute_value(ina_coolbrith_park, plug_needed, no).
attribute_value(san_francisco_botanical_garden, plug_needed, no).
attribute_value(strawberry_hill, plug_needed, no).
attribute_value(pioneer_park, plug_needed, no).
attribute_value(andytown_salesforce, plug_needed, yes).
attribute_value(sff_mission_bay, plug_needed, no).
attribute_value(benchmark_climbing, plug_needed, no).
attribute_value(ymca, plug_needed, no).
attribute_value(the_crossing, plug_needed, no).
attribute_value(lands_end, plug_needed, no).
attribute_value(china_camp_state_park, plug_needed, no).
attribute_value(joe_and_the_juice, plug_needed, yes).
attribute_value(peets_coffee, plug_needed, yes).
attribute_value(blue_bottle, plug_needed, yes).
attribute_value(motoring_coffee, plug_needed, no).
attribute_value(cafe_reveille, plug_needed, yes).
attribute_value(him_mark_lai_branch_library, plug_needed, yes).
attribute_value(mission_bay_branch_library, plug_needed, yes).
attribute_value(sf_public_library, plug_needed, yes).
attribute_value(potrero_branch_library, plug_needed, yes).
attribute_value(golden_gate_valley_branch_library, plug_needed, yes).

% WiFi needed
attribute_value(cherry_blossom_festival, wifi_needed, no).
attribute_value(earth_day_festival, wifi_needed, no).
attribute_value(sf_art_fair, wifi_needed, yes).
attribute_value(sunset_dunes_park, wifi_needed, no).
attribute_value(candlelight_concert, wifi_needed, no).
attribute_value(sf_giants_home_game, wifi_needed, no).
attribute_value(fat_ham_sf_playhouse, wifi_needed, no).
attribute_value(emotionair_installations, wifi_needed, no).
attribute_value(bay_area_brew_festival, wifi_needed, no).
attribute_value(chess_night_game, wifi_needed, no).
attribute_value(japanese_tea_garden, wifi_needed, no).
attribute_value(dolores_park, wifi_needed, no).
attribute_value(downtown_first_thursdays, wifi_needed, no).
attribute_value(balloon_museum, wifi_needed, no).
attribute_value(asian_art_museum, wifi_needed, yes).
attribute_value(queen_wilhelmina_tulip_garden, wifi_needed, no).
attribute_value(painted_ladies, wifi_needed, no).
attribute_value(fishermans_wharf, wifi_needed, yes).
attribute_value(golden_gate_park, wifi_needed, no).
attribute_value(ina_coolbrith_park, wifi_needed, no).
attribute_value(san_francisco_botanical_garden, wifi_needed, no).
attribute_value(strawberry_hill, wifi_needed, no).
attribute_value(pioneer_park, wifi_needed, no).
attribute_value(andytown_salesforce, wifi_needed, yes).
attribute_value(sff_mission_bay, wifi_needed, no).
attribute_value(benchmark_climbing, wifi_needed, yes).
attribute_value(ymca, wifi_needed, yes).
attribute_value(the_crossing, wifi_needed, yes).
attribute_value(lands_end, wifi_needed, no).
attribute_value(china_camp_state_park, wifi_needed, no).
attribute_value(joe_and_the_juice, wifi_needed, yes).
attribute_value(peets_coffee, wifi_needed, yes).
attribute_value(blue_bottle, wifi_needed, yes).
attribute_value(motoring_coffee, wifi_needed, yes).
attribute_value(cafe_reveille, wifi_needed, yes).
attribute_value(him_mark_lai_branch_library, wifi_needed, yes).
attribute_value(mission_bay_branch_library, wifi_needed, yes).
attribute_value(sf_public_library, wifi_needed, yes).
attribute_value(potrero_branch_library, wifi_needed, yes).
attribute_value(golden_gate_valley_branch_library, wifi_needed, yes).

% Ambience
attribute_value(cherry_blossom_festival, ambience, crowded).
attribute_value(earth_day_festival, ambience, crowded).
attribute_value(sf_art_fair, ambience, crowded).
attribute_value(sunset_dunes_park, ambience, crowded).
attribute_value(candlelight_concert, ambience, quiet).
attribute_value(sf_giants_home_game, ambience, crowded).
attribute_value(fat_ham_sf_playhouse, ambience, crowded).
attribute_value(emotionair_installations, ambience, crowded).
attribute_value(bay_area_brew_festival, ambience, crowded).
attribute_value(chess_night_game, ambience, quiet).
attribute_value(japanese_tea_garden, ambience, quiet).
attribute_value(dolores_park, ambience, crowded).
attribute_value(downtown_first_thursdays, ambience, crowded).
attribute_value(balloon_museum, ambience, crowded).
attribute_value(asian_art_museum, ambience, quiet).
attribute_value(queen_wilhelmina_tulip_garden, ambience, quiet).
attribute_value(painted_ladies, ambience, crowded).
attribute_value(fishermans_wharf, ambience, crowded).
attribute_value(golden_gate_park, ambience, crowded).
attribute_value(ina_coolbrith_park, ambience, quiet).
attribute_value(san_francisco_botanical_garden, ambience, quiet).
attribute_value(strawberry_hill, ambience, quiet).
attribute_value(pioneer_park, ambience, quiet).
attribute_value(andytown_salesforce, ambience, crowded).
attribute_value(sff_mission_bay, ambience, crowded).
attribute_value(benchmark_climbing, ambience, quiet).
attribute_value(ymca, ambience, quiet).
attribute_value(the_crossing, ambience, crowded).
attribute_value(lands_end, ambience, quiet).
attribute_value(china_camp_state_park, ambience, quiet).
attribute_value(joe_and_the_juice, ambience, crowded).
attribute_value(peets_coffee, ambience, crowded).
attribute_value(blue_bottle, ambience, quiet).
attribute_value(motoring_coffee, ambience, quiet).
attribute_value(cafe_reveille, ambience, quiet).
attribute_value(him_mark_lai_branch_library, ambience, quiet).
attribute_value(mission_bay_branch_library, ambience, quiet).
attribute_value(sf_public_library, ambience, quiet).
attribute_value(potrero_branch_library, ambience, quiet).
attribute_value(golden_gate_valley_branch_library, ambience, quiet).

% Wheelchair accessible
attribute_value(cherry_blossom_festival, wheelchair_accessible, yes).
attribute_value(earth_day_festival, wheelchair_accessible, yes).
attribute_value(sf_art_fair, wheelchair_accessible, yes).
attribute_value(sunset_dunes_park, wheelchair_accessible, yes).
attribute_value(candlelight_concert, wheelchair_accessible, yes).
attribute_value(sf_giants_home_game, wheelchair_accessible, yes).
attribute_value(fat_ham_sf_playhouse, wheelchair_accessible, yes).
attribute_value(emotionair_installations, wheelchair_accessible, yes).
attribute_value(bay_area_brew_festival, wheelchair_accessible, yes).
attribute_value(chess_night_game, wheelchair_accessible, yes).
attribute_value(japanese_tea_garden, wheelchair_accessible, yes).
attribute_value(dolores_park, wheelchair_accessible, yes).
attribute_value(downtown_first_thursdays, wheelchair_accessible, yes).
attribute_value(balloon_museum, wheelchair_accessible, yes).
attribute_value(asian_art_museum, wheelchair_accessible, yes).
attribute_value(queen_wilhelmina_tulip_garden, wheelchair_accessible, yes).
attribute_value(painted_ladies, wheelchair_accessible, yes).
attribute_value(fishermans_wharf, wheelchair_accessible, yes).
attribute_value(golden_gate_park, wheelchair_accessible, yes).
attribute_value(ina_coolbrith_park, wheelchair_accessible, no).
attribute_value(san_francisco_botanical_garden, wheelchair_accessible, yes).
attribute_value(strawberry_hill, wheelchair_accessible, no).
attribute_value(pioneer_park, wheelchair_accessible, yes).
attribute_value(andytown_salesforce, wheelchair_accessible, yes).
attribute_value(sff_mission_bay, wheelchair_accessible, yes).
attribute_value(benchmark_climbing, wheelchair_accessible, no).
attribute_value(ymca, wheelchair_accessible, yes).
attribute_value(the_crossing, wheelchair_accessible, yes).
attribute_value(lands_end, wheelchair_accessible, yes).
attribute_value(china_camp_state_park, wheelchair_accessible, yes).
attribute_value(joe_and_the_juice, wheelchair_accessible, yes).
attribute_value(peets_coffee, wheelchair_accessible, yes).
attribute_value(blue_bottle, wheelchair_accessible, yes).
attribute_value(motoring_coffee, wheelchair_accessible, yes).
attribute_value(cafe_reveille, wheelchair_accessible, yes).
attribute_value(him_mark_lai_branch_library, wheelchair_accessible, no).
attribute_value(mission_bay_branch_library, wheelchair_accessible, yes).
attribute_value(sf_public_library, wheelchair_accessible, no).
attribute_value(potrero_branch_library, wheelchair_accessible, yes).
attribute_value(golden_gate_valley_branch_library, wheelchair_accessible, yes).