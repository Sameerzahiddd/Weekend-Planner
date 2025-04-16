from pydantic import BaseModel, Field
from typing import List, Optional, Dict, Any

class RecommendationRequest(BaseModel):
    """
    Model for recommendation request from the frontend.
    """
    locationType: Optional[str] = Field(None, description="Indoor or outdoor location")
    budget: Optional[str] = Field(None, description="Budget level (free, low, high)")
    vibe: List[str] = Field(default_factory=list, description="Vibes (chill, sport, study, social, romantic)")
    distance: Optional[str] = Field(None, description="Distance from residence (short, medium, high)")
    food: Optional[bool] = Field(None, description="Food availability")
    plugs: Optional[bool] = Field(None, description="Plugs/outlets availability")
    wifi: Optional[bool] = Field(None, description="WiFi availability")
    ambience: Optional[str] = Field(None, description="Ambience (quiet, crowded)")
    wheelchairAccessible: Optional[bool] = Field(None, description="Wheelchair accessibility")

class RecommendationAttributes(BaseModel):
    """
    Model for recommendation attributes.
    """
    locationType: str
    budget: str
    vibe: List[str]
    distance: str
    food: bool
    plugs: bool
    wifi: bool
    ambience: str
    wheelchairAccessible: bool

class Recommendation(BaseModel):
    """
    Model for recommendation response.
    """
    id: int
    name: str
    description: str
    address: str
    website: str
    image: str
    attributes: RecommendationAttributes