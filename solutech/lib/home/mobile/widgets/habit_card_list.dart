import 'package:flutter/material.dart';
import 'package:solutech/home/mobile/widgets/habit_card.dart';
import 'package:solutech/utils/spacers.dart';

class HabitCardList extends StatefulWidget {
  final DateTime selectedDate;
  const HabitCardList({super.key, required this.selectedDate});

  @override
  State<HabitCardList> createState() => _HabitCardListState();
}

class _HabitCardListState extends State<HabitCardList> {
  List todayHabitList = [
    ["Morning Run", false],
    ["Read Book", false],
    ["Wake up early", false],
    ["Drink water", false]
  ];
  bool habitCompleted = false;

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todayHabitList[index][1] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => spaceH15,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => HabitCard(
        date: widget.selectedDate,
        onChanged: (value) => checkBoxTapped(value, index),
        title: todayHabitList[index][0],
        isCompleted: todayHabitList[index][1],
        progress: 4,
        streak: 6,
        habitId: index.toString(),
      ),
      itemCount: todayHabitList.length,
    );
  }
}
