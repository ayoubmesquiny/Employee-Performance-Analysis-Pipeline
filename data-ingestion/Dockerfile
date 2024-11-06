# Use the official Python image from Docker Hub
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt ./  

# Install dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy only the necessary data-ingestion folder content
COPY . .

COPY config/.env /app/config/.env

# Add PYTHONPATH so Python can find the modules
ENV PYTHONPATH=/app

# Set the default command to run the load script
CMD ["python", "load/load_data.py"]
