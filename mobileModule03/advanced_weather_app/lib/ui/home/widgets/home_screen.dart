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
  late final Future<String> citiesData;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (geolocationViewModel.isGeoLocationEnabled) {
        geolocationViewModel.updateWeatherDisplay();
      } else if (searchbarViewmodel.isSearchLocationEnabled) {
        searchbarViewmodel.updateWeatherDisplay();
      }
    });
    searchController = SearchController();
    searchbarViewmodel = SearchbarViewmodel(
      isSearchLocationEnabled: false,
      searchController: searchController,
      tabController: tabController,
    );  
    geolocationViewModel = GeolocationViewModel(
      isGeoLocationEnabled: false,
      tabController: tabController,
    );
  }

  @override
  void dispose() {
    tabController.dispose();  
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,  
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: TopbarScreen(
            tabController: tabController,
            searchbarViewmodel: searchbarViewmodel,
            geolocationViewModel: geolocationViewModel,
          ),
        ),
        body: SafeArea(
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
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
        bottomNavigationBar: BottomBarScreen(
          tabController: tabController
        ),
      ),
    );
  }
}