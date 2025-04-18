% Dynamic declarations for known facts
:- dynamic known/3.

% Define valid values for each attribute
valid_location_type(indoor).
valid_location_type(outdoor).
valid_location_type(both).

valid_budget(free).
valid_budget(low).
valid_budget(high).

valid_distance(short).
valid_distance(medium).
valid_distance(high).

valid_ambience(quiet).
valid_ambience(crowded).

% Modified askables
askable(location_type, X) :- valid_location_type(X).
askable(budget, X) :- valid_budget(X).
askable(vibe, _).  % vibe can be any value
askable(distance, X) :- valid_distance(X).
askable(food, X) :- member(X, [yes, no]).
askable(plugs, X) :- member(X, [yes, no]).
askable(wifi, X) :- member(X, [yes, no]).
askable(ambience, X) :- valid_ambience(X).
askable(wheelchair, X) :- member(X, [yes, no]).

% Place facts - these define the properties of each place
% Cherry Blossom Festival
place(cherry_blossom_festival).
name(cherry_blossom_festival, "Cherry Blossom Festival").
description(cherry_blossom_festival, "Traditional Japanese Performances, food stalls, and cultural exhibitions").
address(cherry_blossom_festival, "1610 Geary Blvd").
website(cherry_blossom_festival, "https://sfcherryblossom.org/").
location_type(cherry_blossom_festival, outdoor).
budget(cherry_blossom_festival, free).
vibe(cherry_blossom_festival, chill).
vibe(cherry_blossom_festival, social).
vibe(cherry_blossom_festival, romantic).
distance(cherry_blossom_festival, high).
food(cherry_blossom_festival, yes).
plugs(cherry_blossom_festival, no).
wifi(cherry_blossom_festival, no).
ambience(cherry_blossom_festival, crowded).
wheelchair(cherry_blossom_festival, yes).

% Earth Day Festival
place(earth_day_festival).
name(earth_day_festival, "Earth Day Festival").
description(earth_day_festival, "Earth Day celebration with live music, eco-friendly vendors, educational workshops.").
address(earth_day_festival, "750 Howard St.").
website(earth_day_festival, "https://yerbabuenagardens.org/events/2025earthday/").
location_type(earth_day_festival, outdoor).
budget(earth_day_festival, free).
vibe(earth_day_festival, chill).
vibe(earth_day_festival, social).
vibe(earth_day_festival, romantic).
distance(earth_day_festival, short).
food(earth_day_festival, yes).
plugs(earth_day_festival, no).
wifi(earth_day_festival, no).
ambience(earth_day_festival, crowded).
wheelchair(earth_day_festival, yes).

% SF Art Fair
place(sf_art_fair).
name(sf_art_fair, "SF Art Fair").
description(sf_art_fair, "Contemporary and Modern artworks from over 70 galleries.").
address(sf_art_fair, "2 Marina Blvd Landmark Building C, Suite 260").
website(sf_art_fair, "https://sanfranciscoartfair.com/").
location_type(sf_art_fair, indoor).
budget(sf_art_fair, free).
vibe(sf_art_fair, chill).
vibe(sf_art_fair, social).
vibe(sf_art_fair, romantic).
distance(sf_art_fair, short).
food(sf_art_fair, yes).
plugs(sf_art_fair, no).
wifi(sf_art_fair, yes).
ambience(sf_art_fair, crowded).
wheelchair(sf_art_fair, yes).

% Sunset Dunes Park
place(sunset_dunes_park).
name(sunset_dunes_park, "Sunset Dunes Park").
description(sunset_dunes_park, "Oceanfront Park.").
address(sunset_dunes_park, "Great Hwy & Noriega St.").
website(sunset_dunes_park, "https://sfrecpark.org/1555/Sunset-Dunes").
location_type(sunset_dunes_park, outdoor).
budget(sunset_dunes_park, free).
vibe(sunset_dunes_park, chill).
vibe(sunset_dunes_park, social).
vibe(sunset_dunes_park, romantic).
distance(sunset_dunes_park, high).
food(sunset_dunes_park, no).
plugs(sunset_dunes_park, no).
wifi(sunset_dunes_park, no).
ambience(sunset_dunes_park, crowded).
wheelchair(sunset_dunes_park, yes).

% Candlelight Concert 
place(candlelight_concert).
name(candlelight_concert, "Candlelight Concert ").
description(candlelight_concert, "Classical Music in candlelight settings").
address(candlelight_concert, "4705 3rd St.").
website(candlelight_concert, "https://www.san-francisco-theater.com/shows/bayview-opera-house/candlelight-rings-dragons").
location_type(candlelight_concert, indoor).
budget(candlelight_concert, high).
vibe(candlelight_concert, romantic).
distance(candlelight_concert, medium).
food(candlelight_concert, yes).
plugs(candlelight_concert, no).
wifi(candlelight_concert, no).
ambience(candlelight_concert, quiet).
wheelchair(candlelight_concert, yes).

% SF Giants Home Game
place(sf_giants_home_game).
name(sf_giants_home_game, "SF Giants Home Game").
description(sf_giants_home_game, "Baseball Game").
address(sf_giants_home_game, "24 Willie Mays Plaza").
website(sf_giants_home_game, "https://www.mlb.com/giants").
location_type(sf_giants_home_game, outdoor).
budget(sf_giants_home_game, high).
vibe(sf_giants_home_game, social).
vibe(sf_giants_home_game, sports).
distance(sf_giants_home_game, short).
food(sf_giants_home_game, yes).
plugs(sf_giants_home_game, no).
wifi(sf_giants_home_game, no).
ambience(sf_giants_home_game, crowded).
wheelchair(sf_giants_home_game, yes).

% Fat Ham at SF Playhouse
place(fat_ham_at_sf_playhouse).
name(fat_ham_at_sf_playhouse, "Fat Ham at SF Playhouse").
description(fat_ham_at_sf_playhouse, "James Ijames' Pulitzer Prize-winning play: a modern, queer Southern reimagining of Shakespeare's Hamlet, set at a family barbecue. ").
address(fat_ham_at_sf_playhouse, "450 Post St.").
website(fat_ham_at_sf_playhouse, "https://www.sfplayhouse.org/sfph/2024-2025-season/fat-ham/?gad_source=1&gclid=Cj0KCQjwqv2_BhC0ARIsAFb5Ac_PZL3wgtD6MKEBr5RZrIHPc5j5p7ErY3qlyWIQ4m4-KwIfcF-M-zoaAuOiEALw_wcB").
location_type(fat_ham_at_sf_playhouse, indoor).
budget(fat_ham_at_sf_playhouse, low).
vibe(fat_ham_at_sf_playhouse, chill).
vibe(fat_ham_at_sf_playhouse, social).
vibe(fat_ham_at_sf_playhouse, romantic).
distance(fat_ham_at_sf_playhouse, short).
food(fat_ham_at_sf_playhouse, no).
plugs(fat_ham_at_sf_playhouse, no).
wifi(fat_ham_at_sf_playhouse, no).
ambience(fat_ham_at_sf_playhouse, crowded).
wheelchair(fat_ham_at_sf_playhouse, yes).

% EmotionAir Installations
place(emotionair_installations).
name(emotionair_installations, "EmotionAir Installations").
description(emotionair_installations, "Inflatable Installations, blending art with emotion in a sensory experience.").
address(emotionair_installations, "3601 Lyon St").
website(emotionair_installations, "https://tickets.balloonmuseum.world/emotion-air-san-francisco/?gad_source=1&gclid=Cj0KCQjwqv2_BhC0ARIsAFb5Ac8GVm8JeJQtqndnk1Xynk8Uce4j3ij6di9ZrCZO1vd8-p8veVG_M5EaAk2aEALw_wcB").
location_type(emotionair_installations, indoor).
budget(emotionair_installations, high).
vibe(emotionair_installations, social).
vibe(emotionair_installations, romantic).
distance(emotionair_installations, medium).
food(emotionair_installations, no).
plugs(emotionair_installations, no).
wifi(emotionair_installations, no).
ambience(emotionair_installations, crowded).
wheelchair(emotionair_installations, yes).

% Bay Area Brew Festival
place(bay_area_brew_festival).
name(bay_area_brew_festival, "Bay Area Brew Festival").
description(bay_area_brew_festival, "Featuring over 50 beweries, beers, food trucks and DJs.").
address(bay_area_brew_festival, "105 Montgomery St.").
website(bay_area_brew_festival, "https://www.bayareabrewfestival.com/").
location_type(bay_area_brew_festival, outdoor).
budget(bay_area_brew_festival, high).
vibe(bay_area_brew_festival, social).
vibe(bay_area_brew_festival, chill).
distance(bay_area_brew_festival, short).
food(bay_area_brew_festival, yes).
plugs(bay_area_brew_festival, no).
wifi(bay_area_brew_festival, no).
ambience(bay_area_brew_festival, crowded).
wheelchair(bay_area_brew_festival, yes).

% Chess Night Game
place(chess_night_game).
name(chess_night_game, "Chess Night Game").
description(chess_night_game, "Play chess with strangers and socialize").
address(chess_night_game, "2131 Lombard Street").
website(chess_night_game, "https://docs.google.com/spreadsheets/d/12YhXN0mMB7BfGv36T4jn-orYDwi7aN9JXiVeZ5eKl98/edit?gid=0#gid=0 ").
location_type(chess_night_game, outdoor).
budget(chess_night_game, free).
vibe(chess_night_game, social).
vibe(chess_night_game, chill).
distance(chess_night_game, medium).
food(chess_night_game, no).
plugs(chess_night_game, yes).
wifi(chess_night_game, yes).
ambience(chess_night_game, crowded).
wheelchair(chess_night_game, yes).

% Japanese Tea Garden Visit
place(japanese_tea_garden_visit).
name(japanese_tea_garden_visit, "Japanese Tea Garden Visit").
description(japanese_tea_garden_visit, "Located in Golden Gate Park, this serene garden features traditional Japanese architecture, koi ponds, bonsai trees, and a tea house.").
address(japanese_tea_garden_visit, "75 Hagiwara Tea Garden Drive").
website(japanese_tea_garden_visit, "https://gggp.org/japanese-tea-garden/?gad_source=1&gad_campaignid=21017713825&gclid=Cj0KCQjwqv2_BhC0ARIsAFb5Ac-Eh3nR-L57seTH6H2SMpxTf71qTdLXxLEWIq_fQquu9sGRzOaf1CYaAl5fEALw_wcB").
location_type(japanese_tea_garden_visit, outdoor).
budget(japanese_tea_garden_visit, low).
vibe(japanese_tea_garden_visit, romantic).
vibe(japanese_tea_garden_visit, chill).
distance(japanese_tea_garden_visit, medium).
food(japanese_tea_garden_visit, no).
plugs(japanese_tea_garden_visit, no).
wifi(japanese_tea_garden_visit, yes).
ambience(japanese_tea_garden_visit, quiet).
wheelchair(japanese_tea_garden_visit, yes).

% Dolores Park
place(dolores_park).
name(dolores_park, "Dolores Park").
description(dolores_park, "A vibrant and scenic park in the Mission District, known for its sunny weather, stunning views of downtown SF.").
address(dolores_park, "19th street").
website(dolores_park, "https://sfrecpark.org/facilities/facility/details/Mission-Dolores-Park-188").
location_type(dolores_park, outdoor).
budget(dolores_park, free).
vibe(dolores_park, romantic).
vibe(dolores_park, chill).
vibe(dolores_park, social).
distance(dolores_park, short).
food(dolores_park, no).
plugs(dolores_park, no).
wifi(dolores_park, no).
ambience(dolores_park, crowded).
wheelchair(dolores_park, yes).

% Downtown First Thursdays
place(downtown_first_thursdays).
name(downtown_first_thursdays, "Downtown First Thursdays").
description(downtown_first_thursdays, "A monthly art and culture night where museums, galleries, and local businesses in downtown areas open late with free or discounted admission, special exhibits, and live performances.").
address(downtown_first_thursdays, "Between Market & Howard").
website(downtown_first_thursdays, "https://www.dftsf.com/").
location_type(downtown_first_thursdays, outdoor).
budget(downtown_first_thursdays, low).
vibe(downtown_first_thursdays, social).
vibe(downtown_first_thursdays, chill).
distance(downtown_first_thursdays, short).
food(downtown_first_thursdays, yes).
plugs(downtown_first_thursdays, no).
wifi(downtown_first_thursdays, no).
ambience(downtown_first_thursdays, crowded).
wheelchair(downtown_first_thursdays, yes).

% Balloon Museum
place(balloon_museum).
name(balloon_museum, "Balloon Museum").
description(balloon_museum, "The museum of inflatable art with 60 artists from around the globe").
address(balloon_museum, "Palace of Fine Arts").
website(balloon_museum, "https://tickets.balloonmuseum.world/emotion-air-san-francisco/").
location_type(balloon_museum, indoor).
budget(balloon_museum, low).
vibe(balloon_museum, social).
vibe(balloon_museum, chill).
distance(balloon_museum, medium).
food(balloon_museum, no).
plugs(balloon_museum, no).
wifi(balloon_museum, yes).
ambience(balloon_museum, crowded).
wheelchair(balloon_museum, yes).

% Asian Art Museum
place(asian_art_museum).
name(asian_art_museum, "Asian Art Museum").
description(asian_art_museum, "One of the largest museums in the Western world devoted exclusively to Asian art.").
address(asian_art_museum, "Larkin Street").
website(asian_art_museum, "https://asianart.org/?gad_source=1&gad_campaignid=21002195167&gclid=Cj0KCQjwqv2_BhC0ARIsAFb5Ac9JjXW2mpFTOjkJRc7lv_iL_1c0v5G2F2ThPgxyWKOT8Zqk7aieWxIaAoZREALw_wcB").
location_type(asian_art_museum, indoor).
budget(asian_art_museum, low).
vibe(asian_art_museum, social).
vibe(asian_art_museum, chill).
distance(asian_art_museum, short).
food(asian_art_museum, no).
plugs(asian_art_museum, yes).
wifi(asian_art_museum, yes).
ambience(asian_art_museum, quiet).
wheelchair(asian_art_museum, yes).

% Queen Wilhelmina Tulip Garden
place(queen_wilhelmina_tulip_garden).
name(queen_wilhelmina_tulip_garden, "Queen Wilhelmina Tulip Garden").
description(queen_wilhelmina_tulip_garden, "A beautiful, seasonal garden located near the Dutch Windmill in Golden Gate Park. It's filled with vibrant tulips and other spring flowers. ").
address(queen_wilhelmina_tulip_garden, "1690 John F Kennedy Dr, SF").
website(queen_wilhelmina_tulip_garden, "https://sfrecpark.org/908/Golden-Gate-Park---Queen-Wilhelmina-Gard").
location_type(queen_wilhelmina_tulip_garden, outdoor).
budget(queen_wilhelmina_tulip_garden, free).
vibe(queen_wilhelmina_tulip_garden, chill).
distance(queen_wilhelmina_tulip_garden, high).
food(queen_wilhelmina_tulip_garden, no).
plugs(queen_wilhelmina_tulip_garden, no).
wifi(queen_wilhelmina_tulip_garden, no).
ambience(queen_wilhelmina_tulip_garden, quiet).
wheelchair(queen_wilhelmina_tulip_garden, yes).

% Painted Ladies
place(painted_ladies).
name(painted_ladies, "Painted Ladies").
description(painted_ladies, "Iconic Victorian-style houses famous for their vibrant colors and postcard-perfect view with the San Francisco skyline in the background.").
address(painted_ladies, "San Francisco, CA 94117").
website(painted_ladies, "https://www.sftravel.com/things-to-do/attractions/iconic-sf/painted-ladies").
location_type(painted_ladies, outdoor).
budget(painted_ladies, free).
vibe(painted_ladies, chill).
vibe(painted_ladies, social).
vibe(painted_ladies, romantic).
distance(painted_ladies, medium).
food(painted_ladies, no).
plugs(painted_ladies, yes).
wifi(painted_ladies, no).
ambience(painted_ladies, crowded).
wheelchair(painted_ladies, yes).

% Fisherman's wharf
place(fisherman_s_wharf).
name(fisherman_s_wharf, "Fisherman's wharf").
description(fisherman_s_wharf, "The neighborhood known for its seafood (especially clam chowder in sourdough bowls), street performers, sea lions at Pier 39, souvenir shops, and attractions like Madame Tussauds and the Aquarium.").
address(fisherman_s_wharf, "Beach street").
website(fisherman_s_wharf, "https://www.fishermanswharf.org/").
location_type(fisherman_s_wharf, both).
budget(fisherman_s_wharf, low).
vibe(fisherman_s_wharf, chill).
vibe(fisherman_s_wharf, social).
vibe(fisherman_s_wharf, romantic).
distance(fisherman_s_wharf, medium).
food(fisherman_s_wharf, yes).
plugs(fisherman_s_wharf, no).
wifi(fisherman_s_wharf, no).
ambience(fisherman_s_wharf, crowded).
wheelchair(fisherman_s_wharf, yes).

% Golden Gate Park
place(golden_gate_park).
name(golden_gate_park, "Golden Gate Park").
description(golden_gate_park, "A massive urban park stretching over 1,000 acres, larger than Central Park in NYC. It’s home to museums, gardens, trails, lakes, bison paddocks, and more.").
address(golden_gate_park, "501 Stanyan St, San Francisco").
website(golden_gate_park, "https://sfrecpark.org/770/Golden-Gate-Park").
location_type(golden_gate_park, outdoor).
budget(golden_gate_park, free).
vibe(golden_gate_park, chill).
vibe(golden_gate_park, social).
vibe(golden_gate_park, romantic).
vibe(golden_gate_park, sport).
distance(golden_gate_park, medium).
food(golden_gate_park, no).
plugs(golden_gate_park, no).
wifi(golden_gate_park, no).
ambience(golden_gate_park, quiet).
wheelchair(golden_gate_park, yes).

% Ina Coolbrith Park
place(ina_coolbrith_park).
name(ina_coolbrith_park, "Ina Coolbrith Park").
description(ina_coolbrith_park, "A small, hidden gem in the Russian Hill neighborhood offering one of the best panoramic views of the Bay Bridge, Coit Tower, and downtown SF").
address(ina_coolbrith_park, "Vallejo & Taylor, Vallejo Street").
website(ina_coolbrith_park, "https://sanfranciscoparksalliance.org/explore-parks/ina-coolbrith-park/").
location_type(ina_coolbrith_park, outdoor).
budget(ina_coolbrith_park, free).
vibe(ina_coolbrith_park, chill).
vibe(ina_coolbrith_park, social).
vibe(ina_coolbrith_park, romantic).
distance(ina_coolbrith_park, short).
food(ina_coolbrith_park, no).
plugs(ina_coolbrith_park, no).
wifi(ina_coolbrith_park, no).
ambience(ina_coolbrith_park, quiet).
wheelchair(ina_coolbrith_park, no).

% San Francisco Botanical Garden
place(san_francisco_botanical_garden).
name(san_francisco_botanical_garden, "San Francisco Botanical Garden").
description(san_francisco_botanical_garden, "Located within Golden Gate Park, garden contains over 8,000 different kinds of plants from around the world.").
address(san_francisco_botanical_garden, "9th Avenue").
website(san_francisco_botanical_garden, "https://gggp.org/san-francisco-botanical-garden/").
location_type(san_francisco_botanical_garden, outdoor).
budget(san_francisco_botanical_garden, low).
vibe(san_francisco_botanical_garden, chill).
vibe(san_francisco_botanical_garden, social).
vibe(san_francisco_botanical_garden, romantic).
distance(san_francisco_botanical_garden, high).
food(san_francisco_botanical_garden, no).
plugs(san_francisco_botanical_garden, no).
wifi(san_francisco_botanical_garden, no).
ambience(san_francisco_botanical_garden, quiet).
wheelchair(san_francisco_botanical_garden, yes).

% Strawberry Hill
place(strawberry_hill).
name(strawberry_hill, "Strawberry Hill").
description(strawberry_hill, "A hill in the middle of Stow Lake within Golden Gate Park. Features walking trails, a waterfall, and peaceful spots to sit and enjoy nature").
address(strawberry_hill, "Golden Gate Park").
website(strawberry_hill, "https://en.wikipedia.org/wiki/Strawberry_Hill_(San_Francisco)").
location_type(strawberry_hill, outdoor).
budget(strawberry_hill, free).
vibe(strawberry_hill, chill).
vibe(strawberry_hill, sport).
vibe(strawberry_hill, social).
vibe(strawberry_hill, romantic).
distance(strawberry_hill, high).
food(strawberry_hill, no).
plugs(strawberry_hill, no).
wifi(strawberry_hill, no).
ambience(strawberry_hill, quiet).
wheelchair(strawberry_hill, no).

% Pioneer Park
place(pioneer_park).
name(pioneer_park, "Pioneer Park").
description(pioneer_park, "Home to the famous Coit Tower, this park sits atop Telegraph Hill and offers sweeping views of the Bay Area").
address(pioneer_park, "Telegram Hill Boulevard").
website(pioneer_park, "https://maps.app.goo.gl/VVk6ime2wVdmyF7fA?g_st=com.google.maps.preview.copy ").
location_type(pioneer_park, outdoor).
budget(pioneer_park, free).
vibe(pioneer_park, chill).
vibe(pioneer_park, social).
vibe(pioneer_park, romantic).
distance(pioneer_park, short).
food(pioneer_park, no).
plugs(pioneer_park, no).
wifi(pioneer_park, no).
ambience(pioneer_park, quiet).
wheelchair(pioneer_park, yes).

% AndyTown Salesforce
place(andytown_salesforce).
name(andytown_salesforce, "AndyTown Salesforce").
description(andytown_salesforce, "Cafe to Study around Salesforce Tower with a park nearby").
address(andytown_salesforce, "Rooftop, Park Level, 181 Fremont St, San Francisco, CA 94105").
website(andytown_salesforce, "https://www.andytownsf.com/locations?srsltid=AfmBOopalwo_B552eDfWKsWu5wFWE6ITzZCe0bDOoqDBrAcTrXyEr2PG").
location_type(andytown_salesforce, indoor).
budget(andytown_salesforce, low).
vibe(andytown_salesforce, study).
vibe(andytown_salesforce, chill).
vibe(andytown_salesforce, social).
distance(andytown_salesforce, short).
food(andytown_salesforce, yes).
plugs(andytown_salesforce, yes).
wifi(andytown_salesforce, yes).
ambience(andytown_salesforce, quiet).
wheelchair(andytown_salesforce, yes).

% SFF Mission Bay
place(sff_mission_bay).
name(sff_mission_bay, "SFF Mission Bay").
description(sff_mission_bay, "Play soccer here, solo or with your friends").
address(sff_mission_bay, "701 Mission Bay Boulevard North, San Francisco, CA 94158").
website(sff_mission_bay, "https://www.sffsoccer.com/").
location_type(sff_mission_bay, outdoor).
budget(sff_mission_bay, free).
vibe(sff_mission_bay, sport).
vibe(sff_mission_bay, social).
distance(sff_mission_bay, short).
food(sff_mission_bay, yes).
plugs(sff_mission_bay, no).
wifi(sff_mission_bay, no).
ambience(sff_mission_bay, crowded).
wheelchair(sff_mission_bay, yes).

% Benchmark Climbing
place(benchmark_climbing).
name(benchmark_climbing, "Benchmark Climbing").
description(benchmark_climbing, "Indoor climibing").
address(benchmark_climbing, "1414 Van Ness Ave, San Francisco, CA 94109").
website(benchmark_climbing, "https://www.benchmarkclimbing.com/").
location_type(benchmark_climbing, indoor).
budget(benchmark_climbing, high).
vibe(benchmark_climbing, sport).
vibe(benchmark_climbing, social).
distance(benchmark_climbing, short).
food(benchmark_climbing, no).
plugs(benchmark_climbing, no).
wifi(benchmark_climbing, yes).
ambience(benchmark_climbing, quiet).
wheelchair(benchmark_climbing, no).

% YMCA
place(ymca).
name(ymca, "YMCA").
description(ymca, "Gym, swimming, sauna, etc").
address(ymca, "169 Steuart St, San Francisco, CA 94105").
website(ymca, "https://www.ymcasf.org/location/embarcadero-ymca/").
location_type(ymca, indoor).
budget(ymca, high).
vibe(ymca, sport).
distance(ymca, short).
food(ymca, no).
plugs(ymca, no).
wifi(ymca, yes).
ambience(ymca, quiet).
wheelchair(ymca, yes).

% The Crossing
place(the_crossing).
name(the_crossing, "The Crossing").
description(the_crossing, "Paddle").
address(the_crossing, "250 Main St, San Francisco, CA 94105").
website(the_crossing, "https://www.eastcutcrossing.com/").
location_type(the_crossing, outdoor).
budget(the_crossing, high).
vibe(the_crossing, sport).
vibe(the_crossing, social).
distance(the_crossing, short).
food(the_crossing, yes).
plugs(the_crossing, no).
wifi(the_crossing, yes).
ambience(the_crossing, crowded).
wheelchair(the_crossing, yes).

% Lands End
place(lands_end).
name(lands_end, "Lands End").
description(lands_end, "Hiking").
address(lands_end, "680 Point Lobos Ave, San Francisco, CA 94121").
website(lands_end, "https://www.nps.gov/goga/planyourvisit/landsend.htm").
location_type(lands_end, outdoor).
budget(lands_end, free).
vibe(lands_end, sport).
vibe(lands_end, social).
distance(lands_end, medium).
food(lands_end, no).
plugs(lands_end, no).
wifi(lands_end, no).
ambience(lands_end, quiet).
wheelchair(lands_end, yes).

% China Camp State Park
place(china_camp_state_park).
name(china_camp_state_park, "China Camp State Park").
description(china_camp_state_park, "Camping").
address(china_camp_state_park, "101 Peacock Gap Trail, San Rafael, CA 94901").
website(china_camp_state_park, "https://friendsofchinacamp.org/").
location_type(china_camp_state_park, outdoor).
budget(china_camp_state_park, high).
vibe(china_camp_state_park, chill).
vibe(china_camp_state_park, sport).
vibe(china_camp_state_park, social).
vibe(china_camp_state_park, romantic).
distance(china_camp_state_park, high).
food(china_camp_state_park, yes).
plugs(china_camp_state_park, no).
wifi(china_camp_state_park, no).
ambience(china_camp_state_park, quiet).
wheelchair(china_camp_state_park, unknown).

% Joe & the Juice
place(joe__the_juice).
name(joe__the_juice, "Joe & the Juice").
description(joe__the_juice, "Cafe to study").
address(joe__the_juice, "235 Montgomery St.").
website(joe__the_juice, "https://www.joejuice.com/").
location_type(joe__the_juice, indoor).
budget(joe__the_juice, low).
vibe(joe__the_juice, chill).
vibe(joe__the_juice, study).
vibe(joe__the_juice, social).
distance(joe__the_juice, short).
food(joe__the_juice, yes).
plugs(joe__the_juice, yes).
wifi(joe__the_juice, yes).
ambience(joe__the_juice, crowded).
wheelchair(joe__the_juice, yes).

% Peets Coffee
place(peets_coffee).
name(peets_coffee, "Peets Coffee").
description(peets_coffee, "Cafe to study").
address(peets_coffee, "773 Market street").
website(peets_coffee, "https://www.peets.com/pages/store-locator?stockist-query=San%20Francisco,%20CA,%20USA&selected=773%20Market%20St.").
location_type(peets_coffee, indoor).
budget(peets_coffee, low).
vibe(peets_coffee, chill).
vibe(peets_coffee, study).
vibe(peets_coffee, social).
distance(peets_coffee, short).
food(peets_coffee, yes).
plugs(peets_coffee, yes).
wifi(peets_coffee, yes).
ambience(peets_coffee, crowded).
wheelchair(peets_coffee, yes).

% Blue Bottle
place(blue_bottle).
name(blue_bottle, "Blue Bottle").
description(blue_bottle, "Cafe to study").
address(blue_bottle, "705 Market Street").
website(blue_bottle, "https://bluebottlecoffee.com/us/eng").
location_type(blue_bottle, indoor).
budget(blue_bottle, low).
vibe(blue_bottle, chill).
vibe(blue_bottle, study).
vibe(blue_bottle, social).
distance(blue_bottle, short).
food(blue_bottle, yes).
plugs(blue_bottle, yes).
wifi(blue_bottle, yes).
ambience(blue_bottle, quiet).
wheelchair(blue_bottle, yes).

% Motoring coffee
place(motoring_coffee).
name(motoring_coffee, "Motoring coffee").
description(motoring_coffee, "Cafe to study").
address(motoring_coffee, "1525 Union street").
website(motoring_coffee, "https://www.motoring.coffee/").
location_type(motoring_coffee, indoor).
budget(motoring_coffee, low).
vibe(motoring_coffee, chill).
vibe(motoring_coffee, study).
vibe(motoring_coffee, social).
distance(motoring_coffee, short).
food(motoring_coffee, yes).
plugs(motoring_coffee, no).
wifi(motoring_coffee, yes).
ambience(motoring_coffee, quiet).
wheelchair(motoring_coffee, yes).

% Cafe Reveille
place(cafe_reveille).
name(cafe_reveille, "Cafe Reveille").
description(cafe_reveille, "Cafe to study").
address(cafe_reveille, "1998 Polk street").
website(cafe_reveille, "https://www.cafereveille.com/").
location_type(cafe_reveille, indoor).
budget(cafe_reveille, low).
vibe(cafe_reveille, chill).
vibe(cafe_reveille, study).
vibe(cafe_reveille, social).
distance(cafe_reveille, short).
food(cafe_reveille, yes).
plugs(cafe_reveille, yes).
wifi(cafe_reveille, yes).
ambience(cafe_reveille, quiet).
wheelchair(cafe_reveille, yes).

% Him Mark Lai Branch Library
place(him_mark_lai_branch_library).
name(him_mark_lai_branch_library, "Him Mark Lai Branch Library").
description(him_mark_lai_branch_library, "Chinatown Library").
address(him_mark_lai_branch_library, "1135 Powell street").
website(him_mark_lai_branch_library, "https://sfpl.org/locations/chinatown").
location_type(him_mark_lai_branch_library, indoor).
budget(him_mark_lai_branch_library, free).
vibe(him_mark_lai_branch_library, study).
distance(him_mark_lai_branch_library, short).
food(him_mark_lai_branch_library, no).
plugs(him_mark_lai_branch_library, yes).
wifi(him_mark_lai_branch_library, yes).
ambience(him_mark_lai_branch_library, quiet).
wheelchair(him_mark_lai_branch_library, no).

% Mission Bay Branch Library
place(mission_bay_branch_library).
name(mission_bay_branch_library, "Mission Bay Branch Library").
description(mission_bay_branch_library, "Mission Bay Branch Library").
address(mission_bay_branch_library, "960 4th street").
website(mission_bay_branch_library, "https://sfpl.org/locations/mission-bay").
location_type(mission_bay_branch_library, indoor).
budget(mission_bay_branch_library, free).
vibe(mission_bay_branch_library, study).
distance(mission_bay_branch_library, short).
food(mission_bay_branch_library, no).
plugs(mission_bay_branch_library, yes).
wifi(mission_bay_branch_library, yes).
ambience(mission_bay_branch_library, quiet).
wheelchair(mission_bay_branch_library, yes).

% SF Public Library
place(sf_public_library).
name(sf_public_library, "SF Public Library").
description(sf_public_library, "Public Library in SF, the main branch").
address(sf_public_library, "100 Larkin Street").
website(sf_public_library, "https://sfpl.org/locations/main-library").
location_type(sf_public_library, indoor).
budget(sf_public_library, free).
vibe(sf_public_library, study).
distance(sf_public_library, short).
food(sf_public_library, no).
plugs(sf_public_library, yes).
wifi(sf_public_library, yes).
ambience(sf_public_library, quiet).
wheelchair(sf_public_library, no).

% Potrero Branch Library
place(potrero_branch_library).
name(potrero_branch_library, "Potrero Branch Library").
description(potrero_branch_library, "Potrero Branch Library").
address(potrero_branch_library, "1616 20th Street").
website(potrero_branch_library, "https://sfpl.org/locations/potrero").
location_type(potrero_branch_library, indoor).
budget(potrero_branch_library, free).
vibe(potrero_branch_library, study).
distance(potrero_branch_library, short).
food(potrero_branch_library, no).
plugs(potrero_branch_library, yes).
wifi(potrero_branch_library, yes).
ambience(potrero_branch_library, quiet).
wheelchair(potrero_branch_library, yes).

% Golden Gate Valley Branch Library
place(golden_gate_valley_branch_library).
name(golden_gate_valley_branch_library, "Golden Gate Valley Branch Library").
description(golden_gate_valley_branch_library, "Golden Gate Valley Branch Library").
address(golden_gate_valley_branch_library, "1801 Green Street").
website(golden_gate_valley_branch_library, "https://sfpl.org/locations/golden-gate-valley").
location_type(golden_gate_valley_branch_library, indoor).
budget(golden_gate_valley_branch_library, free).
vibe(golden_gate_valley_branch_library, study).
distance(golden_gate_valley_branch_library, short).
food(golden_gate_valley_branch_library, no).
plugs(golden_gate_valley_branch_library, yes).
wifi(golden_gate_valley_branch_library, yes).
ambience(golden_gate_valley_branch_library, quiet).
wheelchair(golden_gate_valley_branch_library, yes).

% Modified recommendation rules
recommendation(Place) :-
    place(Place),
    check_location_type(Place),
    check_budget(Place),
    check_vibe(Place),
    check_distance(Place),
    check_amenities(Place),
    check_food(Place),
    check_ambience(Place),
    check_wheelchair(Place).

% Helper predicates for checking attributes
check_location_type(Place) :-
    \+ known(yes, location_type, _) -> true;
    known(yes, location_type, Type),
    askable(location_type, Type),
    (location_type(Place, Type); location_type(Place, both)).

check_budget(Place) :-
    \+ known(yes, budget, _) -> true;
    known(yes, budget, B),
    askable(budget, B),
    budget(Place, B).

check_vibe(Place) :-
    \+ known(yes, vibe, _) -> true;
    known(yes, vibe, V),
    vibe(Place, V).

check_distance(Place) :-
    \+ known(yes, distance, _) -> true;
    known(yes, distance, D),
    askable(distance, D),
    distance(Place, D).

check_amenities(Place) :-
    location_type(Place, outdoor) -> true;
    check_plugs(Place),
    check_wifi(Place).

check_plugs(Place) :-
    \+ known(yes, plugs, _) -> true;
    known(yes, plugs, P),
    askable(plugs, P),
    plugs(Place, P).

check_wifi(Place) :-
    \+ known(yes, wifi, _) -> true;
    known(yes, wifi, W),
    askable(wifi, W),
    wifi(Place, W).

check_food(Place) :-
    \+ known(yes, food, _) -> true;
    known(yes, food, F),
    askable(food, F),
    food(Place, F).

check_ambience(Place) :-
    \+ known(yes, ambience, _) -> true;
    known(yes, ambience, A),
    askable(ambience, A),
    ambience(Place, A).

check_wheelchair(Place) :-
    \+ known(yes, wheelchair, _) -> true;
    known(yes, wheelchair, W),
    askable(wheelchair, W),
    wheelchair(Place, W).

% Asking clauses - these determine how we ask users for information
ask(A, V) :-
    known(yes, A, V), % succeed if true
    !. % stop looking

ask(A, V) :-
    known(_, A, V), % fail if false
    !, fail.

% If it is already known to be something else
ask(A, V) :-
    known(yes, A, V2),
    V \== V2,
    !, fail.

ask(A, V) :-
    askable(A, V),  % verify the value is valid
    read_py(A, V, Y),  % obtain the answer with python
    assertz(known(Y, A, V)),  % save it
    Y == yes. % succeed or fail
