from pyswip import Prolog, Variable, Functor, registerForeign, Atom
import os
import json

class PrologEngine:
    def __init__(self):
        self.prolog = Prolog()
        self.load_knowledge_base()
        self.user_answers = {}
        self.registerFunctions()
        
    def load_knowledge_base(self, filename="knowledge_base.pl"):
        try:
            current_dir = os.path.dirname(os.path.abspath(__file__))
            kb_path = os.path.join(os.path.dirname(current_dir), filename)
            if not os.path.exists(kb_path):
                raise FileNotFoundError(f"Knowledge base file not found at {kb_path}")
            self.prolog.consult(kb_path)
            # Clear known facts
            list(self.prolog.query("retractall(known(_,_,_))"))
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
        
        # Compare the user's answer with the value
        if stored_answer and stored_answer.lower() == value.lower():
            response = "yes"
        else:
            response = "no"
        
        # Unify with the Y variable in Prolog
        if isinstance(y, Variable):
            y.unify(Atom(response))
            return True
        return False
    
    def map_form_data_to_prolog(self, form_data):
        """Map frontend form data to Prolog format"""
        # Reset user answers for each query
        self.user_answers = {}
        
        # Map location type
        if form_data.get("locationType") == "indoor":
            self.user_answers["location_type"] = "indoor"
        elif form_data.get("locationType") == "outdoor":
            self.user_answers["location_type"] = "outdoor"
        
        # Map budget
        if form_data.get("budget") == "free":
            self.user_answers["payment_preference"] = "free"
        elif form_data.get("budget") == "low" or form_data.get("budget") == "high":
            self.user_answers["payment_preference"] = "paid"
        
        # Map vibe (can have multiple values)
        if "chill" in form_data.get("vibe", []):
            self.user_answers["vibe_chill"] = "yes"
        else:
            self.user_answers["vibe_chill"] = "no"
            
        if "social" in form_data.get("vibe", []):
            self.user_answers["vibe_social"] = "yes"
        else:
            self.user_answers["vibe_social"] = "no"
            
        if "study" in form_data.get("vibe", []):
            self.user_answers["vibe_study"] = "yes"
        else:
            self.user_answers["vibe_study"] = "no"
            
        if "romantic" in form_data.get("vibe", []):
            self.user_answers["vibe_romantic"] = "yes"
        else:
            self.user_answers["vibe_romantic"] = "no"
            
        if "sport" in form_data.get("vibe", []):
            self.user_answers["vibe_sport"] = "yes"
        else:
            self.user_answers["vibe_sport"] = "no"
        
        # Map distance
        if form_data.get("distance") == "short":
            self.user_answers["walking_distance"] = "yes"
        elif form_data.get("distance") == "medium":
            self.user_answers["walking_distance"] = "no"
            self.user_answers["travel_distance"] = "less_than_5km"
        elif form_data.get("distance") == "high":
            self.user_answers["walking_distance"] = "no"
            self.user_answers["travel_distance"] = "more_than_5km"
        
        # Map food, plugs, wifi
        self.user_answers["food_available"] = "yes" if form_data.get("food") else "no"
        self.user_answers["plug_needed"] = "yes" if form_data.get("plugs") else "no"
        self.user_answers["wifi_needed"] = "yes" if form_data.get("wifi") else "no"
        
        # Map ambience
        if form_data.get("ambience") == "quiet":
            self.user_answers["ambience"] = "quiet"
        elif form_data.get("ambience") == "crowded":
            self.user_answers["ambience"] = "crowded"
        
        # Map wheelchair accessibility
        self.user_answers["wheelchair_accessible"] = "yes" if form_data.get("wheelchairAccessible") else "no"
    
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
            
            # Get the full data for each recommendation
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