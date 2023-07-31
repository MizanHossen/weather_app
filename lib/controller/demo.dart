// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// void main()async {
//   // Get the current location
//   Position position = await Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.high,
//   );

//   // Get the latitude and longitude of the current location
//   double latitude = position.latitude;
//   double longitude = position.longitude;

//   // Convert the latitude and longitude to a list of placemarks
//   List<Placemark> placemarks = await Geocoder.local.findAddressesFromCoordinates(
//     Coordinates(latitude, longitude),
//   );

//   // Get the first placemark in the list
//   Placemark placemark = placemarks.first;

//   // Print the location name
//   print(placemark.name);
// }