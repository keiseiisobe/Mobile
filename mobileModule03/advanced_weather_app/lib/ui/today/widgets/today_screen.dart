import 'package:flutter/material.dart';
import '../../searchbar/view_model/searchbar_viewmodel.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';

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
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Today"),
          Text(locationText.toString()),
        ],
      ),
    );
  }
}