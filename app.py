from google import genai
from google.genai import types
from flask import Flask, request, jsonify
from google.cloud import firestore
from dotenv import load_dotenv
import os
from datetime import datetime

load_dotenv()

FIRESTORE_PROJECT_NAME=os.getenv("FIRESTORE_PROJECT_NAME")
LOCATION=os.getenv("LOCATION")
MODEL_ID=os.getenv("VERTEX_MODEL_ID")
PROJECT_ID=os.getenv("VERTEX_PROJECT_ID")

project_id =FIRESTORE_PROJECT_NAME # firestore project id
db = firestore.Client(project=project_id) #senstive

app = Flask(__name__)
@app.route('/process-aac', methods=['POST'])

# Define function to process AAC request
def process_aac():
      try:
        #Get user selection from request
        print(f"Request: {request.json}")
        data=request.json
        if data is None:
            return jsonify({"error":"No data found"}),404
        card_1 = data.get('card_1', '')
        card_2 = data.get('card_2', '') 
        card_3 = data.get('card_3', '')
        card_4 = data.get('card_4', '')
        card_5 = data.get('card_5', '')

        #convert to sentence
        result_string = f"{card_1} {card_2} {card_3} {card_4} {card_5}"
        print(f"Result string: {result_string}")

        #AI Processing
        def generate():
            global ai_generated_text  # Ensure modification of the global variable

            client = genai.Client(
                vertexai=True,
                project=PROJECT_ID, #senstive
                location=LOCATION,#senstive
            )

            model = MODEL_ID 
            contents = [result_string]

            generate_content_config = types.GenerateContentConfig(
                temperature=1,
                top_p=0.95,
                max_output_tokens=8192,
                response_modalities=["TEXT"],
                safety_settings=[
                    types.SafetySetting(category="HARM_CATEGORY_HATE_SPEECH", threshold="OFF"),
                    types.SafetySetting(category="HARM_CATEGORY_DANGEROUS_CONTENT", threshold="OFF"),
                    types.SafetySetting(category="HARM_CATEGORY_SEXUALLY_EXPLICIT", threshold="OFF"),
                    types.SafetySetting(category="HARM_CATEGORY_HARASSMENT", threshold="OFF"),
                ],
            )

            ai_generated_text = ""  

            for chunk in client.models.generate_content_stream(
                model=model,
                contents=contents,
                config=generate_content_config,
            ):
                ai_generated_text += chunk.text  # Append generated text

            print(f"Generated Text: {ai_generated_text}")  # Debugging

            # Ensure Firestore is updated **after** AI text is generated
            doc_ref = db.collection("AAC_output").document()
            doc_ref.set({
                "generated_sentences": ai_generated_text,
                "timestamp": datetime.now(),
            }, merge=True)

            print(f"Saved data to Firestore")  # Debugging

        # Call function
        generate()

        return jsonify({
            "message": "Data successfully stores in Firestore",
            "ai_generated_text": ai_generated_text,
            }),200
      
      except Exception as e:
          return jsonify({"error":str(e)}),500

if __name__=="__main__":
    app.run(debug=True)

# Run the following command to start the server
# python app.py

# Test the server using the following command
# curl -X POST http://127.0.0.1:5000/process-aac ^
#      -H "Content-Type: application/json" ^
#      -d "{\"card_1\": \"Hello\", \"card_2\": \"I\", \"card_3\": \"Want\", \"card_4\": \"To\", \"card_5\": \"Talk\"}"
