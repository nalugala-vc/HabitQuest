import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:solutech/home/controller/habit_controller.dart';
import 'package:solutech/home/mobile/widgets/habit_card.dart';
import 'package:solutech/utils/spacers.dart';

class HabitCardList extends StatefulWidget {
  final DateTime selectedDate;
  const HabitCardList({super.key, required this.selectedDate});

  @override
  State<HabitCardList> createState() => _HabitCardListState();
}

class _HabitCardListState extends State<HabitCardList> {
  final HabitController habitController = Get.find();

  @override
  void initState() {
    super.initState();
    habitController.fetchHabits();
  }

  void checkBoxTapped(bool? value, int index) {
    final habit = habitController.habits[index];
    final habitId = habit['id'];
    final isCompleted = value ?? false;

    habitController.updateHabitCompletion(habitId, isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Watch for changes in the habit list
      if (habitController.habits.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return ListView.separated(
        separatorBuilder: (context, index) => spaceH15,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: habitController.habits.length,
        itemBuilder: (context, index) {
          final habit = habitController.habits[index];
          return HabitCard(
            date: widget.selectedDate,
            onChanged: (value) {
              checkBoxTapped(value, index);
            },
            title: "${habit['title']},${habit['isCompleted']} ",
            isCompleted: habit['isCompleted'],
            progress: 4,
            streak: 6,
            habitId: index.toString(),
          );
        },
      );
    });
  }
}
