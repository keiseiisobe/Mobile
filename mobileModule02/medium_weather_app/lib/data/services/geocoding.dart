import 'package:open_meteo/open_meteo.dart';
import 'package:geocoding/geocoding.dart';

class Geocoding {
  final GeocodingApi _geocodingApi = GeocodingApi();

  Future<Map<String, dynamic>> requestGeocoding(String location) async {
    return await _geocodingApi.requestJson(
      name: location,
    );
  }

  Future<Placemark> requestReverseGeocoding(double latitude, double longitude) async {
    return await setLocaleIdentifier("en_US").then((_) async {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude, 
      );
      return placemarks[0];
    });
  }  
}