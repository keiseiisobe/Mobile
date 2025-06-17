import 'package:flutter/material.dart';
import '../../../data/repositories/geocoding_repository.dart';
import '../../../data/services/geocoding.dart';

class SearchbarViewmodel extends ChangeNotifier {
  SearchbarViewmodel({
    required this.isSearchLocationEnabled,
    required this.searchController,
  });

  bool isSearchLocationEnabled;
  SearchController searchController;
  List<ListTile> suggestions = [];
  GeocodingRepository geocodingRepository = GeocodingRepository(geocoding: Geocoding());

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

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
  
  List<Widget> updateSuggestions(String query) {
    return [
      FutureBuilder<dynamic>(
        future: geocodingRepository.getSuggestions(query),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ListTile(
              title: Text("Error fetching suggestions"),
            );
          } else if (snapshot.hasData) {
            var result = snapshot.data!;
            if (result.isEmpty) {
              return ListTile();
            } else {
              return ListView(
                children: result.map((item) {
                  var title = item['name'];
                  var subtitle = "${item['admin1']}, ${item['country']}";
                  return ListTile(
                    title: Text(title, style: TextStyle(fontSize: 16)),
                    subtitle: Text(subtitle, style: TextStyle(fontSize: 14)),
                    onTap: () {
                      searchController.closeView(title);
                    },
                  );
                }).toList(),  
              );
            }
          } else {
            return ListTile(
              title: Text("Loading suggestions..."),
            );
          }
        }
      ),
    ];
  }
}