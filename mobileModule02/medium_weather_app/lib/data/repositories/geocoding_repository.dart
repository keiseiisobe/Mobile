import '../services/geocoding.dart';

class GeocodingRepository {
  GeocodingRepository({
    required Geocoding geocoding,
  }) : _geocoding = geocoding;

  final Geocoding _geocoding;
  Map<String, List<dynamic>>? _cachedGeocoding;

  void getGeocoding(String location) async {
    print("Requesting geocoding for location: $location");  
    var result = await _geocoding.requestGeocoding(location);
    print("Geocoding result: $result");
  }
}