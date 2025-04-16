from pydantic import BaseModel
from typing import List
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

class Settings(BaseModel):
    API_PREFIX: str = "/api"
    DEBUG: bool = os.getenv("DEBUG", "False").lower() == "true"
    PROJECT_NAME: str = "Weekend Planner Expert System"
    
    # CORS settings
    CORS_ORIGINS: List[str] = [
        "http://localhost:3000",  # Local development frontend
        "https://weekend-planner-frontend.vercel.app",  # Production frontend
        os.getenv("FRONTEND_URL", ""),  # Dynamic frontend URL from env
    ]
    
    # Filter empty strings
    CORS_ORIGINS = [origin for origin in CORS_ORIGINS if origin]
    
    # Add any other settings here
    PROLOG_KB_PATH: str = os.path.join(os.path.dirname(os.path.dirname(__file__)), "prolog", "kb.pl")

settings = Settings()