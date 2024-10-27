# mapping/urls.py
from django.urls import path
from . import views  # Import views from the same app

urlpatterns = [
    path('upload/', views.upload_geojson, name='upload_geojson'),  # URL for uploading GeoJSON
    path('geojson/', views.get_geojson, name='get_geojson'),  # URL for serving GeoJSON data
    path('upload_image/', views.upload_image, name='upload_image'),  # New URL for uploading images
]
