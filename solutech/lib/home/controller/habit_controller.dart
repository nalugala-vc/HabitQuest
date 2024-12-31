import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:solutech/home/mobile/home_page.dart';
import 'package:solutech/services/habit_services.dart';

class HabitController extends GetxController {
  static HabitController get instance => Get.find();
  final HabitServices _habitServices = HabitServices();

  final title = TextEditingController();
  final description = TextEditingController();
  var isDaily = false.obs;
  var hasReminder = false.obs;
  var reminderTime = Rx<TimeOfDay?>(const TimeOfDay(hour: 10, minute: 0));

  void setReminderTime(TimeOfDay time) {
    reminderTime.value = time;
  }

  void toggleHasReminder(bool value) {
    hasReminder.value = value;
  }

  Future<void> onSave({
    required String title,
    required String description,
    required bool isDaily,
    required bool hasReminder,
    TimeOfDay? reminderTime,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    try {
      final habit = {
        'title': title,
        'description': description,
        'isDaily': isDaily,
        'hasReminder': hasReminder,
        'reminderTime': hasReminder && reminderTime != null
            ? '${reminderTime.hour}:${reminderTime.minute}'
            : null,
        'createdBy': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _habitServices.addHabit(habit);
      Get.to(() => const HomePageMobile());

      Fluttertoast.showToast(
        msg: 'Habit added successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Get.to(() => const HomePageMobile());

      clearFields();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to add habit: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void clearFields() {
    title.clear();
    description.clear();
    isDaily.value = false;
    hasReminder.value = false;
    reminderTime.value = const TimeOfDay(hour: 10, minute: 0);
  }
}
