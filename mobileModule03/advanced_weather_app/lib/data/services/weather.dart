import 'dart:convert';
import 'package:open_meteo/open_meteo.dart';
import 'package:http/http.dart' as http;

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
    final weather = await http.get(
      Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&forecast_days=1&hourly=temperature_2m,weather_code,wind_speed_10m&timezone=auto',
      ),
    ); 
    return jsonDecode(weather.body) as Map;
  }  

  Future<Map> requestWeeklyWeather(double latitude, double longitude) async {
    final weather = await http.get(
      Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&forecast_days=7&daily=temperature_2m_min,temperature_2m_max,weather_code&timezone=auto',
      ),
    ); 
    return jsonDecode(weather.body) as Map;
  }  
}