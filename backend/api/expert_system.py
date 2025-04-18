from pyswip import Prolog, Variable, Functor, registerForeign
from pyswip.easy import *
import re
import os

class ExpertSystem:
    def __init__(self, kb_path):
        self.prolog = Prolog()
        self.kb_path = kb_path
        self.references = {}
        self._load_references()
        
    def _load_references(self):
        """Load place details from Prolog KB for reference"""
        try:
            self.prolog.consult(self.kb_path)
            
            # Query all places and their details
            for place in self.prolog.query("place(ID)"):
                place_id = place["ID"]
                self.references[place_id] = {"id": place_id}
                
                # Get name
                for result in self.prolog.query(f"name({place_id}, Name)"):
                    self.references[place_id]["name"] = result["Name"]
            
            # Get description
            for result in self.prolog.query(f"description({place_id}, Desc)"):
                self.references[place_id]["description"] = result["Desc"]
            
            # Get address
            for result in self.prolog.query(f"address({place_id}, Addr)"):
                self.references[place_id]["address"] = result["Addr"]
            
            # Get website
            for result in self.prolog.query(f"website({place_id}, Web)"):
                self.references[place_id]["website"] = result["Web"]
            
            # Get location type
            for result in self.prolog.query(f"location_type({place_id}, Type)"):
                self.references[place_id]["locationType"] = result["Type"]
            
            # Get budget
            for result in self.prolog.query(f"budget({place_id}, Budget)"):
                self.references[place_id]["budget"] = result["Budget"]
            
            # Get vibes (multiple possible)
            vibes = []
            for result in self.prolog.query(f"vibe({place_id}, Vibe)"):
                vibes.append(result["Vibe"])
            self.references[place_id]["vibe"] = vibes
            
            # Get distance
            for result in self.prolog.query(f"distance({place_id}, Dist)"):
                self.references[place_id]["distance"] = result["Dist"]
            
            # Get food - convert string "yes"/"no" to boolean
            for result in self.prolog.query(f"food({place_id}, Food)"):
                self.references[place_id]["food"] = (result["Food"] == "yes")
            
            # Get plugs - convert string "yes"/"no" to boolean
            for result in self.prolog.query(f"plugs({place_id}, Plugs)"):
                self.references[place_id]["plugs"] = (result["Plugs"] == "yes")
            
            # Get wifi - convert string "yes"/"no" to boolean
            for result in self.prolog.query(f"wifi({place_id}, Wifi)"):
                self.references[place_id]["wifi"] = (result["Wifi"] == "yes")
            
            # Get ambience
            for result in self.prolog.query(f"ambience({place_id}, Amb)"):
                self.references[place_id]["ambience"] = result["Amb"]
            
            # Get wheelchair - convert string "yes"/"no" to boolean
            for result in self.prolog.query(f"wheelchair({place_id}, Wheel)"):
                self.references[place_id]["wheelchairAccessible"] = (result["Wheel"] == "yes")
            
            # Add image placeholders for frontend
                self.references[place_id]["image"] = "/placeholder.svg"
                
        except Exception as e:
            print(f"Error loading references: {e}")

    def assert_preference(self, attribute, value):
        """Assert a user preference in Prolog"""
        if value is None:
            # If value is None (no preference), do nothing
            return
        
        # Handle special cases for different attributes
        if attribute == "locationType":
            self.prolog.assertz(f"known(yes, location_type, {value})")
            
        elif attribute == "budget":
            self.prolog.assertz(f"known(yes, budget, {value})")
            
        elif attribute == "vibe":
            # Handle vibe array - assert each vibe
            for v in value:
                self.prolog.assertz(f"known(yes, vibe, {v})")
                
        elif attribute == "distance":
            self.prolog.assertz(f"known(yes, distance, {value})")
            
        elif attribute == "food":
            # Convert boolean to yes/no
            val = "yes" if value else "no"
            self.prolog.assertz(f"known(yes, food, {val})")
            
        elif attribute == "plugs":
            # Convert boolean to yes/no
            val = "yes" if value else "no"
            self.prolog.assertz(f"known(yes, plugs, {val})")
            
        elif attribute == "wifi":
            # Convert boolean to yes/no
            val = "yes" if value else "no"
            self.prolog.assertz(f"known(yes, wifi, {val})")
            
        elif attribute == "ambience":
            self.prolog.assertz(f"known(yes, ambience, {value})")
            
        elif attribute == "wheelchairAccessible":
            # Convert boolean to yes/no
            val = "yes" if value else "no"
            self.prolog.assertz(f"known(yes, wheelchair, {val})")
    
    def get_recommendations(self, preferences):
        """Get recommendations based on user preferences"""
        # Reset Prolog and load KB
        self.prolog.consult(self.kb_path)
        
        # Assert user preferences
        for attr, value in preferences.items():
            self.assert_preference(attr, value)
        
        # Get recommendations
        recommendations = []
        for result in self.prolog.query("recommendation(X)"):
            place_id = result["X"]
            # Add the place to recommendations if it exists in our references
            if place_id in self.references:
                # Format the recommendation according to frontend expectations
                from .models import Recommendation
                rec = Recommendation(self.references[place_id])
                recommendations.append(rec.to_dict())
        
        return recommendations