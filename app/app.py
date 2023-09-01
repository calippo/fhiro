from flask import Flask, request, jsonify
from datetime import datetime
from magic import extract_fhir_objects
import fitz
import io

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health():
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return jsonify({'current_time': current_time})

@app.route('/extract_fhir_objects', methods=['POST'])
def extract_fhir_objects_route():
    content = request.get_json()
    text = content['text']
    medication_requests, appointments = extract_fhir_objects(text)
    return jsonify({
        'medication_requests': medication_requests,
        'appointments': appointments,
    })

@app.route('/extract_fhir_objects_from_pdf', methods=['POST'])
def extract_fhir_objects_from_pdf_route():
    file = request.files['file']
    pdf_data = io.BytesIO(file.read())
    doc = fitz.open(pdf_data)
    text = ""
    for page in doc:
        text += page.getText()
    medication_requests, appointments = extract_fhir_objects(text)
    return jsonify({
        'medication_requests': medication_requests,
        'appointments': appointments,
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8081)