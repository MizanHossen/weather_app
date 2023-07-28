import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var num = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getRequest();
  }

  Future<void> getRequest() async {
    Dio dio = Dio();

    try {
      var response =
          await dio.get("https://jsonplaceholder.typicode.com/posts");

      if (response == 200) {
        print("HTTP Url: ${response.requestOptions.method}");
        print("HTTP Url: ${response.requestOptions.baseUrl}");
        print("HTTP Url: ${response.requestOptions.path}");
        print("HTTP Status code : ${response.statusCode}");
        print("HTTP Status Meggage : ${response.statusMessage}");
        var myData = response.data as List;
      }
    } catch (e) {
      print(e);
    }
  }
}
