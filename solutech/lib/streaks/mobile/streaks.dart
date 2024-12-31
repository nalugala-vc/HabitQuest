import 'package:flutter/material.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/spacers.dart';

class StreaksMobile extends StatelessWidget {
  const StreaksMobile({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imgURL = [
      "assets/images/badge1.png",
      "assets/images/badge2.png",
      "assets/images/badge3.png",
      "assets/images/badge4.png",
      "assets/images/badge5.png",
      "assets/images/badge6.png",
      "assets/images/badge7.png",
      "assets/images/badge8.png",
      "assets/images/badge9.png",
      "assets/images/badge10.png",
      "assets/images/badge11.png",
      "assets/images/badge12.png",
      "assets/images/badge13.png",
      "assets/images/badge14.png",
      "assets/images/BADGE-BG1.png",
      "assets/images/BADGE-BG2.png",
      "assets/images/BADGE-BG3.png",
      "assets/images/BADGE-BG4.png",
    ];

    List<String> imgURL2 = [
      "assets/images/badge12.png",
      "assets/images/badge13.png",
      "assets/images/badge14.png",
      "assets/images/badge11.png",
    ];

    List<String> imgURL4 = [
      "assets/images/badge12.png",
      "assets/images/badge13.png",
      "assets/images/badge14.png",
      "assets/images/badge11.png",
    ];

    List<String> title1 = [
      "SUPER SAVER",
      "BUDGET PRO",
      "AMBASSADOR",
      "PREMIUM",
    ];
    List<String> title2 = [
      "INSURE GENIUS",
      "INVESTMENT WHIZ",
      "ESTATE PLANNER",
      "BASIC",
    ];

    List<String> title3 = [
      "UZASHOPPER",
      "INVESTMENT WHIZ",
      "LIFELONG LEARNER",
      "PREMIUM",
    ];

    List<String> imgURL3 = [
      "assets/images/BADGE-BG1.png",
      "assets/images/BADGE-BG2.png",
      "assets/images/BADGE-BG3.png",
      "assets/images/BADGE-BG4.png",
    ];

    List<Color> backgroundColor = [
      AppColors.greenAchieve,
      AppColors.blueAchieve,
      AppColors.greyAchieve,
      AppColors.yellowAchieve,
    ];

    List<Color> titleColor = [
      AppColors.greenAchieveTitle,
      AppColors.blueAchieveTitle,
      AppColors.greyAchieveTitle,
      AppColors.yellowAchieveTitle,
    ];

    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backButtonWithLabel(
                      label: 'StreaksMobile',
                    ),
                    spaceH30,
                    SizedBox(
                      width: double.maxFinite,
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imgURL.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AchievementBadgeA(
                            imgURL: imgURL[index],
                          );
                        },
                      ),
                    ),
                    spaceH15,
                    SizedBox(
                      width: double.maxFinite,
                      height: 164,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: title1.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AchievementBadgeB(
                            imgURL: imgURL2[index],
                            bgColor: Colors.transparent,
                            title: title1[index],
                          );
                        },
                      ),
                    ),
                    spaceH15,
                    SizedBox(
                      width: double.maxFinite,
                      height: 164,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: title1.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AchievementBadgeB(
                            imgURL: imgURL3[index],
                            bgColor: Colors.transparent,
                            title: title2[index],
                          );
                        },
                      ),
                    ),
                    spaceH15,
                    SizedBox(
                      width: double.maxFinite,
                      height: 164,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: title1.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AchievementBadgeB(
                            imgURL: imgURL4[index],
                            bgColor: backgroundColor[index],
                            titleColor: titleColor[index],
                            title: title3[index],
                          );
                        },
                      ),
                    ),
                  ],
                ))));
  }
}
