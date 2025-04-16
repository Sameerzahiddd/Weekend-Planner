from fastapi import APIRouter

from app.api.endpoints import recommendations

router = APIRouter()

router.include_router(recommendations.router, prefix="/recommendations", tags=["recommendations"])