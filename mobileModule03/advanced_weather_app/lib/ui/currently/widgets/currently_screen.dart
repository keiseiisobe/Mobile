import 'package:flutter/material.dart';
import '../../searchbar/view_model/searchbar_viewmodel.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';
import '../../../data/repositories/weather_repository.dart';

class CurrentlyScreen extends StatelessWidget {
  const CurrentlyScreen({
    super.key,
    required this.searchViewModel,
    required this.geolocationViewModel,
  });

  final SearchbarViewmodel searchViewModel;
  final GeolocationViewModel geolocationViewModel;

  @override
  Widget build(BuildContext context) {
    Map locationText;
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
          
        )
      );
    }
    return Container(
      padding: EdgeInsets.all(40.0),  
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),  
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  
          crossAxisAlignment: CrossAxisAlignment.center,  
          children: [
            Text(
              locationText['City'].toString(),
              // #FEDC5B
              style: TextStyle(color: Color(0xFFFEDC5B)),
            ),
            SizedBox(height: 4),
            Text("${locationText['Region']}, ${locationText['Country']}"),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),  
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,  
                  crossAxisAlignment: CrossAxisAlignment.center,  
                  children: [
                    Text(
                      "${locationText['Temperature']}°C",
                      style: TextStyle(color: Color(0xFFFEDC5B)),
                    ),
                    SizedBox(height: 4),
                    Text(weatherCode2String(
                      locationText['WeatherCode'],
                    )),
                    Icon(
                      weatherCode2Icon(locationText['WeatherCode']),
                      size: 100,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,  
                      mainAxisAlignment: MainAxisAlignment.center,  
                      children: [
                        Icon(
                          Icons.air,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${locationText['WindSpeed']} km/h",
                        ),
                      ],
                    ),
                  ],  
                ),  
              ),
            )
          ],
        ),
      ),
    );
  }
}