import 'package:open_meteo/open_meteo.dart';

class Weather {
  final WeatherApi _weatherApi = WeatherApi();

  Future<Map> requestCurrentWeather(double latitude, double longitude) async {
    final weather = await _weatherApi.request(
      latitude: latitude,
      longitude: longitude,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      current: {
        WeatherCurrent.weather_code,  
        WeatherCurrent.temperature_2m,
        WeatherCurrent.wind_speed_10m,
      },
    );
    return weather.currentData;
  }
}