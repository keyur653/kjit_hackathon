import 'package:geolocator/geolocator.dart';

/// Function to check if the current location is within a specified radius of a target location.
/// 
/// [targetLatitude] and [targetLongitude] are the coordinates of the target location.
/// [radius] is the radius in meters.
///
/// Returns a Future<String> indicating whether the current location is inside or outside the specified area.
Future<String> isLocationWithinRadius(
    double targetLatitude, double targetLongitude, double radius) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return "Location services are disabled. Please enable them.";
  }

  // Check location permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return "Location permissions are denied.";
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return "Location permissions are permanently denied.";
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

  // Determine if the current position is within the specified radius
  if (distanceInMeters <= radius) {
    return "You are within the specified area.";
  } else {
    return "You are outside the specified area.";
  }
}
