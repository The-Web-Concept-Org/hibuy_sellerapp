// lib/services/location_helper.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// ✅ Location fetch helper function
Future<void> getCurrentLocation(TextEditingController controller) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Service enabled check
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print("Location services are disabled.");
    return;
  }

  // Permission check
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("Location permission denied.");
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    print("Location permission permanently denied.");
    return;
  }

  // Get location
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Set text in textfield
  controller.text = "${position.latitude},${position.longitude}";
  print("📍 Current Location: ${controller.text}");
}
