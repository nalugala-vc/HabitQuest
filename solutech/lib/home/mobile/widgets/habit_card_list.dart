import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:solutech/common/empty_state.dart';
import 'package:solutech/common/widgets/confirm_dialogue.dart';
import 'package:solutech/home/controller/habit_controller.dart';
import 'package:solutech/home/create_habit.dart';
import 'package:solutech/home/mobile/widgets/habit_card.dart';
import 'package:solutech/models/habit.dart';
import 'package:solutech/utils/spacers.dart';

class HabitCardList extends StatefulWidget {
  final Rx<DateTime> selectedDate;
  const HabitCardList({super.key, required this.selectedDate});

  @override
  State<HabitCardList> createState() => _HabitCardListState();
}

class _HabitCardListState extends State<HabitCardList> {
  final HabitController habitController = Get.find();

  List<Habit> getTasksForSelectedDate(List<Habit> habits) {
    return habits.where((habit) {
      DateTime createdAt = habit.createdAt?.toDate() ?? DateTime.now();

      // Handle isDaily habits: Always appear on every date
      if (habit.isDaily == true) {
        // Check if the habit was already completed today
        DateTime? lastCompleted = habit.lastCompletedOn?.toDate();
        if (lastCompleted != null &&
            lastCompleted.year == widget.selectedDate.value.year &&
            lastCompleted.month == widget.selectedDate.value.month &&
            lastCompleted.day == widget.selectedDate.value.day) {
          habit.isCompleted = true; // Keep completed status
        } else {
          habit.isCompleted = false; // Reset status for a new day
        }
        return true;
      }

      // Handle isWeekly habits: Appear on the same weekday as the creation date
      if (habit.isWeekly == true &&
          createdAt.weekday == widget.selectedDate.value.weekday) {
        // Check if the habit was already completed this week
        DateTime? lastCompleted = habit.lastCompletedOn?.toDate();
        if (lastCompleted != null &&
            lastCompleted.year == widget.selectedDate.value.year &&
            lastCompleted.month == widget.selectedDate.value.month &&
            lastCompleted.day == widget.selectedDate.value.day) {
          habit.isCompleted = true; // Keep completed status
        } else {
          habit.isCompleted = false; // Reset status for a new week
        }
        return true;
      }

      // Handle regular habits: Appear only on their creation date
      return createdAt.year == widget.selectedDate.value.year &&
          createdAt.month == widget.selectedDate.value.month &&
          createdAt.day == widget.selectedDate.value.day;
    }).toList();
  }

  void checkBoxTapped(
      bool? value, int index, List<Habit> tasksForSelectedDate) {
    final habit = tasksForSelectedDate[index];
    final habitId = habit.id;
    final isCompleted = value ?? false;

    if (habit.isDaily == true || habit.isWeekly == true) {
      // Update only the last completed date without marking it permanently completed
      habitController.updateLastCompletedOn(habitId!, DateTime.now());
    } else {
      habitController.updateHabitCompletion(habitId!, isCompleted);
    }
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

        if (habit.isDaily == true) {
          return true;
        }

        if (habit.isWeekly == true &&
            createdAt.weekday == widget.selectedDate.value.weekday) {
          return true;
        }

        return createdAt.year == widget.selectedDate.value.year &&
            createdAt.month == widget.selectedDate.value.month &&
            createdAt.day == widget.selectedDate.value.day;
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
          return HabitCard(
            deleteTapped: (context) => deleteHabit(index, tasksForSelectedDate),
            editTapped: (context) => editHabit(habit, index),
            date: widget.selectedDate.value,
            onChanged: (value) =>
                checkBoxTapped(value, index, tasksForSelectedDate),
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
