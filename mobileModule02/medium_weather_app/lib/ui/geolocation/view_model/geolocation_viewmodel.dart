import 'package:flutter/material.dart';
import '../../../data/services/geolocator.dart';
import '../../../data/repositories/gps_repository.dart';


class GeolocationViewModel extends ChangeNotifier {
  GeolocationViewModel({
    required this.isGeoLocationEnabled,
    required this.geolocationText,
    required this.isSearchLocationEnabled,
  });

  bool isGeoLocationEnabled;
  String geolocationText;
  bool isSearchLocationEnabled; 
  final GpsRepository gpsRepository = GpsRepository( 
    geoLocator: GeoLocator(),
  );

  void toggleGeoLocation() async {
    if (isGeoLocationEnabled) {
      isGeoLocationEnabled = false;
      geolocationText = "";
      isSearchLocationEnabled = false;
    } else {
      isGeoLocationEnabled = true;
      var position = await gpsRepository.getCurrentPosition();
      geolocationText = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
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