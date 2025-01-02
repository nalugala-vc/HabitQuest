import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/common/widgets/bottom_nav_bar.dart';

import 'package:solutech/home/controller/habit_controller.dart';
import 'package:solutech/home/mobile/widgets/daily_summary.dart';
import 'package:solutech/home/mobile/widgets/habit_card_list.dart';
import 'package:solutech/home/mobile/widgets/timeline_view.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/functions.dart';
import 'package:solutech/utils/spacers.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final HabitController habitController = Get.find();

  var selectedDate = Rx<DateTime>(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
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

                  final tasksForSelectedDate =
                      getTasksForSelectedDate(habits, selectedDate);

                  final completedTasks = tasksForSelectedDate
                      .where((habit) => habit.isCompleted == true)
                      .length;
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
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
