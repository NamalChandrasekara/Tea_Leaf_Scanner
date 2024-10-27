import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';  // For LatLng

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});  // Using super.key for constructor

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();  // Create a MapController
  List<LatLng> polygonPoints = [];

  @override
  void initState() {
    super.initState();
    plotPolygonManually();  // Manually plot the polygon
    adjustMapToPolygonBounds();  // Adjust the map after plotting the polygon
  }

  // Manually provide the converted GeoJSON coordinates to the polygonPoints list
  void plotPolygonManually() {
    setState(() {
      // These are the converted coordinates from EPSG:3857 to EPSG:4326 (latitude, longitude)
      polygonPoints = [
        LatLng(5.95648, 79.85232), // Example converted lat/lng
        LatLng(5.95672, 79.85231),
        LatLng(5.95674, 79.85229),
        LatLng(5.95650, 79.85228),
        LatLng(5.95592, 79.85230),
        LatLng(5.95572, 79.85226),
        LatLng(5.95531, 79.85222),
        LatLng(5.95512, 79.85236),
        LatLng(5.95489, 79.85237),
        LatLng(5.95449, 79.85237),
        LatLng(5.95382, 79.85240),
        LatLng(5.95342, 79.85242),
        LatLng(5.95281, 79.85249),
        LatLng(5.95277, 79.85248),
        LatLng(5.95181, 79.85255),
        LatLng(5.95190, 79.85260),
        LatLng(5.95200, 79.85268),
        LatLng(5.95250, 79.85272),
        LatLng(5.95322, 79.85268),
        LatLng(5.95354, 79.85261),
        LatLng(5.95398, 79.85254),
        LatLng(5.95467, 79.85257),
        LatLng(5.95512, 79.85260),
        LatLng(5.95648, 79.85232),  // Closing the polygon loop
      ];
    });
  }

  // Manually adjust the map center based on the polygon points
  void adjustMapToPolygonBounds() {
    if (polygonPoints.isNotEmpty) {
      // Calculate the center by averaging the latitude and longitude values
      double avgLat = polygonPoints.map((p) => p.latitude).reduce((a, b) => a + b) / polygonPoints.length;
      double avgLng = polygonPoints.map((p) => p.longitude).reduce((a, b) => a + b) / polygonPoints.length;

      // Move the map to the center point with a fixed zoom level
      _mapController.move(LatLng(avgLat, avgLng), 12.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map with GeoJSON'),
      ),
      body: FlutterMap(
        mapController: _mapController,  // Attach the MapController
        options: MapOptions(
          initialCenter: LatLng(5.95648, 79.85232),  // Set the initial center of the map based on converted coordinates
          initialZoom
          : 12.0,  // Set the initial zoom level
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          PolygonLayer(
            polygons: [
              Polygon(
                points: polygonPoints,
                color: Colors.blue.withOpacity(0.3),
                borderStrokeWidth: 2,
                borderColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
