import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/home_controller.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key, this.isSelected});
  bool? isSelected;

  var cilcious = [
    "29°C",
    "32°C",
    "40°C",
    "28°C",
    "29°C",
    "30°C",
    "32°C",
    "37°C",
  ];

  var img = [
    "assets/img2.png",
    "assets/thunder_img.png",
    "assets/img2.png",
    "assets/thunder_img.png",
    "assets/img2.png",
    "assets/thunder_img.png",
    "assets/img2.png",
    "assets/thunder_img.png",
  ];
  var img_1 = [
    "assets/img2.png",
    "assets/thunder_img.png",
    "assets/img2.png",
    "assets/thunder_img.png",
    "assets/img2.png",
    "assets/thunder_img.png",
    "assets/img2.png",
    "assets/thunder_img.png",
  ];

  var time = [
    "12:00",
    "02:00",
    "72:00",
    "12:00",
    "52:00",
    "12:00",
    "12:00",
    "52:00",
  ];
  var date = [
    "Sep, 13",
    "Sep, 14",
    "Sep, 15",
    "Sep, 16",
    "Sep, 17",
    "Sep, 18",
    "Sep, 19",
    "Sep, 20",
  ];

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    // print(
    //     "Length::: ${homeController.weatherDataModel.value.forecast!.forecastday.length}");
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
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 16,
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

                      // **********************************************
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
                                      CustomText(
                                        txt: "Today",
                                        textColor: Colors.white,
                                        fs: 30,
                                        fw: FontWeight.bold,
                                        lspace: 0.0,
                                      ),
                                      const Spacer(),
                                      CustomText(
                                        txt: homeController.formatDate(
                                            homeController.weatherDataModel
                                                .value.location!.localtime
                                                .toString()),
                                        textColor: Colors.white,
                                        fs: 25,
                                        fw: FontWeight.w300,
                                        lspace: 0.0,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    //flex: 5,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      //itemCount: img.length,
                                      itemCount: homeController
                                          .weatherDataModel
                                          .value
                                          .forecast!
                                          .forecastday![0]
                                          .hour!
                                          .length,
                                      itemBuilder: (context, index) {
                                        var hourItem = homeController
                                            .weatherDataModel
                                            .value
                                            .forecast!
                                            .forecastday![0]
                                            .hour![index];

                                        String dateTimeString = hourItem.time!;
                                        DateTime dateTime =
                                            DateTime.parse(dateTimeString);
                                        // ignore: unused_local_variable
                                        String time =
                                            "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                                        // ignore: avoid_print
                                        print(
                                            "Length :: ${homeController.weatherDataModel.value.forecast!.forecastday![0].hour!.length}");

                                        // ignore: avoid_print
                                        print(
                                            "Https:${hourItem.condition!.icon}---------------------");
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 138,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              // border: Border.all(
                                              //   width: 1,
                                              //   color: Colors.white,
                                              // ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  hourItem.tempC.toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Image.network(
                                                  "Https:${hourItem.condition!.icon}",
                                                  height: 40,
                                                ),
                                                Text(
                                                  hourItem.time!.substring(
                                                      (hourItem.time!.length) -
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
                      // **********************************************

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  CustomText(
                                    txt: "Next Forecast",
                                    textColor: Colors.white,
                                    fs: 22,
                                    fw: FontWeight.bold,
                                    lspace: 0.0,
                                  ),
                                  const Spacer(),
                                  const Icon(
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
                                .forecast!.forecastday!.length,
                            itemBuilder: (_, index) {
                              return index != 0
                                  ? ListTile(
                                      leading: Text(
                                        homeController.formatDate(homeController
                                            .weatherDataModel
                                            .value
                                            .forecast!
                                            .forecastday![index]
                                            .date
                                            .toString()),
                                        //date[index],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w200,
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                      title: Image.network(
                                        "Https:${homeController.weatherDataModel.value.forecast!.forecastday![index].day!.condition!.icon}",
                                        height: 40,
                                      ),
                                      trailing: Text(
                                        homeController
                                            .weatherDataModel
                                            .value
                                            .forecast!
                                            .forecastday![index]
                                            .day!
                                            .maxtempC
                                            .toString(),
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

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    required this.txt,
    required this.textColor,
    required this.fs,
    required this.fw,
    required this.lspace,
  });

  String txt;
  Color textColor;
  double fs;
  FontWeight fw;
  double lspace;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: GoogleFonts.dmSans(
        color: textColor,
        fontSize: fs,
        fontWeight: fw,
        letterSpacing: lspace,
      ),
    );
  }
}
