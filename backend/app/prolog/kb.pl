% Weekend Planner Knowledge Base for San Francisco

% Define the recommendation predicate
% recommendation(PlaceID, Name, Description, Address, Website, ImagePath, Attributes)

% Dolores Park
recommendation(1, 'Dolores Park', 'Sunny park with stunning city views, perfect for picnics and people-watching.', 
               'Dolores St & 19th St, San Francisco, CA 94114', 
               'https://sfrecpark.org/destination/mission-dolores-park/', 
               '/images/dolores-park.png',
               attributes(outdoor, free, [chill, social], medium, yes, no, no, crowded, yes)).

% Sightglass Coffee
recommendation(2, 'Sightglass Coffee', 'Artisanal coffee roaster with industrial-chic space, perfect for studying or meetings.', 
               '270 7th St, San Francisco, CA 94103', 
               'https://sightglasscoffee.com/', 
               '/images/sightglass.png',
               attributes(indoor, low, [chill, study], short, yes, yes, yes, quiet, yes)).

% Golden Gate Park
recommendation(3, 'Golden Gate Park', 'Vast urban park with gardens, museums, and recreational areas.', 
               'Golden Gate Park, San Francisco, CA', 
               'https://goldengatepark.com/', 
               '/images/golden-gate-park.png',
               attributes(outdoor, free, [chill, social, romantic], long, yes, no, no, crowded, yes)).

% SF MOMA
recommendation(4, 'San Francisco Museum of Modern Art', 'Contemporary art museum with an impressive collection and architecture.', 
               '151 3rd St, San Francisco, CA 94103', 
               'https://www.sfmoma.org/', 
               '/images/sfmoma.png',
               attributes(indoor, high, [chill, study], medium, yes, no, yes, quiet, yes)).

% Lands End
recommendation(5, 'Lands End', 'Rugged coastline with hiking trails and spectacular views of the Golden Gate Bridge.', 
               'Lands End, San Francisco, CA 94121', 
               'https://www.nps.gov/goga/planyourvisit/landsend.htm', 
               '/images/lands-end.png',
               attributes(outdoor, free, [chill, sport, romantic], long, no, no, no, quiet, no)).

% The Interval at Long Now
recommendation(6, 'The Interval at Long Now', 'Unique cafe and bar with a library, museum, and spectacular bay views.', 
               'Fort Mason Center, 2 Marina Blvd, San Francisco, CA 94123', 
               'https://theinterval.org/', 
               '/images/the-interval.png',
               attributes(indoor, medium, [chill, study, social], medium, yes, yes, yes, quiet, yes)).

% Alamo Square Park
recommendation(7, 'Alamo Square Park', 'Iconic park featuring the famous "Painted Ladies" Victorian houses.', 
               'Steiner St & Hayes St, San Francisco, CA 94117', 
               'https://www.nps.gov/places/alamo-square-historic-district.htm', 
               '/images/alamo-square.png',
               attributes(outdoor, free, [chill, social, romantic], medium, no, no, no, crowded, yes)).

% Exploratorium
recommendation(8, 'Exploratorium', 'Interactive science museum with hundreds of hands-on exhibits.', 
               'Pier 15, San Francisco, CA 94111', 
               'https://www.exploratorium.edu/', 
               '/images/exploratorium.png',
               attributes(indoor, high, [social, study], medium, yes, yes, yes, crowded, yes)).

% Twin Peaks
recommendation(9, 'Twin Peaks', 'Famous hills offering panoramic views of the city and bay.', 
               'Twin Peaks, San Francisco, CA 94114', 
               'https://sfrecpark.org/destination/twin-peaks/', 
               '/images/twin-peaks.png',
               attributes(outdoor, free, [chill, romantic], long, no, no, no, crowded, no)).

% Ritual Coffee Roasters
recommendation(10, 'Ritual Coffee Roasters', 'Hip coffee shop known for quality brews and laptop-friendly environment.', 
               '1026 Valencia St, San Francisco, CA 94110', 
               'https://ritualcoffee.com/', 
               '/images/ritual-coffee.png',
               attributes(indoor, low, [chill, study], short, yes, yes, yes, quiet, yes)).

% Ferry Building Marketplace
recommendation(11, 'Ferry Building Marketplace', 'Historic ferry terminal with gourmet food vendors and farmers market.', 
               '1 Ferry Building, San Francisco, CA 94111', 
               'https://www.ferrybuildingmarketplace.com/', 
               '/images/ferry-building.png',
               attributes(indoor, medium, [social, chill], medium, yes, no, yes, crowded, yes)).

% Baker Beach
recommendation(12, 'Baker Beach', 'Scenic beach with Golden Gate Bridge views, perfect for sunset watching.', 
               'Baker Beach, San Francisco, CA 94129', 
               'https://www.nps.gov/goga/planyourvisit/baker-beach.htm', 
               '/images/baker-beach.png',
               attributes(outdoor, free, [chill, romantic], long, no, no, no, quiet, no)).

% Attribute predicates
% These predicates help match user preferences to places

% Location type
location_type(indoor) :- recommendation(_, _, _, _, _, _, attributes(indoor, _, _, _, _, _, _, _, _)).
location_type(outdoor) :- recommendation(_, _, _, _, _, _, attributes(outdoor, _, _, _, _, _, _, _, _)).

% Budget
budget(free) :- recommendation(_, _, _, _, _, _, attributes(_, free, _, _, _, _, _, _, _)).
budget(low) :- recommendation(_, _, _, _, _, _, attributes(_, low, _, _, _, _, _, _, _)).
budget(medium) :- recommendation(_, _, _, _, _, _, attributes(_, medium, _, _, _, _, _, _, _)).
budget(high) :- recommendation(_, _, _, _, _, _, attributes(_, high, _, _, _, _, _, _, _)).

% Vibes
vibe(Vibe) :- recommendation(_, _, _, _, _, _, attributes(_, _, Vibes, _, _, _, _, _, _)), member(Vibe, Vibes).

% Distance
distance(short) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, short, _, _, _, _, _)).
distance(medium) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, medium, _, _, _, _, _)).
distance(long) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, long, _, _, _, _, _)).

% Food availability
food(yes) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, _, yes, _, _, _, _)).
food(no) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, _, no, _, _, _, _)).

% Plugs availability
plugs(yes) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, _, _, yes, _, _, _)).
plugs(no) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, _, _, no, _, _, _)).

% WiFi availability
wifi(yes) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, _, _, _, yes, _, _)).
wifi(no) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, _, _, _, no, _, _)).

% Ambience
ambience(quiet) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, _, _, _, _, quiet, _)).
ambience(crowded) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, _, _, _, _, crowded, _)).

% Wheelchair accessibility
wheelchair(yes) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, _, _, _, _, _, yes)).
wheelchair(no) :- recommendation(_, _, _, _, _, _, attributes(_, _, _, _, _, _, _, _, no)).

% Matching rules
% These rules help find places that match user preferences

% Match location type
matches_location_type(Place, Type) :- 
    recommendation(Place, _, _, _, _, _, attributes(Type, _, _, _, _, _, _, _, _)).

% Match budget
matches_budget(Place, Budget) :- 
    recommendation(Place, _, _, _, _, _, attributes(_, Budget, _, _, _, _, _, _, _)).

% Match at least one vibe
matches_vibe(Place, Vibes) :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, PlaceVibes, _, _, _, _, _, _)),
    member(Vibe, Vibes),
    member(Vibe, PlaceVibes).

% Match distance
matches_distance(Place, Distance) :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, _, Distance, _, _, _, _, _)).

% Match food availability
matches_food(Place, "yes") :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, _, _, yes, _, _, _, _)).
matches_food(Place, "no") :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, _, _, no, _, _, _, _)).

% Match plugs availability
matches_plugs(Place, "yes") :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, _, _, _, yes, _, _, _)).
matches_plugs(Place, "no") :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, _, _, _, no, _, _, _)).

% Match WiFi availability
matches_wifi(Place, "yes") :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, _, _, _, _, yes, _, _)).
matches_wifi(Place, "no") :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, _, _, _, _, no, _, _)).

% Match ambience
matches_ambience(Place, Ambience) :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, _, _, _, _, _, Ambience, _)).

% Match wheelchair accessibility
matches_wheelchair(Place, "yes") :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, _, _, _, _, _, _, yes)).
matches_wheelchair(Place, "no") :- 
    recommendation(Place, _, _, _, _, _, attributes(_, _, _, _, _, _, _, _, no)).

% Main recommendation rule
% This rule finds places that match all specified criteria
recommend(Place, Name, Desc, Addr, Web, Img, Attrs) :-
    recommendation(Place, Name, Desc, Addr, Web, Img, Attrs),
    (var(Type) -> true ; matches_location_type(Place, Type)),
    (var(Budget) -> true ; matches_budget(Place, Budget)),
    (var(Vibes) -> true ; matches_vibe(Place, Vibes)),
    (var(Distance) -> true ; matches_distance(Place, Distance)),
    (var(Food) -> true ; matches_food(Place, Food)),
    (var(Plugs) -> true ; matches_plugs(Place, Plugs)),
    (var(Wifi) -> true ; matches_wifi(Place, Wifi)),
    (var(Ambience) -> true ; matches_ambience(Place, Ambience)),
    (var(Wheelchair) -> true ; matches_wheelchair(Place, Wheelchair)).