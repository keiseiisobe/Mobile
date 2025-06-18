import 'package:flutter/material.dart';
import '../../../data/repositories/geocoding_repository.dart';
import '../../../data/services/geocoding.dart';
import '../../../data/repositories/weather_repository.dart';
import 'package:open_meteo/open_meteo.dart';

class SearchbarViewmodel extends ChangeNotifier {
  SearchbarViewmodel({
    required this.isSearchLocationEnabled,
    required this.searchController,
  });

  bool isSearchLocationEnabled;
  SearchController searchController;
  List<ListTile> suggestions = [];
  GeocodingRepository geocodingRepository = GeocodingRepository(geocoding: Geocoding());
  Widget weatherDisplay = Text("");
  WeatherRepository weatherRepository = WeatherRepository();

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
          onTap: () async{
            searchController.closeView(title);
            weatherDisplay = await updateWeatherDisplay(item);
            notifyListeners();
          },
        );
      }).toList();
    }
  }

  Future<Widget> updateWeatherDisplay(dynamic item) async {
    var weather = await weatherRepository.getCurrentWeather(
      item['latitude']!,
      item['longitude']!,
    );
    return Column(
      children: [
        Text("City: ${item['name']}"),
        Text("Region: ${item['admin1']}"),
        Text("Country: ${item['country']}"),
        Text("Weather: ${weatherRepository.weatherCode2String(weather[WeatherCurrent.weather_code].value.toInt())}"),
        Text("Temp: ${weather[WeatherCurrent.temperature_2m].value.toStringAsFixed(1)}°C"),
        Text("Wind: ${weather[WeatherCurrent.wind_speed_10m].value.toStringAsFixed(1)}km/h"),
      ],
    );
  }  
}