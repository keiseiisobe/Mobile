import '../services/geolocator.dart';
import 'package:geolocator/geolocator.dart';

class GpsRepository {
  GpsRepository({
    required GeoLocator geoLocator,  
  }) : _geoLocator = geoLocator;

  final GeoLocator _geoLocator;
  Map<String, double>? _cachedCurrentPosition;

  Future<Map<String, double>> getCurrentPosition() async {
    if (_cachedCurrentPosition != null) {
      return _cachedCurrentPosition!;
    }  
    Position position = await _geoLocator.determinePosition();
    _cachedCurrentPosition = {
      "Latitude": position.latitude,
      "Longitude": position.longitude,
    };
    return _cachedCurrentPosition!;
  }  
}