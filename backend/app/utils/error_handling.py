from fastapi import HTTPException
from loguru import logger
from typing import Type, Optional

class AppError(Exception):
    """Base error class for application errors."""
    status_code: int = 500
    detail: str = "An unexpected error occurred"
    
    def __init__(self, detail: Optional[str] = None):
        self.detail = detail or self.detail
        super().__init__(self.detail)

class NotFoundError(AppError):
    status_code = 404
    detail = "Resource not found"

class ValidationError(AppError):
    status_code = 422
    detail = "Validation error"

class PrologError(AppError):
    status_code = 500
    detail = "Error in Prolog processing"

def handle_exception(e: Exception) -> HTTPException:
    """Convert application exceptions to HTTPExceptions."""
    if isinstance(e, AppError):
        logger.error(f"{type(e).__name__}: {str(e)}")
        return HTTPException(status_code=e.status_code, detail=e.detail)
    
    # For unexpected errors
    logger.error(f"Unexpected error: {str(e)}")
    return HTTPException(status_code=500, detail=f"An unexpected error occurred: {str(e)}")