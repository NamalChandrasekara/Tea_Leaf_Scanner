import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About App')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // About App Section
            Text(
              'About the App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This app is designed to help farmers identify nutrient deficiencies in tea plants using image recognition. By uploading images of tea leaves, the app can detect various deficiencies such as Nitrogen (N), Potassium (K), Sulfur (S), and Magnesium (Mg), and recommend remedies to improve plant health.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 30),

            // Nutrient Deficiency Section
            Text(
              'Nutrient Deficiencies in Tea Leaves',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // Deficiency 1 - Nitrogen (N)
            _buildNutrientCard(
              context,
              'Nitrogen Deficiency (N)',
              'lib/assets/nitrogen.jpg',
              'Nitrogen deficiency causes older leaves to turn yellow, leading to reduced growth. It’s essential for chlorophyll production and leaf development.',
            ),
            SizedBox(height: 20),

            // Deficiency 2 - Potassium (K)
            _buildNutrientCard(
              context,
              'Potassium Deficiency (K)',
              'lib/assets/potassium.jpg',
              'Potassium deficiency results in browning at the leaf edges and affects the plant’s ability to resist diseases.',
            ),
            SizedBox(height: 20),

            // Deficiency 3 - Sulfur (S)
            _buildNutrientCard(
              context,
              'Sulfur Deficiency (S)',
              'lib/assets/sulfur.jpg',
              'Sulfur deficiency causes pale yellow leaves and stunted growth, affecting overall tea yield.',
            ),
            SizedBox(height: 20),

            // Deficiency 4 - Magnesium (Mg)
            _buildNutrientCard(
              context,
              'Magnesium Deficiency (Mg)',
              'lib/assets/magnesium.jpg',
              'Magnesium deficiency leads to interveinal chlorosis (yellowing between veins) and can hinder photosynthesis.',
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the nutrient card for each deficiency
  Widget _buildNutrientCard(BuildContext context, String title, String imagePath, String description) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.green, width: 2),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image section with vertical centering
        Padding(
          padding: const EdgeInsets.all(10.0), // Space between image and border
          child: Align(
            alignment: Alignment.centerLeft, // Aligns the image in the middle of the container
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),

        // Text section
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}