from flask import Blueprint, request, jsonify
from .expert_system import ExpertSystem
import os

# Initialize Blueprint
api = Blueprint('api', __name__)

# Initialize Expert System
kb_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'kb', 'sf_weekend_kb.pl')
expert_system = ExpertSystem(kb_path)

@api.route('/recommendations', methods=['POST'])
def get_recommendations():
    """Get recommendations based on user preferences"""
    if not request.is_json:
        return jsonify({"error": "Request must be JSON"}), 400
    
    # Get user preferences from request
    preferences = request.get_json()
    
    # Get recommendations
    recommendations = expert_system.get_recommendations(preferences)
    
    return jsonify(recommendations)

@api.route('/places', methods=['GET'])
def get_places():
    """Get all places"""
    places = list(expert_system.references.values())
    return jsonify(places)

@api.route('/prolog-query', methods=['POST'])
def prolog_query():
    """Interface for step-by-step querying of Prolog KB
    This is used for dynamic question filtering based on previous answers"""
    if not request.is_json:
        return jsonify({"error": "Request must be JSON"}), 400
    
    data = request.get_json()
    
    # Get current preferences and new preference
    current_preferences = data.get('currentPreferences', {})
    new_preference = data.get('newPreference', {})
    
    # Combine preferences
    combined_preferences = {**current_preferences, **new_preference}
    
    # Temporary - in the future, this could query Prolog for next question
    # based on the current state
    suggestions = {
        "nextQuestion": None,
        "skipQuestions": [],
        "potentialRecommendations": len(expert_system.get_recommendations(combined_preferences))
    }
    
    # Determine which questions to ask next based on previous answers
    # This is where Prolog's intelligence comes in
    
    # Skip plug and wifi questions for outdoor locations
    if combined_preferences.get('locationType') == 'outdoor':
        suggestions["skipQuestions"].extend(["plugs", "wifi"])
    
    # Skip meal type question if food is not available
    if combined_preferences.get('food') is False:
        suggestions["skipQuestions"].append("mealType")
    
    # Skip travel_distance if walking_distance is yes
    if combined_preferences.get('distance') == 'short':
        suggestions["skipQuestions"].append("travelDistance")
    
    return jsonify(suggestions)