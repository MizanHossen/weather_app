import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/constant.dart';
import '../models/weather_data_model.dart';

class HomeController extends GetxController {
  var num = 1.obs;

  Position? position;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    getForcastData();
  }

  //**************************** Date formet ********************** */
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd MMMM ');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  void main() {
    String dateTimeString = "2023-08-03 00:00";
    DateTime dateTime = DateTime.parse(dateTimeString);
    String time =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    // ignore: avoid_print
    print(time); // Output: 00:00
  }

  //****************************** Get Data ************************ */
  var locationName = "".obs;
  var isLoading = false.obs;
  RxObjectMixin<WeatherDataModel> weatherDataModel = WeatherDataModel().obs;
  // RxObjectMixin<LocationDataModel> locationDataModel = LocationDataModel().obs;

  void getForcastData() async {
    isLoading.value = true;
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;
      String name = await getLocationName(latitude, longitude);
      locationName.value = name;

      // ignore: unnecessary_null_comparison
      if (locationName.value != null) {
        Dio dio = Dio();
        try {
          var response = await dio.get(Constants.weatherUrl, queryParameters: {
            "key": "5a2a4bbdb7a1432bae555712233007",
            "q": locationName.value,
            "aqi": "no",
            "days": "7",
            "alerts": "no"
          });

          if (response.statusCode == 200) {
            print("HTTP Url: ${response.requestOptions.method}");
            print("HTTP Url: ${response.requestOptions.baseUrl}");
            print("HTTP Url: ${response.requestOptions.path}");
            print("HTTP Status code : ${response.statusCode}");
            print("HTTP Status Meggage : ${response.statusMessage}");
            // ignore: unused_local_variable

            weatherDataModel.value = WeatherDataModel.fromJson(response.data);
            isLoading.value = false;
            // ignore: avoid_print
            print(weatherDataModel.value.forecast!.forecastday.length);
          }
        } catch (e) {
          // ignore: unnecessary_brace_in_string_interps, avoid_print
          print("Error---- ${e}");
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
  Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission();

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
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
