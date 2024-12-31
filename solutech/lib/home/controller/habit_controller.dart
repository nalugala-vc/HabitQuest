import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HabitController extends GetxController {
  static HabitController get instance => Get.find();

  final title = TextEditingController();
  final description = TextEditingController();
  var isDaily = false.obs;
  var hasReminder = false.obs;
  var reminderTime = Rx<TimeOfDay?>(const TimeOfDay(hour: 10, minute: 0));

  void setReminderTime(TimeOfDay time) {
    reminderTime.value = time; // No need to call update() here
  }

  void toggleHasReminder(bool value) {
    hasReminder.value = value; // No need to call update() here
  }
}
