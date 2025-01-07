import 'package:flutter/material.dart';
import 'package:solutech/home/mobile/create_habit.dart';
import 'package:solutech/home/web/create_habit_web.dart';
import 'package:solutech/models/habit.dart';

class CreateHabit extends StatelessWidget {
  final Habit? habit;
  const CreateHabit({super.key, this.habit});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return CreateHabitWeb(
            habit: habit,
          );
        } else {
          return CreateHabitMobile(
            habit: habit,
          );
        }
      },
    );
  }
}
