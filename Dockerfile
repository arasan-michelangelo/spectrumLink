# Use an official lightweight Python image
FROM python:3.12

# Set the working directory inside the container
WORKDIR /interview

# Copy only requirements.txt first to leverage Docker caching
COPY requirements.txt .
COPY . /interview

# Set the environment variable for Google Cloud authentication
ENV GOOGLE_APPLICATION_CREDENTIALS="/interview/firebaseServiceAccountKey.json"


# Install dependencies
RUN pip install --upgrade pip==25.0.1
RUN pip install --no-cache-dir -r requirements.txt

# Now copy the rest of the application files
COPY . .

# Set environment variables 
ENV FIRESTORE_PROJECT_NAME=${FIRESTORE_PROJECT_NAME}
ENV LOCATION=${LOCATION}
ENV VERTEX_MODEL_ID=${VERTEX_MODEL_ID}
ENV VERTEX_PROJECT_ID=${VERTEX_PROJECT_ID}

# Expose the port Flask will run on
EXPOSE 5000

# Start the application
CMD ["python", "interview.py"]