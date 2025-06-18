import 'package:flutter/material.dart';
import '../../../data/repositories/geocoding_repository.dart';
import '../../../data/services/geocoding.dart';
import '../../../data/repositories/weather_repository.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:intl/intl.dart';

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
  Widget weatherDisplay = Text("");
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
          onTap: () async {
            searchController.closeView(title);
            itemTemp = item;
            updateWeatherDisplay();
          },
        );
      }).toList();
    }
  }

  void updateWeatherDisplay() async {
    if (tabController.index == 0) {
      var weather = await weatherRepository.getCurrentWeather(
        itemTemp['latitude']!,
        itemTemp['longitude']!,
      );
      weatherDisplay = Column(
        children: [
          Text("City: ${itemTemp['name']}"),
          Text("Region: ${itemTemp['admin1']}"),
          Text("Country: ${itemTemp['country']}"),
          Text("Weather: ${weatherRepository.weatherCode2String(weather[WeatherCurrent.weather_code].value.toInt())}"),
          Text("Temp: ${weather[WeatherCurrent.temperature_2m].value.toStringAsFixed(1)}°C"),
          Text("Wind: ${weather[WeatherCurrent.wind_speed_10m].value.toStringAsFixed(1)}km/h"),
        ],
      );
    } else if (tabController.index == 1) {
      var weather = await weatherRepository.getTodayWeather(
        itemTemp['latitude']!,
        itemTemp['longitude']!,
      );
      List<dynamic> todayWeatherData = weather[WeatherHourly.weather_code].values.entries.map((entry) {
        var time = entry.key;
        var weatherDescription = weatherRepository.weatherCode2String(entry.value.toInt());
        var temperature = weather[WeatherHourly.temperature_2m].values[time];
        var windSpeed = weather[WeatherHourly.wind_speed_10m].values[time];
        return Text(
          "${DateFormat("HH:mm").format(time)} $weatherDescription ${temperature.toStringAsFixed(1)}°C ${windSpeed.toStringAsFixed(1)}km/h",
          style: TextStyle(fontSize: 15),
        );
      }).toList();
      weatherDisplay = Column(
        children: [
          Text("City: ${itemTemp['name']}"),
          Text("Region: ${itemTemp['admin1']}"),
          Text("Country: ${itemTemp['country']}"),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: todayWeatherData.cast<Widget>(),
          ),
        ],
      );  
    } else { // tabController.index == 2
      var weather = await weatherRepository.getWeeklyWeather(
        itemTemp['latitude']!,
        itemTemp['longitude']!,
      );
      List<dynamic> weeklyWeatherData = weather[WeatherDaily.weather_code].values.entries.map((entry) {
        var date = entry.key;
        var weatherDescription = weatherRepository.weatherCode2String(entry.value.toInt());
        var minTemp = weather[WeatherDaily.temperature_2m_min].values[date];
        var maxTemp = weather[WeatherDaily.temperature_2m_max].values[date];
        return Text(
          "${DateFormat("yyyy-MM-dd").format(date)}: $weatherDescription ${minTemp.toStringAsFixed(1)}°C - ${maxTemp.toStringAsFixed(1)}°C",
          style: TextStyle(fontSize: 15),
        );
      }).toList();
      weatherDisplay = Column(
        children: [
          Text("City: ${itemTemp['name']}"),
          Text("Region: ${itemTemp['admin1']}"),
          Text("Country: ${itemTemp['country']}"),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: weeklyWeatherData.cast<Widget>(),
          ),
        ],
      );
    }
    notifyListeners();
  }  
}