import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyMainViews extends StatelessWidget {
  const MyMainViews({
    super.key,  
    required this.tabController,
    required this.isGeoLocationEnabled,
    required this.geoLocation,
    required this.isSearchLocationEnabled,
    required this.searchController,
  });

  final TabController tabController;
  final bool isGeoLocationEnabled;
  final Future<Position> geoLocation;
  final bool isSearchLocationEnabled;
  final TextEditingController searchController;
  
  Widget getGeoLocationText(BuildContext context, AsyncSnapshot<Position> snapshot) {
    if (snapshot.hasError) {
      return Text(
        snapshot.error.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        )
      );
    } else if (snapshot.hasData) {
      final position = snapshot.data!;
      return Text("Lat: ${position.latitude}, Lon: ${position.longitude}");
    }
    return CircularProgressIndicator();
  }  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: geoLocation,
      builder: (context, snapshot) {
        return TabBarView(
          controller: tabController,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,  
              children: [
                Text("Currently"),
                isGeoLocationEnabled 
                  ? getGeoLocationText(context, snapshot)
                  : isSearchLocationEnabled 
                    ? Text(searchController.text) 
                    : Text(""),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,  
              children: [
                Text("Today"),  
                isGeoLocationEnabled 
                  ? getGeoLocationText(context, snapshot)
                  : isSearchLocationEnabled 
                    ? Text(searchController.text) 
                    : Text(""),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,  
              children: [
                Text("Weekly"),  
                isGeoLocationEnabled 
                  ? getGeoLocationText(context, snapshot)
                    : isSearchLocationEnabled 
                    ? Text(searchController.text) 
                    : Text(""),
              ],
            ),
          ],
        );
      }
    );
  }
}
