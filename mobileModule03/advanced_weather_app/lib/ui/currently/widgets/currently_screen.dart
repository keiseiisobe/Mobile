import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
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
        !locationText.containsKey('Temperature') ||
        !locationText.containsKey('WeatherCode') ||
        !locationText.containsKey('WindSpeed')) {
      return Center(
        child: CircularProgressIndicator(),
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
                    SizedBox(height: 8),
                    Text(
                      weatherCode2String(locationText['WeatherCode']),
                      textAlign: TextAlign.center),
                    SizedBox(height: 4),
                    BoxedIcon(
                      weatherCode2Icon(locationText['WeatherCode']),
                      size: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
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