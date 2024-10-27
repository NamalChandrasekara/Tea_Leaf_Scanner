import 'package:flutter/material.dart';
import 'package:wtm_projec/cmera_screen.dart';
import 'package:wtm_projec/map_screen.dart';
import 'package:wtm_projec/fertilizer_screen.dart';
import 'package:wtm_projec/about_screen.dart';

class PortalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var portalStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final topPortalHeight = 200.0; // Height of the top portal
    final smallPortalSize = screenWidth / 2 - 20; // Size of the small portals

    return Scaffold(
      appBar: AppBar(
        title: Text('Portal Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Portal - Upload Image (Full Width)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/camera.jpg', // Replace with your image path
                      fit: BoxFit.cover,
                      height: topPortalHeight,
                      width: double.infinity,
                    ),
                    Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0), // Space between top portal and grid

            // 2x2 Grid for the remaining portals
            Row(
              children: [
                // Portal 1 - Map (half-width)
                _buildSmallPortal(
                  context,
                  'lib/assets/map.jpg',
                  'Map',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapScreen()),
                  ),
                  smallPortalSize,
                ),
                SizedBox(width: 8.0),
                // Portal 2 - Fertilizer Recommendation (half-width)
                _buildSmallPortal(
                  context,
                  'lib/assets/fertilizer.jpg',
                  'Fertilizer Recommendation',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FertilizerScreen()),
                  ),
                  smallPortalSize,
                ),
              ],
            ),
            SizedBox(height: 8.0), // Space between grid rows
            Row(
              children: [
                // Portal 3 - Get Prediction (half-width)
                _buildSmallPortal(
                  context,
                  'lib/assets/prediction.jpg',
                  'Chat With Us',
                  () {
                    // Add navigation or logic for prediction screen
                  },
                  smallPortalSize,
                ),
                SizedBox(width: 8.0),
                // Portal 4 - About (half-width)
                _buildSmallPortal(
                  context,
                  'lib/assets/about.jpg',
                  'About',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutScreen()),
                  ),
                  smallPortalSize,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to build each small portal
  Widget _buildSmallPortal(
      BuildContext context, String imagePath, String label, VoidCallback onTap, double size) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: size,
                width: size,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
