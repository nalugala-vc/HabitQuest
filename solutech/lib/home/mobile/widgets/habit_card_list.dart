import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:solutech/common/widgets/confirm_dialogue.dart';
import 'package:solutech/home/controller/habit_controller.dart';
import 'package:solutech/home/create_habit.dart';
import 'package:solutech/home/mobile/widgets/habit_card.dart';
import 'package:solutech/models/habit.dart';
import 'package:solutech/utils/spacers.dart';

class HabitCardList extends StatefulWidget {
  final DateTime selectedDate;
  const HabitCardList({super.key, required this.selectedDate});

  @override
  State<HabitCardList> createState() => _HabitCardListState();
}

class _HabitCardListState extends State<HabitCardList> {
  final HabitController habitController = Get.find();

  List<Habit> getTasksForSelectedDate(List<Habit> habits) {
    return habits.where((habit) {
      DateTime createdAt = habit.createdAt?.toDate() ?? DateTime.now();

      return createdAt.year == widget.selectedDate.year &&
          createdAt.month == widget.selectedDate.month &&
          createdAt.day == widget.selectedDate.day;
    }).toList();
  }

  void checkBoxTapped(
      bool? value, int index, List<Habit> tasksForSelectedDate) {
    final habit = tasksForSelectedDate[index];
    final habitId = habit.id;
    final isCompleted = value ?? false;

    habitController.updateHabitCompletion(habitId!, isCompleted);
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
      // Watch for changes in the habit list
      if (habitController.habits.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      final habits = habitController.habits;

      // Filter tasks for the selected date
      final tasksForSelectedDate = getTasksForSelectedDate(habits);

      return ListView.separated(
        separatorBuilder: (context, index) => spaceH15,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tasksForSelectedDate.length,
        itemBuilder: (context, index) {
          final habit = tasksForSelectedDate[index];
          return HabitCard(
            deleteTapped: (context) => deleteHabit(index, tasksForSelectedDate),
            editTapped: (context) => editHabit(habit, index),
            date: widget.selectedDate,
            onChanged: (value) {
              checkBoxTapped(value, index, tasksForSelectedDate);
            },
            title: habit.title,
            isCompleted: habit.isCompleted,
            progress: 4,
            streak: 6,
            habitId: index.toString(),
          );
        },
      );
    });
  }
}
