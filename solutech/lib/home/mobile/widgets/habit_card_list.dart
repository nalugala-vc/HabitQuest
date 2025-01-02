import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/common/error_dialogue.dart';
import 'package:solutech/common/widgets/confirm_dialogue.dart';
import 'package:solutech/home/controller/habit_controller.dart';
import 'package:solutech/home/create_habit.dart';
import 'package:solutech/home/mobile/widgets/habit_card.dart';
import 'package:solutech/models/habit.dart';
import 'package:solutech/utils/functions.dart';
import 'package:solutech/utils/spacers.dart';

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
      // Show feedback if the selected date is not today
      errorDialogue(context: context, isCompleted: isCompleted);
      return;
    }

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
      final tasksForSelectedDate =
          getTasksForSelectedDate(habits, widget.selectedDate);

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
