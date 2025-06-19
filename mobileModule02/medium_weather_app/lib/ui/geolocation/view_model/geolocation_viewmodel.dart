import 'package:flutter/material.dart';
import '../../../data/services/geolocator.dart';
import '../../../data/repositories/gps_repository.dart';
import '../../../data/repositories/weather_repository.dart';
import '../../../data/repositories/geocoding_repository.dart';
import '../../../data/services/geocoding.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:intl/intl.dart';

class GeolocationViewModel extends ChangeNotifier {
  GeolocationViewModel({
    required isGeoLocationEnabled,
    required tabController
  }) : _isGeoLocationEnabled = isGeoLocationEnabled,
        _tabController = tabController;

  bool _isGeoLocationEnabled;
  final TabController _tabController;
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
      } else if (_tabController.index == 1) {
        var weather = await _weatherRepository.getTodayWeather(
          position["Latitude"]!,
          position["Longitude"]!,
        );
        List<dynamic> todayWeatherData = weather[WeatherHourly.weather_code].values.entries.map((entry) {
          var time = entry.key;
          var weatherDescription = _weatherRepository.weatherCode2String(entry.value.toInt());  
          var temperature = weather[WeatherHourly.temperature_2m].values[time];
          var windSpeed = weather[WeatherHourly.wind_speed_10m].values[time];
          return Text(
            "${DateFormat("HH:mm").format(time)} $weatherDescription ${temperature.toStringAsFixed(1)}°C ${windSpeed.toStringAsFixed(1)}km/h",
            style: TextStyle(fontSize: 15),
          );
        }).toList();
        weatherDisplay = Column(
          children: [
            Text("City: ${placemarks.subAdministrativeArea != "" ? placemarks.subAdministrativeArea : placemarks.administrativeArea}"),
            Text("Region: ${placemarks.administrativeArea}"),
            Text("Country: ${placemarks.country}"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,  
              children: todayWeatherData.cast<Widget>(),
            )
          ],
        );
      } else { // _tabController.index == 2
        var weather = await _weatherRepository.getWeeklyWeather(
          position["Latitude"]!,
          position["Longitude"]!,
        );
        List<dynamic> weeklyWeatherData = weather[WeatherDaily.weather_code].values.entries.map((entry) {
          var date = entry.key;
          var weatherDescription = _weatherRepository.weatherCode2String(entry.value.toInt());
          var minTemp = weather[WeatherDaily.temperature_2m_min].values[date];
          var maxTemp = weather[WeatherDaily.temperature_2m_max].values[date];
          return Text(
            "${DateFormat("yyyy-MM-dd").format(date)}: $weatherDescription ${minTemp.toStringAsFixed(1)}°C - ${maxTemp.toStringAsFixed(1)}°C",
            style: TextStyle(fontSize: 15),
          );
        }).toList();
        weatherDisplay = Column(
          children: [
            Text("City: ${placemarks.subAdministrativeArea != "" ? placemarks.subAdministrativeArea : placemarks.administrativeArea}"),
            Text("Region: ${placemarks.administrativeArea}"),
            Text("Country: ${placemarks.country}"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,  
              children: weeklyWeatherData.cast<Widget>(),
            )
          ],
        );
      }
    } catch (e) {
      weatherDisplay = Text(
        e.toString(),
        style: TextStyle(
          color: Colors.red,
        ),
      );
    }
    notifyListeners();
  }

  void disableGeoLocation() {
    _isGeoLocationEnabled = false;
    notifyListeners();  
  }
}