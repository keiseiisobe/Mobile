import 'package:flutter/material.dart';
import '../../searchbar/widgets/searchbar_screen.dart';
import '../../geolocation/widgets/geolocation_screen.dart';
import '../../geolocation/view_model/geolocation_viewmodel.dart';

class TopbarScreen extends StatelessWidget {
  const TopbarScreen({
    super.key,
    required this.tabController,
    required this.searchController,
    required this.geolocationViewModel,
  });

  final TabController tabController;
  final TextEditingController searchController;
  final GeolocationViewModel geolocationViewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TabBar(
        controller: tabController,  
        tabAlignment: TabAlignment.start,  
        labelPadding: EdgeInsets.only(top: 8),
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelColor: Colors.transparent,
        unselectedLabelColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        mouseCursor: SystemMouseCursors.basic,
        tabs: [
          SearchbarScreen(
            searchController: searchController
          ),
          VerticalDivider(
            color: Theme.of(context).colorScheme.onPrimary,
            indent: 10,
            endIndent: 10,
            width: 0,
          ),
          GeolocationScreen(
            viewModel: geolocationViewModel,
          ),
        ],
      ),
    );
  }
}