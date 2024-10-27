# forms.py
from django import forms
from .models import GeoJSONFile

# Form for handling GeoJSON file uploads
class GeoJSONForm(forms.ModelForm):
    class Meta:
        model = GeoJSONFile
        fields = ['name', 'file']

# New form for handling image uploads
class ImageUploadForm(forms.Form):
    file = forms.ImageField(label="Upload Image")
