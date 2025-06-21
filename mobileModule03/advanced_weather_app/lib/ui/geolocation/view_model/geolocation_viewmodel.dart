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
    required tabController
  }) : _isGeoLocationEnabled = isGeoLocationEnabled,
        _tabController = tabController;

  bool _isGeoLocationEnabled;
  final TabController _tabController;
  Map weatherDisplay = {};
  final GpsRepository _gpsRepository = GpsRepository( 
    geoLocator: GeoLocator(),
  );
  final WeatherRepository _weatherRepository = WeatherRepository();
  final GeocodingRepository _geocodingRepository = GeocodingRepository(geocoding: Geocoding());

  bool get isGeoLocationEnabled => _isGeoLocationEnabled;

  void toggleGeoLocation() async {
    if (_isGeoLocationEnabled) {
      _isGeoLocationEnabled = false;
    } else {
      _isGeoLocationEnabled = true;
      updateWeatherDisplay();
    }
    notifyListeners();
  }  

  void updateWeatherDisplay() async {
    try {
      var position = await _gpsRepository.getCurrentPosition();
      var placemarks = await _geocodingRepository.getReverseGeocoding(position["Latitude"]!, position["Longitude"]!); 
      if (_tabController.index == 0) {
        var weather = await _weatherRepository.getCurrentWeather(
          position["Latitude"]!, 
          position["Longitude"]!,
        );
        weatherDisplay = {
          "City": placemarks.subAdministrativeArea != "" ? placemarks.subAdministrativeArea : placemarks.administrativeArea,
          "Region": placemarks.administrativeArea,
          "Country": placemarks.country,
          "WeatherCode": weather[WeatherCurrent.weather_code].value.toInt(),
          "Temperature": weather[WeatherCurrent.temperature_2m].value.toStringAsFixed(1),
          "WindSpeed": weather[WeatherCurrent.wind_speed_10m].value.toStringAsFixed(1),  
        };
      } else if (_tabController.index == 1) {
        var weather = await _weatherRepository.getTodayWeather(
          position["Latitude"]!,
          position["Longitude"]!,
        );
        weatherDisplay = {
          "City": placemarks.subAdministrativeArea != "" ? placemarks.subAdministrativeArea : placemarks.administrativeArea,
          "Region": placemarks.administrativeArea,
          "Country": placemarks.country,
          "Time": weather["hourly"]["time"],
          "WeatherCodeList": weather["hourly"]["weather_code"],
          "TemperatureList": weather["hourly"]["temperature_2m"],
          "WindSpeedList": weather["hourly"]["wind_speed_10m"],
        };
      } else { // _tabController.index == 2
        var weather = await _weatherRepository.getWeeklyWeather(
          position["Latitude"]!,
          position["Longitude"]!,
        );
        weatherDisplay = {
          "City": placemarks.subAdministrativeArea != "" ? placemarks.subAdministrativeArea : placemarks.administrativeArea,
          "Region": placemarks.administrativeArea,
          "Country": placemarks.country,
          "Time": weather["daily"]["time"],
          "WeatherCodeList": weather["daily"]["weather_code"],
          "TemperatureMinList": weather["daily"]["temperature_2m_min"],
          "TemperatureMaxList": weather["daily"]["temperature_2m_max"],
        };
      }
    } catch (e) {
      weatherDisplay = {
        "Error": e.toString(),
      };
    }
    notifyListeners();
  }

  void disableGeoLocation() {
    _isGeoLocationEnabled = false;
    notifyListeners();  
  }
}