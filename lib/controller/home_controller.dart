import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/constant.dart';
import 'package:weather_app/models/location_data_model.dart';

class HomeController extends GetxController {
  var num = 1.obs;

  Position? position;

  @override
  void onInit() {
    super.onInit();

    // getRequest();
    // getCurrentLocation();
    getCurrentLocation();

    getForcastData();
  }

  //**************************** Date formet ********************** */
  String formatDate(String dateString) {
    // Parse the input date string into a DateTime object
    DateTime date = DateTime.parse(dateString);

    // Define the date format you want to use
    DateFormat formatter = DateFormat('dd MMMM yyyy');

    // Format the DateTime object into a string
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  //****************************** Get Data ************************ */
  var locationName = "".obs;
  var isLoading = false.obs;
  RxObjectMixin<LocationDataModel> locationDataModel = LocationDataModel().obs;

  void getForcastData() async {
    isLoading.value = true;
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

      // print("Latitude: $latitude");
      // print("Longitude: $longitude");

      locationName.value = await getLocationName(latitude, longitude);
      // print("Location Name: $locationName");
      // print("get current locaiton end");

      // ignore: unnecessary_null_comparison
      if (locationName != null) {
        Dio dio = Dio();

        try {
          // print("Dio called");
          // print(
          //     "Main ----------------------------lOcaiton nnnn ${locationName.value}");
          var response = await dio.get(Constants.weatherUrl, queryParameters: {
            "key": "5a2a4bbdb7a1432bae555712233007",
            //"q": locationName.value.toString(),
            "q": locationName.value,
            "aqi": "no",
          });

          if (response.statusCode == 200) {
            // print("HTTP Url: ${response.requestOptions.method}");
            // print("HTTP Url: ${response.requestOptions.baseUrl}");
            // print("HTTP Url: ${response.requestOptions.path}");
            // print("HTTP Status code : ${response.statusCode}");
            // print("HTTP Status Meggage : ${response.statusMessage}");
            // // ignore: unused_local_variable
            //var myData = response.data as List;

            locationDataModel.value = LocationDataModel.fromJson(response.data);
            isLoading.value = false;

            // print(locationDataModel.value.location!.country);
          }
        } catch (e) {
          // ignore: unnecessary_brace_in_string_interps, avoid_print
          print("errorrrrrrreeeeeeee ${e}");
        }
      } else {
        // ignore: avoid_print
        print("Location name null");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error getting current position: $e");
    }
  }

  //************************* Get current location********************* */

  getCurrentLocation() async {
    await Geolocator.requestPermission();
    //  await Geolocator.openAppSettings();
    //await Geolocator.openLocationSettings();
    // ignore: unused_element, no_leading_underscores_for_local_identifiers
    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can

      return await Geolocator.getCurrentPosition();
    }
  }

  ////************************ Get location name***************** */

  Future<String> getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks.first;
        String address =
            '${firstPlacemark.name}, ${firstPlacemark.locality}, ${firstPlacemark.country}';
        return address;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error getting location name: $e');
    }
    return 'Unknown location';
  }
}

// New API Key: 5a2a4bbdb7a1432bae555712233007
