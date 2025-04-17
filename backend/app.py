from flask import Flask
from flask_cors import CORS
import os
import sys
import traceback
from routes.api import api_bp

app = Flask(__name__)
CORS(app)

# Add detailed error logging
def print_exception_details():
    print("Unexpected error:", sys.exc_info()[0])
    print("Error details:")
    traceback.print_exc()

# Register blueprints
app.register_blueprint(api_bp, url_prefix='/api')

# Railway environment variables
port = int(os.environ.get("PORT", 5001))
host = os.environ.get("HOST", "0.0.0.0")

@app.route('/')
def health_check():
    return {"status": "healthy", "message": "SF Weekend Planner API is running"}

if __name__ == '__main__':
    try:
        app.run(host=host, port=port, debug=True)
    except Exception as e:
        print_exception_details()