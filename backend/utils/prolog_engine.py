from pyswip import Prolog, Variable, Functor, registerForeign
import os
import json

class PrologEngine:
    def __init__(self):
        self.prolog = Prolog()
        self.user_answers = {}
        try:
            self.registerFunctions()
            self.load_knowledge_base("knowledge_base.pl")  # Use the real KB
        except Exception as e:
            print(f"Error initializing Prolog engine: {str(e)}")
    
    def load_knowledge_base(self, filename="knowledge_base.pl"):
        try:
            current_dir = os.path.dirname(os.path.abspath(__file__))
            kb_path = os.path.join(os.path.dirname(current_dir), filename)
            if not os.path.exists(kb_path):
                raise FileNotFoundError(f"Knowledge base file not found at {kb_path}")
            
            print(f"Loading knowledge base from: {kb_path}")
            self.prolog.consult(kb_path)
            
            # Clear known facts
            try:
                list(self.prolog.query("retractall(known(_,_,_))"))
            except Exception as e:
                print(f"Warning: Could not clear known facts: {e}")
            
            return True
        except FileNotFoundError as e:
            print(f"Knowledge base error: {e}")
            return False
        except Exception as e:
            print(f"Error loading knowledge base: {str(e)}")
            return False
    
    def registerFunctions(self):
        # Register the callback function for Prolog to use
        registerForeign(self.read_py, arity=3)
    
    def read_py(self, a, v, y):
        """Callback function for Prolog to get answers from Python"""
        attribute = str(a)
        value = str(v)
        
        # Get the stored answer for this attribute
        stored_answer = self.user_answers.get(attribute)
        
        # Handle no_preference by returning "yes" for all values
        if stored_answer == "no_preference":
            response = "yes"
        # Otherwise, compare the user's answer with the value
        elif stored_answer and stored_answer.lower() == value.lower():
            response = "yes"
        else:
            response = "no"
        
        # Unify with the Y variable in Prolog
        if isinstance(y, Variable):
            y.unify(str(response))
            return True
        return False
    
    def map_form_data_to_prolog(self, form_data):
        """Map frontend form data to Prolog format"""
        # Reset user answers for each query
        self.user_answers = {}
        
        # Location type mapping
        if form_data.get("locationType") == "indoor":
            self.user_answers["location_type"] = "indoor"
        elif form_data.get("locationType") == "outdoor":
            self.user_answers["location_type"] = "outdoor"
        elif form_data.get("locationType") == "no-preference":
            self.user_answers["location_type"] = "no_preference"
        
        # Budget mapping
        if form_data.get("budget") == "free":
            self.user_answers["payment_preference"] = "free"
        elif form_data.get("budget") == "low" or form_data.get("budget") == "high":
            self.user_answers["payment_preference"] = "paid"
        elif form_data.get("budget") == "no-preference":
            self.user_answers["payment_preference"] = "no_preference"
        
        # Map vibe (can have multiple values)
        if "no-preference" in form_data.get("vibe", []):
            self.user_answers["vibe_chill"] = "no_preference"
            self.user_answers["vibe_social"] = "no_preference"
            self.user_answers["vibe_study"] = "no_preference"
            self.user_answers["vibe_romantic"] = "no_preference"
            self.user_answers["vibe_sport"] = "no_preference"
        else:
            self.user_answers["vibe_chill"] = "yes" if "chill" in form_data.get("vibe", []) else "no"
            self.user_answers["vibe_social"] = "yes" if "social" in form_data.get("vibe", []) else "no"
            self.user_answers["vibe_study"] = "yes" if "study" in form_data.get("vibe", []) else "no"
            self.user_answers["vibe_romantic"] = "yes" if "romantic" in form_data.get("vibe", []) else "no"
            self.user_answers["vibe_sport"] = "yes" if "sport" in form_data.get("vibe", []) else "no"
        
        # Map distance
        if form_data.get("distance") == "short":
            self.user_answers["walking_distance"] = "yes"
        elif form_data.get("distance") == "medium":
            self.user_answers["walking_distance"] = "no"
            self.user_answers["travel_distance"] = "less_than_5km"
        elif form_data.get("distance") == "high":
            self.user_answers["walking_distance"] = "no"
            self.user_answers["travel_distance"] = "more_than_5km"
        elif form_data.get("distance") == "no-preference":
            self.user_answers["walking_distance"] = "no_preference"
            self.user_answers["travel_distance"] = "no_preference"
        
        # Map food, plugs, wifi
        self.user_answers["food_available"] = "yes" if form_data.get("food") is True else "no" if form_data.get("food") is False else "no_preference"
        self.user_answers["plug_needed"] = "yes" if form_data.get("plugs") is True else "no" if form_data.get("plugs") is False else "no_preference"
        self.user_answers["wifi_needed"] = "yes" if form_data.get("wifi") is True else "no" if form_data.get("wifi") is False else "no_preference"
        
        # Map ambience
        if form_data.get("ambience") == "quiet":
            self.user_answers["ambience"] = "quiet"
        elif form_data.get("ambience") == "crowded":
            self.user_answers["ambience"] = "crowded"
        elif form_data.get("ambience") == "no-preference":
            self.user_answers["ambience"] = "no_preference"
        
        # Map wheelchair accessibility
        self.user_answers["wheelchair_accessible"] = "yes" if form_data.get("wheelchairAccessible") is True else "no" if form_data.get("wheelchairAccessible") is False else "no_preference"
    
    def query_recommendations(self, form_data):
        """Get recommendations based on form data"""
        try:
            if not form_data:
                raise ValueError("Form data is empty or invalid")

            # Map the form data to Prolog format
            self.map_form_data_to_prolog(form_data)
            
            # Query Prolog for recommendations
            recommendations = []
            try:
                for result in self.prolog.query("recommendation(X)"):
                    recommendation_name = result["X"]
                    recommendations.append(recommendation_name)
            except Exception as e:
                print(f"Prolog query error: {str(e)}")
                raise
            
            # Get the full data for each recommendation from sf_places.json
            current_dir = os.path.dirname(os.path.abspath(__file__))
            data_path = os.path.join(os.path.dirname(current_dir), 'data', 'sf_places.json')
            
            if not os.path.exists(data_path):
                raise FileNotFoundError(f"Places data file not found at {data_path}")
            
            with open(data_path, 'r') as f:
                places = json.load(f)
            
            # Filter places based on recommendations
            result = [place for place in places if place["id"] in recommendations]
            
            if not result:
                print("No recommendations found matching the criteria")
            
            return result
        
        except ValueError as e:
            print(f"Validation error: {str(e)}")
            return []
        except FileNotFoundError as e:
            print(f"Data file error: {str(e)}")
            return []
        except Exception as e:
            print(f"Error querying recommendations: {str(e)}")
            return []