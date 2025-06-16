import '../services/geolocator.dart';
import 'package:geolocator/geolocator.dart';

class GpsRepository {
  GpsRepository({
    required GeoLocator geoLocator,  
  }) : _geoLocator = geoLocator;

  final GeoLocator _geoLocator;
  // save cache of the current position
  Position? _cachedCurrentPosition;

  Future<Position> getCurrentPosition() async {
    if (_cachedCurrentPosition != null) {
      return _cachedCurrentPosition!;
    }  
    _cachedCurrentPosition = await _geoLocator.determinePosition();
    return _cachedCurrentPosition!;
  }  
}