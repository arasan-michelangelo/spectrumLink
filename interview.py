from google import genai
from google.genai import types
from flask import Flask, request, jsonify
from google.cloud import firestore
from dotenv import load_dotenv
import os
from datetime import datetime
import traceback
import firebase_admin 
from firebase_admin import credentials

load_dotenv()
cred = credentials.Certificate("firebaseServiceAccountKey.json")
firebase_admin.initialize_app(cred)

FIRESTORE_PROJECT_NAME=os.getenv("FIRESTORE_PROJECT_NAME")
LOCATION=os.getenv("LOCATION")
MODEL_ID=os.getenv("VERTEX_MODEL_ID")
PROJECT_ID=os.getenv("VERTEX_PROJECT_ID")

project_id =FIRESTORE_PROJECT_NAME # firestore project id
db = firestore.Client(project=project_id) #senstive

app = Flask(__name__)
@app.route('/interview_chatbot', methods=['POST'])

# Define function to process AAC request
def interview_chatbot():
      try:
        data = request.json
        if data is None:
            return jsonify({"error": "Missing 'ai_input' in request body"}), 400

        user_input = data.get("ai_input")
        print(f"user input: {user_input}")

        #AI Processing
        def generate():
            global ai_generated_text  # Ensure modification of the global variable

            client = genai.Client(
                vertexai=True,
                project=PROJECT_ID, #sensitive
                location=LOCATION,#sensitive
            )

            model = MODEL_ID 
            contents = [user_input]

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
            doc_ref = db.collection("ai_interview_output").document()
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
          print(f"error: {str(e)}")
          error_details = traceback.format_exc()
          return jsonify({"error": str(e),"details": error_details}), 500

if __name__=="__main__":
    port = int(os.getenv("PORT", 5000))
    app.run(host='0.0.0.0', port=port, debug=False)