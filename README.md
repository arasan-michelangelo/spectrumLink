# AI-AAC
PYthon Backend file (with Vertex AI) for AI-AAC features.

# Donwload the following packages:

pip install python-dotenv --user     
pip install Flask --user

# Install and login the firebase with the specific account and project name

# Create a .env file and assign the following value:

FIRESTORE_PROJECT_NAME=    
LOCATION=  
VERTEX_MODEL_ID=      
VERTEX_PROJECT_ID=

# Type the following at the terminal to run:
python app.py

# Tips:
To test if the backend file is working, run the app.py and copy and paste the following command and at command prompt

 curl -X POST http://127.0.0.1:5000/process-aac ^
      -H "Content-Type: application/json" ^
      -d "{\"card_1\": \"Hello\", \"card_2\": \"I\", \"card_3\": \"Want\", \"card_4\": \"To\", \"card_5\": \"Talk\"}"
