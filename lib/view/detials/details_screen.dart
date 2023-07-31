import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xff47BFDF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // **********************************************
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: SizedBox(
                  //  height: 40,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child:
              // ),
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
                                txt: "Sep, 12",
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
                              itemCount: img.length,
                              itemBuilder: (_, index) {
                                return Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 138,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
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
                                              cilcious[index],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w200,
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Image.asset(
                                              img[index],
                                              height: 40,
                                            ),
                                            Text(
                                              time[index],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w200,
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
                    itemCount: cilcious.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: Text(
                          date[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        title: Image.asset(
                          img_1[index],
                          height: 40,
                        ),
                        trailing: Text(
                          cilcious[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
