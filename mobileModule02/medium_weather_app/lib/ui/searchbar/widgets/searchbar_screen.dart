import 'package:flutter/material.dart';
import '../view_model/searchbar_viewmodel.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';
import '../../../data/repositories/geocoding_repository.dart';
import '../../../data/services/geocoding.dart';

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
                    controller.openView();
                  },
                ),
                onTap: () {
                  controller.openView();
                },
              );
            },
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              return searchbarViewmodel.updateSuggestions(controller.text);
            },
            viewLeading: BackButton(
              color: Theme.of(context).colorScheme.primary, 
            ),
            viewOnChanged: (value) {
              searchbarViewmodel.notifyListeners();
            },
          
          // TextField(
          //   controller: searchbarViewmodel.searchController,
          //   style: TextStyle(
          //     color: Theme.of(context).colorScheme.onPrimary,
          //   ),
          //   cursorColor: Theme.of(context).colorScheme.onPrimary,
          //   decoration: InputDecoration(
          //     hintText: "Search location...",
          //     hintStyle: TextStyle(color: Theme.of(context).colorScheme.primaryContainer),
          //     border: InputBorder.none,
          //     prefixIcon: Icon(Icons.search),
          //     prefixIconColor: Theme.of(context).colorScheme.primaryContainer,
          //     counterText: "",
          //   ),
          //   maxLength: 100,  
          //   onSubmitted: (value) {
          //     searchbarViewmodel.toggleSearchLocation();  
          //     geolocationViewModel.disableGeoLocation();
          //   },
          );
        }
      ),
    );
  }
}