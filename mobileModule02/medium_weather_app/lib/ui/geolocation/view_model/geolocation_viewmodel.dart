import 'package:flutter/material.dart';
import '../../../data/services/geolocator.dart';
import '../../../data/repositories/gps_repository.dart';

class GeolocationViewModel extends ChangeNotifier {
  GeolocationViewModel({
    required isGeoLocationEnabled,
    required geolocationText,
  }) : _isGeoLocationEnabled = isGeoLocationEnabled,
      _geolocationText = geolocationText;

  bool _isGeoLocationEnabled;
  Text _geolocationText;
  final GpsRepository _gpsRepository = GpsRepository( 
    geoLocator: GeoLocator(),
  );

  Text get geolocationText => _geolocationText;
  bool get isGeoLocationEnabled => _isGeoLocationEnabled;

  void toggleGeoLocation() async {
    if (_isGeoLocationEnabled) {
      _isGeoLocationEnabled = false;
      _geolocationText = Text("");
    } else {
      _isGeoLocationEnabled = true;
      _geolocationText = await _gpsRepository.getCurrentPosition();
    }
    notifyListeners();
  }  

  void disableGeoLocation() {
    _isGeoLocationEnabled = false;
    notifyListeners();  
  }
}