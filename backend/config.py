import os

class Config:
    """Base configuration"""
    DEBUG = False
    TESTING = False
    KB_PATH = os.path.join(os.path.dirname(__file__), 'kb', 'sf_weekend_kb.pl')

class DevelopmentConfig(Config):
    """Development configuration"""
    DEBUG = True

class TestingConfig(Config):
    """Testing configuration"""
    TESTING = True

class ProductionConfig(Config):
    """Production configuration"""
    pass

# Map config based on environment
config_by_name = {
    'development': DevelopmentConfig,
    'testing': TestingConfig,
    'production': ProductionConfig
}

# Default to development config
config = config_by_name.get(os.environ.get('FLASK_ENV', 'development'))