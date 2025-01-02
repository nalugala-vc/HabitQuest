import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:solutech/home/controller/habit_controller.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    final habitController = Get.find<HabitController>();

    return Obx(() {
      return HeatMap(
        datasets: habitController.datasets.value, // Use `.value` here
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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      );
    });
  }
}
