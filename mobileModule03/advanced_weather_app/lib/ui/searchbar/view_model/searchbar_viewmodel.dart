import 'package:flutter/material.dart';
import '../../../data/repositories/geocoding_repository.dart';
import '../../../data/services/geocoding.dart';
import '../../../data/repositories/weather_repository.dart';
import 'package:open_meteo/open_meteo.dart';

class SearchbarViewmodel extends ChangeNotifier {
  SearchbarViewmodel({
    required this.isSearchLocationEnabled,
    required this.searchController,
    required this.tabController,
  });

  bool isSearchLocationEnabled;
  SearchController searchController;
  TabController tabController;
  List<ListTile> suggestions = [];
  GeocodingRepository geocodingRepository = GeocodingRepository(geocoding: Geocoding());
  Map weatherDisplay = {};
  WeatherRepository weatherRepository = WeatherRepository();
  dynamic itemTemp = {};

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  void toggleSearchLocation() {
    if (!isSearchLocationEnabled) {
      isSearchLocationEnabled = true;
    }
    notifyListeners(); 
  }

  void disableSearchLocation() {
    isSearchLocationEnabled = false;
    notifyListeners();
  }
  
  Future<List<Widget>> updateSuggestions(String query) async {
    try {
      var result = await geocodingRepository.getSuggestions(query);
      if (result.isEmpty) {
        return [ListTile()];
      } else {
        return result.map((item) {
          var title = item['name'];
          var subtitle = "${item['admin1']}, ${item['country']}";
          return ListTile(
            title: Text(title, style: TextStyle(fontSize: 16)),
            subtitle: Text(subtitle, style: TextStyle(fontSize: 14)),
            leading: Icon(Icons.location_city),
            onTap: () async {
              searchController.closeView(title);
              itemTemp = item;
              updateWeatherDisplay();
            },
          );
        }).toList();
      }
    } catch (e) {
      return [ListTile(title: Text(e.toString()))];
    }
  }

  void updateWeatherDisplay() async {
    try {
      if (itemTemp.isEmpty) {
        return;
      }
      if (itemTemp.containsKey('error')) {
        weatherDisplay = {
          'Error': itemTemp['error'],  
        };
        notifyListeners();
        return;
      }
      if (tabController.index == 0) {
        var weather = await weatherRepository.getCurrentWeather(
          itemTemp['latitude']!,
          itemTemp['longitude']!,
        );
        weatherDisplay = {
          'City': itemTemp['name'],
          'Region': itemTemp['admin1'],
          'Country': itemTemp['country'],
          'WeatherCode': weather[WeatherCurrent.weather_code].value.toInt(),
          'Temperature': weather[WeatherCurrent.temperature_2m].value.toStringAsFixed(1),
          'WindSpeed': weather[WeatherCurrent.wind_speed_10m].value.toStringAsFixed(1),
        };
      } else if (tabController.index == 1) {
        var weather = await weatherRepository.getTodayWeather(
          itemTemp['latitude']!,
          itemTemp['longitude']!,
        );
        weatherDisplay = {
          'City': itemTemp['name'],
          'Region': itemTemp['admin1'],
          'Country': itemTemp['country'],
          "Time": weather["hourly"]["time"],
          "WeatherCodeList": weather["hourly"]["weather_code"],
          "TemperatureList": weather["hourly"]["temperature_2m"],
          "WindSpeedList": weather["hourly"]["wind_speed_10m"],
        };
      } else { // tabController.index == 2
        var weather = await weatherRepository.getWeeklyWeather(
          itemTemp['latitude']!,
          itemTemp['longitude']!,
        );
        weatherDisplay = {
          'City': itemTemp['name'],
          'Region': itemTemp['admin1'],
          'Country': itemTemp['country'],
          "Time": weather["daily"]["time"],
          "WeatherCodeList": weather["daily"]["weather_code"],
          "TemperatureMinList": weather["daily"]["temperature_2m_min"],
          "TemperatureMaxList": weather["daily"]["temperature_2m_max"],
        };
      }
    } catch (e) {
      weatherDisplay = {
        'Error': e.toString(),
      };
    } finally {
      notifyListeners();
    }
  }  

  Future<int> getFirstSuggestion(String query) async {
    try {
      var result = await geocodingRepository.getSuggestions(query);
      if (result.isEmpty) {
        throw "No suggestions found";
      } else {
        itemTemp = result[0];
      }
    } catch (e) {
      itemTemp = {
        'error': e.toString(),
      };
    }
    return 1;
   }
}