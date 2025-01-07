import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/common/widgets/nav_bar.dart';
import 'package:solutech/home/controller/habit_controller.dart';
import 'package:solutech/home/mobile/widgets/daily_summary.dart';
import 'package:solutech/home/mobile/widgets/habit_card_list.dart';
import 'package:solutech/home/mobile/widgets/timeline_view.dart';
import 'package:solutech/streaks/web/streaks_web.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class HomepageWeb extends StatefulWidget {
  const HomepageWeb({super.key});

  @override
  State<HomepageWeb> createState() => _HomepageWebState();
}

class _HomepageWebState extends State<HomepageWeb> {
  final HabitController habitController = Get.find();

  @override
  void initState() {
    super.initState();
    habitController.checkAchievements();
  }

  var selectedDate = Rx<DateTime>(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          NavBar(),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TimelineView(
                    selectedDate: selectedDate.value,
                    onSelectedDateChanged: (date) => selectedDate.value = date,
                  ),
                  spaceH20,
                  Obx(() {
                    // Filter tasks for the selected date inside Obx
                    final habits = habitController.habits;

                    final tasksForSelectedDate = habits.where((habit) {
                      DateTime createdAt =
                          habit.createdAt?.toDate() ?? DateTime.now();
                      final newselectedDate = selectedDate.value;

                      // For daily habits, check if created before or on selected date
                      if (habit.isDaily == true) {
                        return createdAt.isAtSameMomentAs(newselectedDate) ||
                            (createdAt.isBefore(newselectedDate
                                    .add(const Duration(days: 1))) &&
                                createdAt.day <= newselectedDate.day);
                      }

                      // For weekly habits, check created date and weekday match
                      if (habit.isWeekly == true &&
                          newselectedDate.weekday == createdAt.weekday &&
                          (createdAt.isBefore(newselectedDate) ||
                              createdAt.isAtSameMomentAs(newselectedDate))) {
                        return true;
                      }

                      // For one-time habits, check exact date match
                      return createdAt.year == newselectedDate.year &&
                          createdAt.month == newselectedDate.month &&
                          createdAt.day == newselectedDate.day;
                    }).toList();

                    final completedTasks = tasksForSelectedDate.where((habit) {
                      return habit.completionStatus?.entries.any((entry) {
                            final entryDate = entry.key.toDate();
                            return entryDate.year == selectedDate.value.year &&
                                entryDate.month == selectedDate.value.month &&
                                entryDate.day == selectedDate.value.day &&
                                entry.value == true;
                          }) ??
                          false;
                    }).length;
                    final totalTasks = tasksForSelectedDate.length;

                    return DailySummary(
                      completedTasts: completedTasks,
                      date: selectedDate.value.toString().split(' ')[0],
                      totalTasks: totalTasks,
                    );
                  }),
                  spaceH15,
                  RobotoCondensed(
                    text: 'My Habits',
                    fontSize: 18,
                  ),
                  spaceH15,
                  HabitCardList(selectedDate: selectedDate),
                ],
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: VerticalDivider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Expanded(flex: 6, child: StreaksWeb()),
        ],
      ),
    ));
  }
}
