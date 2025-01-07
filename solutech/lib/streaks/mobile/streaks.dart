import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:solutech/common/constants.dart';
import 'package:solutech/common/streak_dialogue.dart';
import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/common/widgets/bottom_nav_bar.dart';
import 'package:solutech/home/controller/habit_controller.dart';
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
    final habitController = Get.find<HabitController>();
    habitController.checkAchievements();
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
                  spaceH10,
                  RobotoCondensed(
                    text: 'Your Badges',
                    fontSize: 17,
                  ),
                  spaceH15,
                  Obx(() {
                    final badgesLength = habitController.unlockedBadges.length;
                    final badges = habitController.unlockedBadges;

                    return Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: 164,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: badgesAndNames.length < 4
                                ? badgesAndNames.length
                                : 4, // Limit to 4 badges
                            itemBuilder: (BuildContext context, int index) {
                              final imgURL =
                                  badgesAndNames.keys.elementAt(index);
                              final badgeName =
                                  badgesAndNames.values.elementAt(index);
                              final isUnlocked = badges.contains(badgeName);

                              return AchievementBadgeB(
                                imgURL: imgURL,
                                bgColor: isUnlocked
                                    ? AppColors.purple500
                                    : AppColors.purple100,
                                title: isUnlocked
                                    ? "$badgeName (Unlocked)"
                                    : badgeName,
                                onPressed: () {
                                  streakDialogue(
                                      context: context,
                                      title: badgeName,
                                      isUnlocked: isUnlocked);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                  spaceH15,
                  Obx(() {
                    final badgesLength = habitController.unlockedBadges.length;
                    final badges = habitController.unlockedBadges;

                    return Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: 164,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: badgesAndNames.length >= 9
                                ? 4
                                : 0, // Ensure we have at least 9 items to display index 4 to 8
                            itemBuilder: (BuildContext context, int index) {
                              // Start the index from 4
                              final badgeIndex = index + 4;
                              if (badgeIndex >= badgesAndNames.length)
                                return Container(); // Avoid out-of-bounds error

                              final imgURL =
                                  badgesAndNames.keys.elementAt(badgeIndex);
                              final badgeName =
                                  badgesAndNames.values.elementAt(badgeIndex);
                              final isUnlocked = badges.contains(badgeName);

                              return AchievementBadgeB(
                                imgURL: imgURL,
                                onPressed: () {
                                  streakDialogue(
                                      context: context,
                                      title: badgeName,
                                      isUnlocked: isUnlocked);
                                },
                                bgColor: isUnlocked
                                    ? AppColors.purple500
                                    : AppColors.purple100,
                                title: isUnlocked
                                    ? "$badgeName (Unlocked)"
                                    : badgeName,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                  spaceH15,
                  Obx(() {
                    final badgesLength = habitController.unlockedBadges.length;
                    final badges = habitController.unlockedBadges;

                    return Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: 164,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: badgesAndNames.length >= 12
                                ? 4
                                : 0, // Ensure we have at least 12 items to display index 9 to 11
                            itemBuilder: (BuildContext context, int index) {
                              // Start the index from 9
                              final badgeIndex = index + 8;
                              if (badgeIndex >= badgesAndNames.length)
                                return Container(); // Avoid out-of-bounds error

                              final imgURL =
                                  badgesAndNames.keys.elementAt(badgeIndex);
                              final badgeName =
                                  badgesAndNames.values.elementAt(badgeIndex);
                              final isUnlocked = badges.contains(badgeName);

                              return AchievementBadgeB(
                                imgURL: imgURL,
                                onPressed: () {
                                  streakDialogue(
                                      context: context,
                                      title: badgeName,
                                      isUnlocked: isUnlocked);
                                },
                                bgColor: isUnlocked
                                    ? AppColors.purple500
                                    : AppColors.purple100,
                                title: isUnlocked
                                    ? "$badgeName (Unlocked)"
                                    : badgeName,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                  spaceH15,
                ],
              ))),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
