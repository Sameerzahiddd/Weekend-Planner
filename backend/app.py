from flask import Flask
from flask_cors import CORS
import os
from routes.api import api_bp

app = Flask(__name__)
CORS(app)

# Register blueprints
app.register_blueprint(api_bp, url_prefix='/api')

# Railway environment variables
port = int(os.environ.get("PORT", 5000))
host = os.environ.get("HOST", "0.0.0.0")

@app.route('/')
def health_check():
    return {"status": "healthy", "message": "SF Weekend Planner API is running"}

if __name__ == '__main__':
    app.run(host=host, port=port)