import 'package:flutter/material.dart';
import '../../searchbar/view_model/searchbar_viewmodel.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';

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
    var locationText = Text("");
    if (geolocationViewModel.isGeoLocationEnabled) {
      locationText = geolocationViewModel.geolocationText;
    } else if (searchViewModel.isSearchLocationEnabled) {
      locationText = Text(searchViewModel.searchController.text);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Weekly"),
        locationText,
      ],
    );
  }
}