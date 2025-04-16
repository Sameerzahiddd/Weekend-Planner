from fastapi import APIRouter, HTTPException, Depends
from loguru import logger
from typing import List

from app.models.recommendation import RecommendationRequest, Recommendation
from app.core.prolog_engine import PrologEngine
from app.utils.error_handling import handle_exception, PrologError

router = APIRouter()

@router.post("/", response_model=List[Recommendation])
async def get_recommendations(request: RecommendationRequest):
    """
    Get recommendations based on user preferences.
    """
    try:
        logger.info(f"Received recommendation request: {request}")
        
        # Initialize the Prolog engine
        prolog_engine = PrologEngine()
        
        # Get recommendations from the Prolog engine
        recommendations = prolog_engine.get_recommendations(request)
        
        logger.info(f"Returning {len(recommendations)} recommendations")
        return recommendations
    except Exception as e:
        raise handle_exception(e)