import 'package:flutter/material.dart';
import '../view_model/geolocation_viewmodel.dart';
import '../../searchbar/view_model/searchbar_viewmodel.dart';

class GeolocationScreen extends StatelessWidget {
  const GeolocationScreen({
    super.key,
    required this.geolocationViewModel,
    required this.searchbarViewmodel,
  });

  final GeolocationViewModel geolocationViewModel;
  final SearchbarViewmodel searchbarViewmodel;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {
          geolocationViewModel.toggleGeoLocation();  
          searchbarViewmodel.disableSearchLocation();
        },
        icon: Icon(
          Icons.near_me,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        constraints: BoxConstraints.expand(),
      ),
    );
  }
}

// Widget getGeoLocationText(BuildContext context, AsyncSnapshot<Position> snapshot) {
//     if (snapshot.hasError) {
//       return Text(
//         snapshot.error.toString(),
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Theme.of(context).colorScheme.error,
//         )
//       );
//     } else if (snapshot.hasData) {
//       final position = snapshot.data!;
//       return Text("Lat: ${position.latitude}, Lon: ${position.longitude}");
//     }
//     return CircularProgressIndicator();
//   }  


  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the 
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale 
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
    
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately. 
  //     return Future.error(
  //       'Location permissions are permanently denied, we cannot request permissions.');
  //   } 

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition();
  // }
