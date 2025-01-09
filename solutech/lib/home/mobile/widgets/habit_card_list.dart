import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/common/empty_state.dart';
import 'package:solutech/common/error_dialogue.dart';
import 'package:solutech/common/widgets/confirm_dialogue.dart';
import 'package:solutech/home/controller/habit_controller.dart';
import 'package:solutech/home/create_habit.dart';
import 'package:solutech/home/mobile/widgets/habit_card.dart';
import 'package:solutech/models/habit.dart';
import 'package:solutech/utils/spacers.dart';
import 'package:intl/intl.dart';

class HabitCardList extends StatefulWidget {
  final Rx<DateTime> selectedDate;
  const HabitCardList({super.key, required this.selectedDate});

  @override
  State<HabitCardList> createState() => _HabitCardListState();
}

class _HabitCardListState extends State<HabitCardList> {
  final HabitController habitController = Get.find();

  void checkBoxTapped(
      bool? value, int index, List<Habit> tasksForSelectedDate) {
    final habit = tasksForSelectedDate[index];
    final habitId = habit.id;
    final isCompleted = value ?? false;

    if (widget.selectedDate.value.toString().split(' ')[0] !=
        DateTime.now().toString().split(' ')[0]) {
      errorDialogue(context: context, isCompleted: isCompleted);
      return;
    }

    habitController.updateHabitCompletion(
        habitId!, DateTime.now(), isCompleted);
  }

  void editHabit(Habit habit, int index) {
    Get.to(() => CreateHabit(
          habit: habit,
        ));
  }

  void deleteHabit(int index, List<Habit> tasksForSelectedDate) {
    confirmDialogue(
      context: context,
      icon: 'assets/images/delete-file.png',
      label: 'Delete',
      message: 'Are you sure you want to delete this habit ?',
      onConfirm: () {
        final habit = tasksForSelectedDate[index];
        final habitId = habit.id;
        habitController.deleteHabit(habitId!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final habits = habitController.habits;
      final tasksForSelectedDate = habits.where((habit) {
        DateTime createdAt = habit.createdAt?.toDate() ?? DateTime.now();
        final selectedDate = widget.selectedDate.value;

        // For daily habits, check if created before or on selected date
        if (habit.isDaily == true) {
          return createdAt.isAtSameMomentAs(selectedDate) ||
              (createdAt.isBefore(selectedDate.add(const Duration(days: 1))) &&
                  createdAt.day <= selectedDate.day);
        }

        // For weekly habits, check created date and weekday match
        if (habit.isWeekly == true &&
            selectedDate.weekday == createdAt.weekday &&
            (createdAt.isBefore(selectedDate) ||
                createdAt.isAtSameMomentAs(selectedDate))) {
          return true;
        }

        // For one-time habits, check exact date match
        return createdAt.year == selectedDate.year &&
            createdAt.month == selectedDate.month &&
            createdAt.day == selectedDate.day;
      }).toList();

      if (tasksForSelectedDate.isEmpty) {
        return const EmptyStateWidget(
          message: 'No habits found for the selected date',
        );
      }

      return ListView.separated(
        separatorBuilder: (context, index) => spaceH15,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tasksForSelectedDate.length,
        itemBuilder: (context, index) {
          final habit = tasksForSelectedDate[index];
          final selectedDateFormatted =
              DateFormat('yyyyMMdd').format(widget.selectedDate.value);
          final timestampKey = Timestamp.fromDate(DateTime(
            int.parse(selectedDateFormatted.substring(0, 4)),
            int.parse(selectedDateFormatted.substring(4, 6)),
            int.parse(selectedDateFormatted.substring(6, 8)),
          ));

          final isCompleted = habit.completionStatus?[timestampKey] ?? false;

          return HabitCard(
            deleteTapped: (context) => deleteHabit(index, tasksForSelectedDate),
            editTapped: (context) => editHabit(habit, index),
            date: widget.selectedDate.value,
            onChanged: (value) =>
                checkBoxTapped(value, index, tasksForSelectedDate),
            title: habit.title,
            isCompleted: isCompleted,
            progress: 4,
            description: habit.description,
            habitId: index.toString(),
          );
        },
      );
    });
  }
}
