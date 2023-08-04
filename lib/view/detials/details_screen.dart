import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    // print(
    //     "Length::: ${homeController.weatherDataModel.value.forecast!.forecastday.length}");
    DateTime now = DateTime.now();
    int currentHour = now.hour;

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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // **********************************************
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //****************************************** Header Section *************************************** */
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      //  size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Back",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.settings,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),

                      //****************************************** Today Details Section *************************************** */
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.25,
                        //flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Today",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        homeController.formatDate(homeController
                                            .weatherDataModel
                                            .value
                                            .location!
                                            .localtime
                                            .toString()),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController
                                          .weatherDataModel
                                          .value
                                          .forecast!
                                          .forecastday[0]
                                          .hour
                                          .length,
                                      itemBuilder: (context, index) {
                                        var hourItem = homeController
                                            .weatherDataModel
                                            .value
                                            .forecast!
                                            .forecastday[0]
                                            .hour[index];

                                        DateTime dateTime =
                                            DateTime.parse(hourItem.time);
                                        int hour = dateTime.hour;

                                        bool isCurrentHour =
                                            currentHour == hour;

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            decoration: BoxDecoration(
                                              color: isCurrentHour
                                                  ? Colors.blue
                                                  : Colors.white
                                                      .withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "${hourItem.tempC}°C",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Image.network(
                                                  "Http:${hourItem.condition.icon}",
                                                  height: 40,
                                                ),
                                                Text(
                                                  hourItem.time.substring(
                                                      (hourItem.time.length) -
                                                          5),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      //****************************************** 7days Details Section *************************************** */

                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text(
                                    "New Forcast",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // **********************************************
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            //itemCount: cilcious.length,
                            itemCount: homeController.weatherDataModel.value
                                .forecast!.forecastday.length,
                            itemBuilder: (_, index) {
                              return index != 0
                                  ? ListTile(
                                      leading: Text(
                                        homeController
                                            .formatDate(homeController
                                                .weatherDataModel
                                                .value
                                                .forecast!
                                                .forecastday[index]
                                                .date
                                                .toString())
                                            .substring(0, 6),
                                        //date[index],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w200,
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      title: Image.network(
                                        "Http:${homeController.weatherDataModel.value.forecast!.forecastday[index].day.condition.icon}",
                                        height: 40,
                                      ),
                                      trailing: Text(
                                        "${homeController.weatherDataModel.value.forecast!.forecastday[index].day.maxtempC}°C",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w200,
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    ));
  }
}
