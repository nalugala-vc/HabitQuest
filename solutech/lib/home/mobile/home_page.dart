import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/common/widgets/bottom_nav_bar.dart';

import 'package:solutech/home/controller/habit_controller.dart';
import 'package:solutech/home/mobile/widgets/daily_summary.dart';
import 'package:solutech/home/mobile/widgets/habit_card_list.dart';
import 'package:solutech/home/mobile/widgets/timeline_view.dart';
import 'package:solutech/models/habit.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  final HabitController habitController = Get.find();

  var selectedDate = Rx<DateTime>(DateTime.now());

  List<Habit> getTasksForSelectedDate(List<Habit> habits) {
    return habits.where((habit) {
      DateTime createdAt = habit.createdAt?.toDate() ?? DateTime.now();

      // Handle isDaily habits: Always appear on every date
      if (habit.isDaily == true) {
        // Check if the habit was already completed today
        DateTime? lastCompleted = habit.lastCompletedOn?.toDate();
        if (lastCompleted != null &&
            lastCompleted.year == selectedDate.value.year &&
            lastCompleted.month == selectedDate.value.month &&
            lastCompleted.day == selectedDate.value.day) {
          habit.isCompleted = true; // Keep completed status
        } else {
          habit.isCompleted = false; // Reset status for a new day
        }
        return true;
      }

      // Handle isWeekly habits: Appear on the same weekday as the creation date
      if (habit.isWeekly == true &&
          createdAt.weekday == selectedDate.value.weekday) {
        // Check if the habit was already completed this week
        DateTime? lastCompleted = habit.lastCompletedOn?.toDate();
        if (lastCompleted != null &&
            lastCompleted.year == selectedDate.value.year &&
            lastCompleted.month == selectedDate.value.month &&
            lastCompleted.day == selectedDate.value.day) {
          habit.isCompleted = true; // Keep completed status
        } else {
          habit.isCompleted = false; // Reset status for a new week
        }
        return true;
      }

      // Handle regular habits: Appear only on their creation date
      return createdAt.year == selectedDate.value.year &&
          createdAt.month == selectedDate.value.month &&
          createdAt.day == selectedDate.value.day;
    }).toList();
  }

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
                  final tasksForSelectedDate = habits.where((habit) {
                    DateTime createdAt =
                        habit.createdAt?.toDate() ?? DateTime.now();

                    if (habit.isDaily == true) {
                      return true;
                    }

                    if (habit.isWeekly == true &&
                        createdAt.weekday == selectedDate.value.weekday) {
                      return true;
                    }

                    return createdAt.year == selectedDate.value.year &&
                        createdAt.month == selectedDate.value.month &&
                        createdAt.day == selectedDate.value.day;
                  }).toList();

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
