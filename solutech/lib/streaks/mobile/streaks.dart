import 'package:flutter/material.dart';
import 'package:solutech/common/constants.dart';
import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/common/widgets/bottom_nav_bar.dart';
import 'package:solutech/streaks/widgets/achievement_badge_a.dart';
import 'package:solutech/streaks/widgets/achievement_badge_b.dart';
import 'package:solutech/streaks/widgets/heat_map.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class StreaksMobile extends StatelessWidget {
  const StreaksMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH20,
                  RobotoCondensed(
                    text: 'My Progress',
                    fontSize: 20,
                  ),
                  spaceH10,
                  const MyHeatMap(),
                  spaceH20,
                  RobotoCondensed(
                    text: 'Unlock Badges With every Achievement!',
                    fontSize: 20,
                  ),
                  spaceH20,
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
                  RobotoCondensed(
                    text: 'Your Badges',
                    fontSize: 17,
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
                          bgColor: AppColors.purple100,
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
                          bgColor: AppColors.purple100,
                          title: title2[index],
                        );
                      },
                    ),
                  ),
                  spaceH15,
                ],
              ))),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
