import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/home_controller.dart';
import 'package:weather_app/view/detials/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final HomeController homeController = Get.put(HomeController());

    //homeController.getForcastData();
    final size = MediaQuery.sizeOf(context);
    //  String time = ;
    return Scaffold(
        body: Obx(
      // ignore: unrelated_type_equality_checks
      () => homeController.isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/home_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/map.png", height: 30),
                          const SizedBox(width: 5),
                          Text(
                            homeController.weatherDataModel.value.location!.name
                                .toString(),
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.expand_more,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          Image.asset("assets/notification.png", height: 30),
                        ],
                      ),
                      const SizedBox(height: 50),

                      Image.asset("assets/img2.png"),
                      // Image.network(
                      //     "${homeController.locationDataModel.value.current!.condition.icon}"),
                      const SizedBox(height: 40),

                      //*************************************** Weather Info************************** */
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(),
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          //height: size.height,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff80C4F4),
                            border: Border.all(
                              color: const Color(0xffFFFFFF),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                homeController.formatDate(homeController
                                    .weatherDataModel.value.location!.localtime
                                    .toString()),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    homeController
                                        .weatherDataModel.value.current!.tempC
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    "o",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                homeController.weatherDataModel.value.current!
                                    .condition!.text
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              WeatherInfoCard(
                                title: "Wind",
                                image: "assets/windy.png",
                                metter:
                                    "${homeController.weatherDataModel.value.current!.windKph} %",
                              ),
                              const SizedBox(height: 10),
                              WeatherInfoCard(
                                title: "Hum",
                                image: "assets/hum.png",
                                metter:
                                    "${homeController.weatherDataModel.value.current!.humidity} %",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    ));
  }
}

class WeatherInfoCard extends StatelessWidget {
  final String image;
  final String title;
  final String metter;
  const WeatherInfoCard({
    super.key,
    required this.image,
    required this.title,
    required this.metter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(image),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "|",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  metter,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )

          // const SizedBox(width: 5),

          //  const SizedBox(width: 5),
        ],
      ),
    );
  }
}
