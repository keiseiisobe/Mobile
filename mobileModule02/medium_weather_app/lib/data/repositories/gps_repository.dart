import 'package:flutter/material.dart';
import '../services/geolocator.dart';
import 'package:geolocator/geolocator.dart';

class GpsRepository {
  GpsRepository({
    required GeoLocator geoLocator,  
  }) : _geoLocator = geoLocator;

  final GeoLocator _geoLocator;
  // save cache of the current position
  Text? _cachedCurrentPosition;

  Future<Text> getCurrentPosition() async {
    // if (_cachedCurrentPosition != null) {
    //   return _cachedCurrentPosition!;
    // }  
    try {
      Position position = await _geoLocator.determinePosition();
      _cachedCurrentPosition = Text("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    } catch (e) {
      _cachedCurrentPosition = Text(
        "Error: ${e.toString()}",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),
      );
    }
    return _cachedCurrentPosition!;
  }  
}