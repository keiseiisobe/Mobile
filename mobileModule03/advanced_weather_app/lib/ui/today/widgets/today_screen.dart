import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../searchbar/view_model/searchbar_viewmodel.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';
import '../../../data/repositories/weather_repository.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({
    super.key,
    required this.searchViewModel,
    required this.geolocationViewModel,
  });

  final SearchbarViewmodel searchViewModel;
  final GeolocationViewModel geolocationViewModel;

  @override
  Widget build(BuildContext context) {
    Map locationText = {};
    if (geolocationViewModel.isGeoLocationEnabled) {
      locationText = geolocationViewModel.weatherDisplay;
    } else if (searchViewModel.isSearchLocationEnabled) {
      locationText = searchViewModel.weatherDisplay;
    } else {
      locationText = {
        'Message': 'My Weather App',
      };
    }
    if (locationText.containsKey('Message')) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            locationText['Message'].toString(),
            style: TextStyle(color: Color(0xFFFEDC5B), fontSize: 35, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
        ),
      );
    }
    if (!locationText.containsKey('City') ||
        !locationText.containsKey('Region') ||
        !locationText.containsKey('Country') ||
        !locationText.containsKey('TemperatureList') ||
        !locationText.containsKey('WeatherCodeList') ||
        !locationText.containsKey('WindSpeedList')) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            locationText['City'].toString(),
            style: TextStyle(color: Color(0xFFFEDC5B)),
          ),
          SizedBox(height: 4),
          Text("${locationText['Region']}, ${locationText['Country']}"),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(8),
              ),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: locationText['TemperatureList'].entries.map((temp) {
                        return FlSpot(
                          DateTime.parse(temp.key.toString()).hour.toDouble(),
                          temp.value,
                        );
                      }).toList().cast<FlSpot>(),
                      barWidth: 4,
                      isCurved: true,
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        minIncluded: false,  
                        maxIncluded: false,
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            "${value.toInt()}°C",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          );
                        },
                      )
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        maxIncluded: false,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "${value.toInt()}:00",
                              style: TextStyle(
                                fontSize: 10, 
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false)
                    ),
                    topTitles: AxisTitles(
                      axisNameWidget: Text(
                        "Today's Temperature",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),  
                      axisNameSize: 20,
                      sideTitles: SideTitles(showTitles: false)
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            "${spot.x.toInt()}:00\n${spot.y.toStringAsFixed(1)}°C",
                            TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: locationText['TemperatureList'].entries.map((temp) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${DateTime.parse(temp.key.toString()).hour}:00",
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${temp.value.toInt()}°C",
                        style: TextStyle(
                          color: Color(0xFFFEDC5B),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 4),
                      Icon(
                        weatherCode2Icon(locationText['WeatherCodeList'][temp.key].toInt()),
                        color: Color(0xFF88CBE3),
                        size: 40,
                      ),
                      SizedBox(height: 4),
                      Text("${locationText['WindSpeedList'][temp.key].toStringAsFixed(1)} m/s"),
                    ],
                  ),
                );
              }).toList().cast<Widget>(),
            )
          ),
        ],  
      )
    );
  }
}