# Use a maintained Debian version
FROM python:3.10-slim-bullseye  

# Set working directory early
WORKDIR /VJ-Forward-Bot  

# Install system dependencies (git, etc.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
 && rm -rf /var/lib/apt/lists/*  

# Upgrade pip & install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt  

# Copy the rest of the code
COPY . .  

# Expose port if using gunicorn (e.g. 8000)
EXPOSE 8000  

# Run gunicorn + main.py
CMD ["sh", "-c", "gunicorn app:app --bind 0.0.0.0:8000 & python3 main.py"]
