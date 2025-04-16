from pyswip import Prolog
from loguru import logger
from typing import List, Dict, Any
import os

from app.models.recommendation import RecommendationRequest, Recommendation, RecommendationAttributes
from app.core.config import settings

class PrologEngine:
    """
    Engine for interacting with the Prolog knowledge base.
    """
    def __init__(self):
        self.prolog = Prolog()
        self._load_knowledge_base()
        
    def _load_knowledge_base(self):
        """
        Load the Prolog knowledge base.
        """
        try:
            kb_path = settings.PROLOG_KB_PATH
            logger.info(f"Loading knowledge base from {kb_path}")
            self.prolog.consult(kb_path)
            logger.info("Knowledge base loaded successfully")
        except Exception as e:
            logger.error(f"Error loading knowledge base: {str(e)}")
            # In the error handling sections
            from app.utils.error_handling import PrologError
            
            # Then replace:
            # raise RuntimeError(f"Error loading knowledge base: {str(e)}")
            # with:
            raise PrologError(f"Error loading knowledge base: {str(e)}")
            
            # And similarly for other error cases
    
    def get_recommendations(self, request: RecommendationRequest) -> List[Recommendation]:
        """
        Get recommendations based on user preferences.
        """
        try:
            # Convert request to Prolog query parameters
            query_params = self._build_query_params(request)
            
            # Build and execute the Prolog query
            query_results = self._execute_query(query_params)
            
            # Convert Prolog results to Recommendation objects
            recommendations = self._process_results(query_results)
            
            return recommendations
        except Exception as e:
            logger.error(f"Error getting recommendations: {str(e)}")
            raise RuntimeError(f"Error getting recommendations: {str(e)}")
    
    def _build_query_params(self, request: RecommendationRequest) -> Dict[str, Any]:
        """
        Build query parameters from the request.
        """
        params = {}
        
        # Convert request fields to Prolog-friendly format
        if request.locationType:
            params["location_type"] = request.locationType
        
        if request.budget:
            params["budget"] = request.budget
        
        if request.vibe:
            params["vibes"] = request.vibe
        
        if request.distance:
            params["distance"] = request.distance
        
        if request.food is not None:
            params["food"] = "yes" if request.food else "no"
        
        if request.plugs is not None:
            params["plugs"] = "yes" if request.plugs else "no"
        
        if request.wifi is not None:
            params["wifi"] = "yes" if request.wifi else "no"
        
        if request.ambience:
            params["ambience"] = request.ambience
        
        if request.wheelchairAccessible is not None:
            params["wheelchair"] = "yes" if request.wheelchairAccessible else "no"
        
        return params
    
    def _execute_query(self, params: Dict[str, Any]) -> List[Dict[str, Any]]:
        """
        Execute a Prolog query with the given parameters.
        """
        # Build the Prolog query string
        query_parts = []
        for key, value in params.items():
            if isinstance(value, list):
                # Handle lists (e.g., vibes)
                list_str = "[" + ",".join([f"'{v}'" for v in value]) + "]"
                query_parts.append(f"{key}({list_str})")
            else:
                query_parts.append(f"{key}('{value}')")
        
        query_str = f"recommendation(Place, Name, Desc, Addr, Web, Img, Attrs), " + ", ".join(query_parts)
        logger.debug(f"Executing Prolog query: {query_str}")
        
        # Execute the query
        results = list(self.prolog.query(query_str))
        logger.debug(f"Query returned {len(results)} results")
        
        return results
    
    def _process_results(self, results: List[Dict[str, Any]]) -> List[Recommendation]:
        """
        Process Prolog query results into Recommendation objects.
        """
        recommendations = []
        
        for i, result in enumerate(results):
            # Extract place attributes from the Prolog result
            place_id = i + 1
            name = str(result["Name"])
            description = str(result["Desc"])
            address = str(result["Addr"])
            website = str(result["Web"])
            image = str(result["Img"])
            attrs = result["Attrs"]
            
            # Convert Prolog attributes to Python
            attributes = self._extract_attributes(attrs)
            
            # Create a Recommendation object
            recommendation = Recommendation(
                id=place_id,
                name=name,
                description=description,
                address=address,
                website=website,
                image=image,
                attributes=attributes
            )
            
            recommendations.append(recommendation)
        
        return recommendations
    
    def _extract_attributes(self, attrs_term) -> RecommendationAttributes:
        """
        Extract attributes from a Prolog term.
        """
        # Extract attributes from the Prolog term structure
        # The term is in the format: attributes(locationType, budget, vibes, distance, food, plugs, wifi, ambience, wheelchair)
        
        # Convert Prolog atoms to Python types
        location_type = str(attrs_term.args[0])
        budget = str(attrs_term.args[1])
        
        # Convert Prolog list to Python list
        vibes_list = attrs_term.args[2]
        vibes = [str(vibe) for vibe in vibes_list]
        
        distance = str(attrs_term.args[3])
        
        # Convert Prolog yes/no to Python boolean
        food = str(attrs_term.args[4]) == "yes"
        plugs = str(attrs_term.args[5]) == "yes"
        wifi = str(attrs_term.args[6]) == "yes"
        
        ambience = str(attrs_term.args[7])
        wheelchair_accessible = str(attrs_term.args[8]) == "yes"
        
        return RecommendationAttributes(
            locationType=location_type,
            budget=budget,
            vibe=vibes,
            distance=distance,
            food=food,
            plugs=plugs,
            wifi=wifi,
            ambience=ambience,
            wheelchairAccessible=wheelchair_accessible
        )