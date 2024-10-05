import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationCheckerScreen extends StatefulWidget {
  @override
  _LocationCheckerScreenState createState() => _LocationCheckerScreenState();
}

class _LocationCheckerScreenState extends State<LocationCheckerScreen> {
  String locationMessage = "Press the button to check your location.";
  final double targetLatitude =
      37.39482; // Target latitude (example: San Francisco)
  final double targetLongitude = -122.1320467; // Target longitude
  final double radius = 20; // Radius in meters (1 km)

  Future<void> checkLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = "Location services are disabled. Please enable them.";
      });
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage = "Location permissions are permanently denied.";
      });
      return;
    }

    // Get current position
    Position currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.high));

    // Calculate distance to target location
    double distanceInMeters = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      targetLatitude,
      targetLongitude,
    );

    setState(() {
      if (distanceInMeters <= radius) {
        locationMessage = "You are within the specified area.";
      } else {
        locationMessage = "You are outside the specified area.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Checker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                locationMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: checkLocation,
                child: Text('Check Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
