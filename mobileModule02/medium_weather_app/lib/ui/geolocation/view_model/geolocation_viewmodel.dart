import 'package:flutter/material.dart';
import '../../../data/services/geolocator.dart';
import '../../../data/repositories/gps_repository.dart';
import '../../../data/repositories/weather_repository.dart';
import '../../../data/repositories/geocoding_repository.dart';
import '../../../data/services/geocoding.dart';
import 'package:open_meteo/open_meteo.dart';

class GeolocationViewModel extends ChangeNotifier {
  GeolocationViewModel({
    required isGeoLocationEnabled,
  }) : _isGeoLocationEnabled = isGeoLocationEnabled;

  bool _isGeoLocationEnabled;
  Widget weatherDisplay = Text("");
  final GpsRepository _gpsRepository = GpsRepository( 
    geoLocator: GeoLocator(),
  );
  final WeatherRepository _weatherRepository = WeatherRepository();
  final GeocodingRepository _geocodingRepository = GeocodingRepository(geocoding: Geocoding());

  bool get isGeoLocationEnabled => _isGeoLocationEnabled;

  void toggleGeoLocation() async {
    if (_isGeoLocationEnabled) {
      _isGeoLocationEnabled = false;
      weatherDisplay = Text("");
    } else {
      _isGeoLocationEnabled = true;
      try {
        var position = await _gpsRepository.getCurrentPosition();
        var placemarks = await _geocodingRepository.getReverseGeocoding(position["Latitude"]!, position["Longitude"]!); 
        var weather = await _weatherRepository.getCurrentWeather(
          position["Latitude"]!, 
          position["Longitude"]!,
        );
        weatherDisplay = Column(
          children: [
            Text("City: ${placemarks.subAdministrativeArea != "" ? placemarks.subAdministrativeArea : placemarks.administrativeArea}"),
            Text("Region: ${placemarks.administrativeArea}"),
            Text("Country: ${placemarks.country}"),
            Text("Weather: ${_weatherRepository.weatherCode2String(weather[WeatherCurrent.weather_code].value.toInt())}"),
            Text("Temp: ${weather[WeatherCurrent.temperature_2m].value.toStringAsFixed(1)}°C"),
            Text("Wind: ${weather[WeatherCurrent.wind_speed_10m].value.toStringAsFixed(1)}km/h"),
          ],
        );
      } catch (e) {
        weatherDisplay = Text(
          "Error: $e",
          style: TextStyle(
            color: Colors.red,
          ),
        );
      }
    }
    notifyListeners();
  }  

  void disableGeoLocation() {
    _isGeoLocationEnabled = false;
    notifyListeners();  
  }
}