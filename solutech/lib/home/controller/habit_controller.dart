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

  final user = FirebaseAuth.instance.currentUser;

  var habits = <Map<String, dynamic>>[].obs;

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

  Future<void> fetchHabits() async {
    try {
      if (user == null) return;

      final snapshot = await FirebaseFirestore.instance
          .collection('habits')
          .where('createdBy', isEqualTo: user!.uid)
          .get();

      habits.value = snapshot.docs
          .map((doc) => {
                'id': doc.id,
                'title': doc['title'],
                'isCompleted': doc['isCompleted'],
                'description': doc['description'],
                'isDaily': doc['isDaily'],
                'hasReminder': doc['hasReminder'],
                'reminderTime': doc['reminderTime'],
                'createdAt': doc['createdAt'],
              })
          .toList();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to fetch habit: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> deleteHabit(String habitId) async {
    try {
      if (user == null) {
        Fluttertoast.showToast(
          msg: "User not logged in",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('habits')
          .doc(habitId)
          .delete();

      habits.removeWhere((habit) => habit['id'] == habitId);
      habits.refresh();

      Fluttertoast.showToast(
        msg: "Habit deleted successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to delete habit: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> updateHabitCompletion(String habitId, bool isCompleted) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Update the Firestore document
      await FirebaseFirestore.instance
          .collection('habits')
          .doc(habitId)
          .update({
        'isCompleted': isCompleted,
      });

      // Manually update the local `habits` list
      final index = habits.indexWhere((habit) => habit['id'] == habitId);
      if (index != -1) {
        habits[index]['isCompleted'] = isCompleted; // Update completion locally
        habits.refresh(); // Refresh the list to trigger UI updates
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to update habit: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> onSave({
    required String title,
    required String description,
    required bool isDaily,
    required bool hasReminder,
    TimeOfDay? reminderTime,
  }) async {
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
        'isCompleted': false,
        'reminderTime': hasReminder && reminderTime != null
            ? '${reminderTime.hour}:${reminderTime.minute}'
            : null,
        'createdBy': user!.uid,
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
