import 'package:open_meteo/open_meteo.dart';

class Geocoding {
  final GeocodingApi _geocodingApi = GeocodingApi();

  Future<Map<String, dynamic>> requestGeocoding(String location) async {
    return await _geocodingApi.requestJson(
      name: location,
    );
  }
}