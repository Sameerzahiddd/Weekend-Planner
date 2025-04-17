from flask import Blueprint, request, jsonify
from utils.prolog_engine import PrologEngine
import json
import os

api_bp = Blueprint('api', __name__)
prolog_engine = PrologEngine()

@api_bp.route('/recommendations', methods=['POST'])
def get_recommendations():
    try:
        # Get form data from request
        form_data = request.json
        
        if not form_data:
            return jsonify({"error": "No form data provided"}), 400

        # Process the form data using Prolog engine
        recommendations = prolog_engine.query_recommendations(form_data)
        
        return jsonify(recommendations), 200
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@api_bp.route('/places', methods=['GET'])
def get_places():
    try:
        # Get data from sf_places.json
        current_dir = os.path.dirname(os.path.abspath(__file__))
        data_path = os.path.join(os.path.dirname(current_dir), 'data', 'sf_places.json')
        
        with open(data_path, 'r') as f:
            places = json.load(f)
        
        return jsonify(places), 200
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500