import 'package:flutter/material.dart';

class GeolocationViewModel extends ChangeNotifier {
  GeolocationViewModel({
    required this.isGeoLocationEnabled,
    required this.geolocationText,
    required this.isSearchLocationEnabled,
  });

  bool isGeoLocationEnabled;
  String geolocationText;
  bool isSearchLocationEnabled; 

  void toggleGeoLocation() {
    if (isGeoLocationEnabled) {
      isGeoLocationEnabled = false;
      geolocationText = "";
    } else {
      isGeoLocationEnabled = true;
      geolocationText = "geolocation";
      isSearchLocationEnabled = false;
    }
    notifyListeners();
  }  

  Widget getGeoLocationText() {
    if (isGeoLocationEnabled) {
      return Text(geolocationText);
    } else {
      return Text("");
    }
  }
}