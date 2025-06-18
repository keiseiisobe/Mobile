import 'package:geocoding/geocoding.dart';
import '../services/geocoding.dart';

class GeocodingRepository {
  GeocodingRepository({
    required Geocoding geocoding,
  }) : _geocoding = geocoding;

  final Geocoding _geocoding;
  Map<String, List<dynamic>>? _cachedGeocoding;

  Future<List<dynamic>> getSuggestions(String location) async {
    var results = await _geocoding.requestGeocoding(location);
    if (results['results'] == null) {
      return [];
    }
    return results['results'];
  }

  Future<Placemark> getReverseGeocoding(double latitude, double longitude) async {
    return await _geocoding.requestReverseGeocoding(latitude, longitude);
  } 

}