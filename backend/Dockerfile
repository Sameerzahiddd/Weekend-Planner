FROM python:3.11-slim

# Install SWI-Prolog
RUN apt-get update && apt-get install -y swi-prolog

WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Command to run the application
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:$PORT"]