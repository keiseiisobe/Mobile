import 'package:flutter/material.dart';
import '../services/weather.dart';
import 'package:http/http.dart';

class WeatherRepository {
  final Weather _weatherService = Weather();

  Future<Map> getCurrentWeather(double latitude, double longitude) async{
    try {
      return await _weatherService.requestCurrentWeather(latitude, longitude);
    } on ClientException {
      throw "Network error. Please check your connection.";
    } on Exception {
      throw "An error occurred while fetching current weather data.";
    }
  }

  Future<Map> getTodayWeather(double latitude, double longitude) async {
    try {
      return await _weatherService.requestTodayWeather(latitude, longitude);
    } on ClientException {
      throw "Network error. Please check your connection.";
    } on Exception {
      throw "An error occurred while fetching today's weather data.";
    }  
  }  

  Future<Map> getWeeklyWeather(double latitude, double longitude) async {
    try {
      return await _weatherService.requestWeeklyWeather(latitude, longitude);
    } on ClientException {
      throw "Network error. Please check your connection.";
    } on Exception {
      throw "An error occurred while fetching weekly weather data.";
    }  
  }
}


String weatherCode2String(int weatherCode) {
  switch (weatherCode) {
    case 0:
      return "Clear sky";
    case 1:
      return "Mainly clear";
    case 2:
      return "Partly cloudy";
    case 3:
      return "Overcast";
    case 45:
      return "Fog";
    case 48:
      return "Depositing rime fog";
    case 51:
      return "Drizzle light";
    case 53:
      return "Drizzle moderate";
    case 55:
      return "Drizzle dense";
    case 56:
      return "Freezing drizzle light";
    case 57:
      return "Freezing drizzle dense";
    case 61:
      return "Rain slight";
    case 63:
      return "Rain moderate";
    case 65:
      return "Rain heavy";
    case 66:
      return "Freezing rain light";
    case 67:
      return "Freezing rain heavy";
    case 71:
      return "Snow fall slight";
    case 73:
      return "Snow fall moderate";
    case 75:
      return "Snow fall heavy";
    case 77:
      return "Snow grains";
    case 80:
      return "Rain showers slight";
    case 81:
      return "Rain showers moderate";
    case 82:
      return "Rain showers violent";
    case 85:
      return "Snow showers slight";
    case 86:
      return "Snow showers heavy";
    case 95:
      return "Thunderstorm slight or moderate";
    case 96:
      return "Thunderstorm with slight hail";
    case 99:
      return "Thunderstorm with heavy hail";

    default:
      return "";
  }
}   

IconData weatherCode2Icon(int weatherCode) {
  switch (weatherCode) {
    case 0:
      return Icons.wb_sunny;
    case 1:
    case 2:
      return Icons.wb_cloudy;
    case 3:
      return Icons.cloud;
    case 45:
    case 48:
      return Icons.foggy;
    case 51:
    case 53:
    case 55:
      return Icons.grain;
    case 56:
    case 57:
      return Icons.snowing;
    case 61:
    case 63:
    case 65:
      return Icons.water_drop;
    case 66:
    case 67:
      return Icons.snowing;
    case 71:
    case 73:
    case 75:
      return Icons.ac_unit;
    case 77:
      return Icons.snowing;
    case 80:
    case 81:
    case 82:
      return Icons.shower;
    case 85:
    case 86:
      return Icons.snowing;
    case 95:
      return Icons.thunderstorm;
    case 96:
    case 99:
      return Icons.thunderstorm;

    default:
      return Icons.help_outline;
  }
}