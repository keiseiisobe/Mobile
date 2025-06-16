import 'package:flutter/material.dart';

class SearchbarViewmodel extends ChangeNotifier {
  SearchbarViewmodel({
    required this.isSearchLocationEnabled,
    required this.searchController,
    required this.isGeoLocationEnabled,
  });

  bool isSearchLocationEnabled;
  TextEditingController searchController;
  bool isGeoLocationEnabled;

  void toggleSearchLocation() {
    if (!isSearchLocationEnabled) {
      isSearchLocationEnabled = true;
      isGeoLocationEnabled = false;
    }
    notifyListeners(); 
  }
}