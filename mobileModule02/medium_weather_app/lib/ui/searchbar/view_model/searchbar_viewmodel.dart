import 'package:flutter/material.dart';

class SearchbarViewmodel extends ChangeNotifier {
  SearchbarViewmodel({
    required this.isSearchLocationEnabled,
    required this.searchController,
  });

  bool isSearchLocationEnabled;
  TextEditingController searchController;

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
}