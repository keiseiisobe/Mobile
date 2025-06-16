import 'package:flutter/material.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';

class CurrentlyScreen extends StatelessWidget {
  const CurrentlyScreen({
    super.key,
    required this.searchController,
    required this.geolocationViewModel,
  });

  final TextEditingController searchController;
  final GeolocationViewModel geolocationViewModel;

  @override
  Widget build(BuildContext context) {
    var locationText = "";
    if (geolocationViewModel.isGeoLocationEnabled) {
      locationText = geolocationViewModel.geolocationText;
    } else if (searchController.text.isNotEmpty) {
      locationText = searchController.text;
    }
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,  
      children: [
        Text("Currently"),
        Text(locationText),
      ],
    );
  }
}