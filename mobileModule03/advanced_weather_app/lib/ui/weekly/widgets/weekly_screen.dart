import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weather_icons/weather_icons.dart';
import '../../searchbar/view_model/searchbar_viewmodel.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';
import '../../../data/repositories/weather_repository.dart';

class WeeklyScreen extends StatelessWidget {
  const WeeklyScreen({
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
    if (locationText.containsKey('Error')) {
      return Center(
        child: Container(
          margin: EdgeInsets.all(20.0),  
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            locationText['Error'].toString(),
            style: TextStyle(
              color: Color(0xFFFEDC5B),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (!locationText.containsKey('City') ||
        !locationText.containsKey('Region') ||
        !locationText.containsKey('Country') ||
        !locationText.containsKey('Time') ||
        !locationText.containsKey('WeatherCodeList') ||
        !locationText.containsKey('TemperatureMinList') ||
        !locationText.containsKey('TemperatureMaxList')) {
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
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            "${locationText['Region']}, ${locationText['Country']}",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(8),
              ),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: locationText['Time'].asMap().entries.map((temp) {
                        return FlSpot(
                          (DateTime.parse(temp.value.toString()).month * 100 + DateTime.parse(temp.value.toString()).day).toDouble(),
                          locationText['TemperatureMaxList'][temp.key].toDouble(),
                        );
                      }).toList().cast<FlSpot>(),
                      color: Colors.red,
                      barWidth: 4,
                      isCurved: true,
                    ),
                    LineChartBarData(
                      spots: locationText['Time'].asMap().entries.map((temp) {
                        return FlSpot(
                          (DateTime.parse(temp.value.toString()).month * 100 + DateTime.parse(temp.value.toString()).day).toDouble(),
                          locationText['TemperatureMinList'][temp.key].toDouble(),
                        );
                      }).toList().cast<FlSpot>(),
                      color: Colors.blue,
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
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              "${value.toInt() ~/ 100}/${value.toInt() % 100}",
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
                        "Weekly Temperature",
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
                        return touchedSpots.asMap().entries.map((spot) {
                          if (spot.key == 0) {
                            return LineTooltipItem(
                              "${spot.value.y.toStringAsFixed(1)}°C",
                              TextStyle(color: Colors.red),
                            );
                          } else {
                            return LineTooltipItem(
                              "${spot.value.y.toStringAsFixed(1)}°C",
                              TextStyle(color: Colors.blue),
                            );
                          }
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
              children: locationText['Time'].asMap().entries.map((temp) {
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
                        "${DateTime.parse(temp.value.toString()).month}/${DateTime.parse(temp.value.toString()).day}",
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${locationText["TemperatureMaxList"][temp.key].toStringAsFixed(1)}°C",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${locationText["TemperatureMinList"][temp.key].toStringAsFixed(1)}°C",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 4),
                      BoxedIcon(
                        weatherCode2Icon(locationText['WeatherCodeList'][temp.key].toInt()),
                        color: Color(0xFF88CBE3),
                        size: 40,
                      ),
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