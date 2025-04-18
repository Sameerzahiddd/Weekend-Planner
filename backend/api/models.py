# Define the data structure for recommendation attributes
class PlaceAttributes:
    def __init__(self, place_data):
        self.locationType = place_data.get('locationType', '')
        self.budget = place_data.get('budget', '')
        self.vibe = place_data.get('vibe', [])
        self.distance = place_data.get('distance', '')
        self.food = place_data.get('food', False)
        self.plugs = place_data.get('plugs', False)
        self.wifi = place_data.get('wifi', False)
        self.ambience = place_data.get('ambience', '')
        self.wheelchairAccessible = place_data.get('wheelchairAccessible', False)
    
    def to_dict(self):
        return {
            'locationType': self.locationType,
            'budget': self.budget,
            'vibe': self.vibe,
            'distance': self.distance,
            'food': self.food,
            'plugs': self.plugs,
            'wifi': self.wifi,
            'ambience': self.ambience,
            'wheelchairAccessible': self.wheelchairAccessible
        }

# Define the data structure for a recommendation
class Recommendation:
    def __init__(self, place_data):
        self.id = place_data.get('id', '')
        self.name = place_data.get('name', '')
        self.description = place_data.get('description', '')
        self.address = place_data.get('address', '')
        self.website = place_data.get('website', '')
        self.image = place_data.get('image', '/placeholder.svg')
        self.attributes = PlaceAttributes(place_data).to_dict()
    
    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'description': self.description,
            'address': self.address,
            'website': self.website,
            'image': self.image,
            'attributes': self.attributes
        }