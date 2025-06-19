import 'package:geocoding/geocoding.dart';
import '../services/geocoding.dart';
import 'package:http/http.dart';

class GeocodingRepository {
  GeocodingRepository({
    required Geocoding geocoding,
  }) : _geocoding = geocoding;

  final Geocoding _geocoding;

  Future<List<dynamic>> getSuggestions(String location) async {
    try {
      var results = await _geocoding.requestGeocoding(location);
      if (!results.containsKey('results')) {
        if (results.containsKey('error')) {
            throw results['reason'];
        } else {
          return [];
        }
      }
      return results['results'];
    } on ClientException {
      throw 'Network error. Please check your connection.';
    } on Exception {
      throw 'An error occurred while fetching suggestions.';  
    }
  }

  Future<Placemark> getReverseGeocoding(double latitude, double longitude) async {
    try {
      return await _geocoding.requestReverseGeocoding(latitude, longitude);
    } on ClientException {
      throw "Network error. Please check your connection.";
    } on Exception {
      throw "An error occurred while fetching reverse geocoding data.";
    }
  } 
}