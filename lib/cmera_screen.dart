import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? nitrogenPrediction;
  String? sulfurPrediction;

  // Method to open the camera and capture an image
  Future<void> _getStarted() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please turn on location and geotag in camera app'),
        duration: Duration(seconds: 5),
      ),
    );

    await Future.delayed(Duration(seconds: 5));

    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image captured successfully!'),
        ),
      );
    }
  }

  // Method to select an image from the gallery
  Future<void> _pickFromGallery() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image selected successfully!'),
        ),
      );
    }
  }

  // Method to upload the selected image to the Django backend for predictions
  Future<void> _uploadImageToDjango() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No image selected to upload!'),
        ),
      );
      return;
    }

    String djangoUrl = 'http://127.0.0.1:8000/mapping/upload_image/'; // Update with your Django backend URL

    var request = http.MultipartRequest('POST', Uri.parse(djangoUrl));
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      String result = await response.stream.bytesToString();
      print("Response: $result");

      // Parse the JSON response
      var jsonResponse = json.decode(result);

      // Extract predictions
      setState(() {
        nitrogenPrediction = jsonResponse['Nitrogen Deficiency Prediction']['Prediction'];
        sulfurPrediction = jsonResponse['Sulfur Deficiency Prediction']['Prediction'];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image uploaded and predictions received!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload the image!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!, height: 300, width: 300)
                : Text('No image captured yet'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Get Started! (Open Camera)'),
              onPressed: _getStarted,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Select Image from Gallery'),
              onPressed: _pickFromGallery,
            ),
            SizedBox(height: 20),
            // Display "Upload Image to Get Prediction" button only if an image is selected or captured
            _image != null
                ? ElevatedButton(
                    child: Text('Upload Image to Get Prediction'),
                    onPressed: _uploadImageToDjango,
                  )
                : Container(),
            SizedBox(height: 20),
            nitrogenPrediction != null
                ? Text('Nitrogen Deficiency: $nitrogenPrediction')
                : Container(),
            sulfurPrediction != null
                ? Text('Sulfur Deficiency: $sulfurPrediction')
                : Container(),
          ],
        ),
      ),
    );
  }
}
