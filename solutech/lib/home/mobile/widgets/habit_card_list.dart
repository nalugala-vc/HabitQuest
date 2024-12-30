import 'package:flutter/material.dart';
import 'package:solutech/home/mobile/widgets/habit_card.dart';
import 'package:solutech/utils/spacers.dart';

class HabitCardList extends StatelessWidget {
  final DateTime selectedDate;
  const HabitCardList({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => spaceH15,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => HabitCard(
        date: selectedDate,
        title: 'Habit ${index.toString()}',
        isCompleted: index % 2 == 0,
        progress: 4,
        streak: 6,
        habitId: index.toString(),
      ),
      itemCount: 5,
    );
  }
}
