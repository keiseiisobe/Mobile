import 'package:flutter/material.dart';
import '../view_model/searchbar_viewmodel.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';

class SearchbarScreen extends StatelessWidget {

  const SearchbarScreen({
    super.key,
    required this.searchbarViewmodel,
    required this.geolocationViewModel,
  });

  final SearchbarViewmodel searchbarViewmodel;
  final GeolocationViewModel geolocationViewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      alignment: Alignment.bottomLeft,
      child: ListenableBuilder(
        listenable: searchbarViewmodel,
        builder: (context, _) {
          return SearchAnchor(
            searchController: searchbarViewmodel.searchController,  
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),
                shadowColor: WidgetStateProperty.all(Colors.transparent),
                textStyle: WidgetStateProperty.all(
                  TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                hintText: "Search location...",
                hintStyle: WidgetStateProperty.all(
                  TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    searchbarViewmodel.toggleSearchLocation();
                    geolocationViewModel.disableGeoLocation();  
                    controller.openView();
                  },
                ),
                onTap: () {
                  searchbarViewmodel.toggleSearchLocation();
                  geolocationViewModel.disableGeoLocation();  
                  controller.openView();
                },
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) async {
              return await searchbarViewmodel.updateSuggestions(controller.text);
            },
            viewLeading: BackButton(
              color: Theme.of(context).colorScheme.primary, 
            ),
            viewOnChanged: (value) {
              searchbarViewmodel.notifyListeners();
            },
            viewOnSubmitted: (value) {
              searchbarViewmodel.toggleSearchLocation();
              geolocationViewModel.disableGeoLocation();
              searchbarViewmodel.searchController.closeView(value);
            },
          );
        }
      ),
    );
  }
}