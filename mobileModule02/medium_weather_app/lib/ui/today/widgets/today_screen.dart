import 'package:flutter/material.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({
    super.key,
    required this.geolocationViewModel,
  });

  final GeolocationViewModel geolocationViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Today"),
        geolocationViewModel.getGeoLocationText(),
      ],
    );
  }
}