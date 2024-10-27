import requests
from django.http import JsonResponse
from django.shortcuts import render, redirect
from .forms import GeoJSONForm  # Import form for GeoJSON handling
from .models import GeoJSONFile  # Model for GeoJSON storage
import json

# Hugging Face Inference API URLs and Tokens
NITROGEN_MODEL_API_URL = 'https://q77xspdt5srzx977.us-east-1.aws.endpoints.huggingface.cloud'
SULFUR_MODEL_API_URL = 'https://qb9duff42snphk8y.us-east-1.aws.endpoints.huggingface.cloud'
NITROGEN_API_TOKEN = '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'
SULFUR_API_TOKEN = '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'

# Label mappings for prediction
nitrogen_label_mapping = {
    "LABEL_0": "Advanced",
    "LABEL_1": "Early",
    "LABEL_2": "Healthy",
    "LABEL_3": "NotNitrogenDeficient"
}

sulfur_label_mapping = {
    "LABEL_0": "Advanced",
    "LABEL_1": "Early",
    "LABEL_2": "Healthy",
    "LABEL_3": "NotSulphurDeficient"
}

# View to handle the GeoJSON file upload
def upload_geojson(request):
    if request.method == 'POST':
        form = GeoJSONForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('upload_geojson')
    else:
        form = GeoJSONForm()
    return render(request, 'mapping/upload.html', {'form': form})

# View to serve the GeoJSON data
def get_geojson(request):
    geojson = GeoJSONFile.objects.latest('uploaded_at')
    with open(geojson.file.path) as f:
        data = json.load(f)
    return JsonResponse(data)

# View to handle image upload and Hugging Face API interaction
def upload_image(request):
    if request.method == 'POST':
        # Check if the file key exists in the request.FILES
        if 'file' not in request.FILES:
            return JsonResponse({"error": "No file uploaded"}, status=400)
        
        # Directly get the image from the Flutter request
        file = request.FILES['file']
        image_data = file.read()

        # Send the image to Hugging Face models
        headers_nitrogen = {
            'Authorization': f'Bearer {NITROGEN_API_TOKEN}',
            'Content-Type': 'image/jpeg'
        }
        headers_sulfur = {
            'Authorization': f'Bearer {SULFUR_API_TOKEN}',
            'Content-Type': 'image/jpeg'
        }

        # Request predictions from both models
        nitrogen_response = requests.post(NITROGEN_MODEL_API_URL, headers=headers_nitrogen, data=image_data)
        sulfur_response = requests.post(SULFUR_MODEL_API_URL, headers=headers_sulfur, data=image_data)

        if nitrogen_response.status_code == 200 and sulfur_response.status_code == 200:
            nitrogen_response_json = nitrogen_response.json()
            sulfur_response_json = sulfur_response.json()

            nitrogen_label = nitrogen_response_json[0]['label']
            nitrogen_score = nitrogen_response_json[0]['score']
            sulfur_label = sulfur_response_json[0]['label']
            sulfur_score = sulfur_response_json[0]['score']

            nitrogen_prediction = nitrogen_label_mapping.get(nitrogen_label, "Unknown")
            sulfur_prediction = sulfur_label_mapping.get(sulfur_label, "Unknown")

            return JsonResponse({
                "Nitrogen Deficiency Prediction": {
                    "Prediction": nitrogen_prediction,
                    "Confidence Score": nitrogen_score
                },
                "Sulfur Deficiency Prediction": {
                    "Prediction": sulfur_prediction,
                    "Confidence Score": sulfur_score
                }
            })
        else:
            return JsonResponse({"error": "Failed to get predictions"}, status=500)

    # Commented out the parts related to rendering HTML form
    # else:
    #     form = ImageUploadForm()
    # return render(request, 'mapping/upload_image.html', {'form': form})