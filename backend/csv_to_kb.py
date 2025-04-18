import csv
import re
import os
from pathlib import Path

def normalize_name(name):
    """Convert name to lowercase with underscores for Prolog compatibility"""
    return re.sub(r'[^a-zA-Z0-9]', '_', name.lower()).replace('__', '_').strip('_')

def normalize_value(value):
    """Normalize values for Prolog compatibility"""
    if value == 'Y':
        return 'yes'
    elif value == 'N':
        return 'no'
    elif value == '?':
        return 'unknown'
    elif value == 'x':
        return 'closed'
    elif value == '':
        return 'unknown'
    else:
        # Remove special characters for other values
        return re.sub(r'[^a-zA-Z0-9]', '_', value.lower()).replace('__', '_').strip('_')

def normalize_multiple_values(value_str):
    """Split comma-separated values and normalize each"""
    if ',' in value_str:
        return [normalize_value(v.strip()) for v in value_str.split(',')]
    return [normalize_value(value_str)]

def map_budget(budget):
    """Map budget values to simplified categories"""
    budget = budget.lower()
    if 'free' in budget:
        return 'free'
    elif 'low' in budget:
        return 'low'
    elif 'high' in budget:
        return 'high'
    else:
        return 'unknown'

def map_distance(distance):
    """Map distance values to simplified categories"""
    distance = distance.lower()
    if 'short' in distance:
        return 'short'
    elif 'medium' in distance:
        return 'medium'
    elif 'high' in distance:
        return 'high'
    else:
        return 'unknown'

def map_location_type(location_type):
    """Map location type to indoor/outdoor/both"""
    if ',' in location_type:
        return 'both'
    elif 'indoor' in location_type.lower():
        return 'indoor'
    elif 'outdoor' in location_type.lower():
        return 'outdoor'
    else:
        return 'unknown'

def csv_to_kb(csv_path, output_path):
    """Convert CSV to Prolog knowledge base"""
    places = []
    
    with open(csv_path, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            place = {
                'id': normalize_name(row['Name']),
                'name': row['Name'],
                'description': row['Description'],
                'address': row['Address'],
                'website': row['Website '],
                'location_type': map_location_type(row['Outdoor/Indoor']),
                'budget': map_budget(row['Budget per person \n\nFree\nLow ($1-$20)\nHigh ($20+)']),
                'vibe': normalize_multiple_values(row['What kind of vibe are you looking for?\n\nChill/ Sport / Study/ Social/ Romantic']),
                'distance': map_distance(row['Distance from residence\n\nshort (0-3 km)\nmedium (3 - 5 km)\nhigh (5+km)']),
                'food': normalize_value(row['Food available? (Y/N)']),
                'plugs': normalize_value(row['Plugs/outlets available? (Y/N)']),
                'wifi': normalize_value(row['Free Wifi available?']),
                'ambience': normalize_value(row['Do you want a Quiet or crowded place?']),
                'wheelchair': normalize_value(row['Wheelchair accessible?']),
            }
            places.append(place)
    
    # Generate Prolog KB
    with open(output_path, 'w', encoding='utf-8') as f:
        # Dynamic declarations
        f.write('% Dynamic declarations for known facts\n')
        f.write(':- dynamic known/3.\n\n')
        
        # Define askables
        f.write('% Define askables - these are the attributes we can ask the user about\n')
        askables = [
            'location_type(X)', 
            'budget(X)', 
            'vibe(X)',
            'distance(X)',
            'food(X)',
            'plugs(X)',
            'wifi(X)',
            'ambience(X)',
            'wheelchair(X)'
        ]
        
        for askable in askables:
            f.write(f'{askable} :- ask({askable.split("(")[0]}, X).\n')
        
        f.write('\n% Place facts - these define the properties of each place\n')
        
        # Generate place facts
        for place in places:
            f.write(f'% {place["name"]}\n')
            f.write(f'place({place["id"]}).\n')
            f.write(f'name({place["id"]}, "{place["name"]}").\n')
            f.write(f'description({place["id"]}, "{place["description"]}").\n')
            f.write(f'address({place["id"]}, "{place["address"]}").\n')
            f.write(f'website({place["id"]}, "{place["website"]}").\n')
            f.write(f'location_type({place["id"]}, {place["location_type"]}).\n')
            f.write(f'budget({place["id"]}, {place["budget"]}).\n')
            
            # Handle multiple vibes
            for vibe in place['vibe']:
                f.write(f'vibe({place["id"]}, {vibe}).\n')
                
            f.write(f'distance({place["id"]}, {place["distance"]}).\n')
            f.write(f'food({place["id"]}, {place["food"]}).\n')
            f.write(f'plugs({place["id"]}, {place["plugs"]}).\n')
            f.write(f'wifi({place["id"]}, {place["wifi"]}).\n')
            f.write(f'ambience({place["id"]}, {place["ambience"]}).\n')
            f.write(f'wheelchair({place["id"]}, {place["wheelchair"]}).\n\n')
        
        # Generate recommendation rules
        f.write('% Recommendation rules - these determine which places to recommend based on user preferences\n')
        f.write('recommendation(Place) :-\n')
        f.write('    place(Place),\n')
        f.write('    % Check location type\n')
        f.write('    (location_type(indoor) -> location_type(Place, indoor);\n')
        f.write('     location_type(outdoor) -> location_type(Place, outdoor);\n')
        f.write('     location_type(both) -> true;\n')
        f.write('     true),\n')
        f.write('    % Check budget\n')
        f.write('    (budget(free) -> budget(Place, free);\n')
        f.write('     budget(low) -> budget(Place, low);\n')
        f.write('     budget(high) -> budget(Place, high);\n')
        f.write('     true),\n')
        f.write('    % Check vibe - match any vibe the user is looking for\n')
        f.write('    (vibe(chill) -> vibe(Place, chill);\n')
        f.write('     vibe(social) -> vibe(Place, social);\n')
        f.write('     vibe(study) -> vibe(Place, study);\n')
        f.write('     vibe(sport) -> vibe(Place, sport);\n')
        f.write('     vibe(romantic) -> vibe(Place, romantic);\n')
        f.write('     true),\n')
        f.write('    % Check distance\n')
        f.write('    (distance(short) -> distance(Place, short);\n')
        f.write('     distance(medium) -> distance(Place, medium);\n')
        f.write('     distance(high) -> distance(Place, high);\n')
        f.write('     true),\n')
        f.write('    % Only check plugs and wifi for indoor locations\n')
        f.write('    (location_type(Place, outdoor) -> true;\n')
        f.write('     (plugs(yes) -> plugs(Place, yes); true),\n')
        f.write('     (wifi(yes) -> wifi(Place, yes); true)),\n')
        f.write('    % Check food availability\n')
        f.write('    (food(yes) -> food(Place, yes); true),\n')
        f.write('    % Check ambience\n')
        f.write('    (ambience(quiet) -> ambience(Place, quiet);\n')
        f.write('     ambience(crowded) -> ambience(Place, crowded);\n')
        f.write('     true),\n')
        f.write('    % Check wheelchair accessibility\n')
        f.write('    (wheelchair(yes) -> wheelchair(Place, yes); true).\n\n')
        
        # Add asking functionality
        f.write('% Asking clauses - these determine how we ask users for information\n')
        f.write('ask(A, V) :-\n')
        f.write('    known(yes, A, V), % succeed if true\n')
        f.write('    !. % stop looking\n\n')
        
        f.write('ask(A, V) :-\n')
        f.write('    known(_, A, V), % fail if false\n')
        f.write('    !, fail.\n\n')
        
        f.write('% If it is already known to be something else\n')
        f.write('ask(A, V) :-\n')
        f.write('    known(yes, A, V2),\n')
        f.write('    V \\== V2,\n')
        f.write('    !, fail.\n\n')
        
        f.write('ask(A, V) :-\n')
        f.write('    read_py(A, V, Y), % obtain the answer with python\n')
        f.write('    assertz(known(Y, A, V)), % save it\n')
        f.write('    Y == yes. % succeed or fail\n')

if __name__ == "__main__":
    # Create kb directory if it doesn't exist
    os.makedirs('kb', exist_ok=True)
    
    # Convert CSV to Prolog KB
    csv_to_kb('kb.csv', 'kb/sf_weekend_kb.pl')
    print("Knowledge base generated successfully!")