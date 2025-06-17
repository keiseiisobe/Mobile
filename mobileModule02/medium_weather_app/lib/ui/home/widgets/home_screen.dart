import 'package:flutter/material.dart';
import '../../topbar/widgets/topbar_screen.dart';
import '../../currently/widgets/currently_screen.dart';
import '../../today/widgets/today_screen.dart';
import '../../weekly/widgets/weekly_screen.dart';
import '../../bottombar/widgets/bottombar_screen.dart';
import '../../searchbar/view_model/searchbar_viewmodel.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final SearchController searchController;
  late GeolocationViewModel geolocationViewModel;
  late SearchbarViewmodel searchbarViewmodel;
  //late final Future<Position> geoLocation;
  late final Future<String> citiesData;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    searchController = SearchController();
    searchbarViewmodel = SearchbarViewmodel(
      isSearchLocationEnabled: false,
      searchController: searchController,
    );  
    geolocationViewModel = GeolocationViewModel(
      isGeoLocationEnabled: false,
      geolocationText: Text(""),
    );
    //geoLocation = determinePosition();
    //citiesData = rootBundle.loadString('assets/cities.csv');
  }

  @override
  void dispose() {
    tabController.dispose();  
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,  
        flexibleSpace: TopbarScreen(
          tabController: tabController,
          searchbarViewmodel: searchbarViewmodel,
          geolocationViewModel: geolocationViewModel,
        ),
      ),
      body: SafeArea(
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),  
          child: ListenableBuilder(
            listenable: geolocationViewModel,
            builder: (context, _) {
              return ListenableBuilder(
                listenable: searchbarViewmodel,
                builder: (context, _) {
                  return TabBarView(
                    controller: tabController,
                    children: [
                      CurrentlyScreen(
                        searchViewModel: searchbarViewmodel,
                        geolocationViewModel: geolocationViewModel
                      ),
                      TodayScreen(
                        searchViewModel: searchbarViewmodel,  
                        geolocationViewModel: geolocationViewModel,
                      ),
                      WeeklyScreen(
                        searchViewModel: searchbarViewmodel,  
                        geolocationViewModel: geolocationViewModel,
                      ),
                    ],
                  );
                }
              );
            }
          ),
        ),
      ),
      bottomNavigationBar: BottomBarScreen(tabController: tabController),
    );
  }
}