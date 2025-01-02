import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:solutech/home/controller/habit_controller.dart';
import 'package:solutech/streaks/widgets/completed_task_dialogue_box.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    final habitController = Get.find<HabitController>();

    // Make sure dataset generation happens once, avoid repeating this call
    Future.delayed(Duration.zero, () => _generateHeatmapData(habitController));

    return Obx(() {
      return HeatMap(
        datasets: habitController.datasets.value,
        defaultColor: Colors.grey.shade300,
        startDate: DateTime.now().subtract(const Duration(days: 40)),
        size: 25,
        endDate: DateTime.now().add(const Duration(days: 30)),
        colorMode: ColorMode.opacity,
        showText: false,
        scrollable: true,
        colorsets: const {
          1: Color.fromARGB(20, 156, 39, 176),
          2: Color.fromARGB(40, 156, 39, 176),
          3: Color.fromARGB(60, 156, 39, 176),
          4: Color.fromARGB(80, 156, 39, 176),
          5: Color.fromARGB(100, 156, 39, 176),
          6: Color.fromARGB(120, 156, 39, 176),
          7: Color.fromARGB(150, 156, 39, 176),
          8: Color.fromARGB(180, 156, 39, 176),
          9: Color.fromARGB(220, 156, 39, 176),
          10: Color.fromARGB(255, 156, 39, 176),
        },
        onClick: (value) {
          final completedTasks = habitController.datasets[value] ?? 0;
          final formattedDate =
              '${_getDayOfWeek(value)} ${value.day} ${_getMonth(value)} ${value.year}';

          completedTaskDialogue(
              completedTasks: completedTasks,
              context: context,
              formattedDate: formattedDate);
        },
      );
    });
  }

  void _generateHeatmapData(HabitController habitController) {
    final datasets = <DateTime, int>{}.obs;

    final habits = habitController.habits;
    final now = DateTime.now();

    for (var habit in habits) {
      // Check if habit has completion status
      if (habit.completionStatus != null) {
        habit.completionStatus!.forEach((timestamp, isCompleted) {
          if (isCompleted) {
            final date = timestamp.toDate();

            // If the habit was completed on this date, increment the count
            if (datasets.containsKey(date)) {
              datasets[date] = datasets[date]! + 1;
            } else {
              datasets[date] = 1;
            }
          }
        });
      }
    }

    // Update the datasets in the controller
    habitController.datasets.value = datasets;
  }

  String _getDayOfWeek(DateTime date) {
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return weekdays[date.weekday - 1];
  }

  String _getMonth(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[date.month - 1];
  }
}
