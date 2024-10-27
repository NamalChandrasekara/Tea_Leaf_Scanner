import 'package:flutter/material.dart';

class FertilizerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fertilizer Recommendations')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General Fertilizer Information Section
            Text(
              'Tea Fertilizers',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Tea plants require various nutrients to thrive, and fertilizers play a vital role in providing these essential nutrients. Here are the fertilizers recommended for common nutrient deficiencies in tea plants:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 30),

            // Fertilizer for Nitrogen Deficiency
            _buildFertilizerCard(
              context,
              'Nitrogen Fertilizer (N)',
              'lib/assets/NF1.jpg',
              'Nitrogen is essential for leaf growth. Urea and ammonium sulfate are commonly used fertilizers for nitrogen deficiency.',
            ),
            SizedBox(height: 20),

            // Fertilizer for Potassium Deficiency
            _buildFertilizerCard(
              context,
              'Potassium Fertilizer (K)',
              'lib/assets/PF1.jpg',
              'Potassium is critical for disease resistance. Muriate of potash (potassium chloride) is often applied to address potassium deficiency.',
            ),
            SizedBox(height: 20),

            // Fertilizer for Sulfur Deficiency
            _buildFertilizerCard(
              context,
              'Sulfur Fertilizer (S)',
              'lib/assets/SF1.jpg',
              'Sulfur improves overall plant health. Gypsum and elemental sulfur are common fertilizers used for sulfur deficiency.',
            ),
            SizedBox(height: 20),

            // Fertilizer for Magnesium Deficiency
            _buildFertilizerCard(
              context,
              'Magnesium Fertilizer (Mg)',
              'lib/assets/MF1.jpg',
              'Magnesium is essential for photosynthesis. Epsom salts (magnesium sulfate) are commonly applied to correct magnesium deficiency.',
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the fertilizer card for each nutrient
  Widget _buildFertilizerCard(BuildContext context, String title, String imagePath, String description) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with vertical centering and padding
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
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
