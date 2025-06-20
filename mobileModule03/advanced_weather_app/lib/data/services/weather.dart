import 'package:open_meteo/open_meteo.dart';

class Weather {
  final WeatherApi _weatherApi = WeatherApi();

  Future<Map> requestCurrentWeather(double latitude, double longitude) async {
    final weather = await _weatherApi.request(
      latitude: latitude,
      longitude: longitude,
      current: {
        WeatherCurrent.weather_code,  
        WeatherCurrent.temperature_2m,
        WeatherCurrent.wind_speed_10m,
      },
    );
    return weather.currentData;
  }

  Future<Map> requestTodayWeather(double latitude, double longitude) async {
    final weather = await _weatherApi.request(
      latitude: latitude,
      longitude: longitude,
      forecastDays: 1,
      hourly: {
        WeatherHourly.temperature_2m,
        WeatherHourly.weather_code,
        WeatherHourly.wind_speed_10m,
      },
    );
    return weather.hourlyData;
  }  

  Future<Map> requestWeeklyWeather(double latitude, double longitude) async {
    final weather = await _weatherApi.request(
      latitude: latitude,
      longitude: longitude,
      forecastDays: 7,
      daily: {
        WeatherDaily.temperature_2m_min,
        WeatherDaily.temperature_2m_max,
        WeatherDaily.weather_code,
      },
    );
    return weather.dailyData;
  }  
}