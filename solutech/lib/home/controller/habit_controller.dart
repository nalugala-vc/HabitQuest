import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:solutech/core/controller/base_controller.dart';
import 'package:solutech/home/mobile/home_page.dart';
import 'package:solutech/models/habit.dart';

class HabitController extends BaseController {
  static HabitController get instance => Get.find();

  final user = FirebaseAuth.instance.currentUser;

  var habits = <Habit>[].obs;

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

      setBusy(true);

      final snapshot = await FirebaseFirestore.instance
          .collection('habits')
          .where('createdBy', isEqualTo: user!.uid)
          .get();

      habits.value =
          snapshot.docs.map((doc) => Habit.fromDocument(doc)).toList();

      setBusy(false);
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

      habits.removeWhere((habit) => habit.id == habitId);
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

  Future<void> updateHabit({
    required Habit habit,
  }) async {
    print('created At ${habit.createdAt} createdBy ${habit.createdBy} ');
    try {
      Map<String, dynamic> updateData = {
        'title': habit.title,
        'description': habit.description,
        'isDaily': habit.isDaily,
        'hasReminder': habit.hasReminder,
        'isCompleted': habit.isCompleted,
        'createdAt': habit.createdAt,
        'createdBy': habit.createdBy,
      };

      if (habit.hasReminder == true && habit.reminderTime != null) {
        updateData['reminderTime'] = habit.reminderTime;
      } else {
        updateData['reminderTime'] = null;
      }

      await FirebaseFirestore.instance
          .collection('habits')
          .doc(habit.id)
          .update(updateData);

      final index =
          habits.indexWhere((existingHabit) => existingHabit.id == habit.id);
      if (index != -1) {
        habits[index] = habit;
        habits.refresh();
      }

      Fluttertoast.showToast(
        msg: "Habit updated successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      clearFields();
    } catch (e) {
      print("Error updating habit: $e"); // Add this for debugging
      clearFields();
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

  void setHabitValues(Habit? habit) {
    if (habit != null) {
      title.text = habit.title;
      description.text = habit.description;
      isDaily.value = habit.isDaily ?? false;
      hasReminder.value = habit.hasReminder ?? false;

      final rawReminderTime = habit.reminderTime;
      print('Raw reminder time string: "$rawReminderTime"');

      if (rawReminderTime != null) {
        try {
          final timeStr = rawReminderTime.trim();
          final timeParts = timeStr.split(' ');
          final time = timeParts[0].split(':');
          final period = timeParts[1].toUpperCase();

          int hour = int.parse(time[0]);
          final int minute = int.parse(time[1]);

          if (period == 'PM' && hour != 12) {
            hour += 12;
          } else if (period == 'AM' && hour == 12) {
            hour = 0;
          }

          reminderTime.value = TimeOfDay(hour: hour, minute: minute);
          print(
              "Reminder time set: ${reminderTime.value?.format(Get.context!)}");
        } catch (e) {
          print("Error parsing reminder time: $e");
          reminderTime.value = null;
        }
      } else {
        reminderTime.value = null;
      }
    }
  }

  Future<void> updateHabitCompletion(String habitId, bool isCompleted) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance
          .collection('habits')
          .doc(habitId)
          .update({
        'isCompleted': isCompleted,
      });

      final index = habits.indexWhere((habit) => habit.id == habitId);
      if (index != -1) {
        habits[index].isCompleted = isCompleted;
        habits.refresh();
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
      final habit = Habit(
        title: title,
        description: description,
        isCompleted: false,
        isDaily: isDaily,
        hasReminder: hasReminder,
        reminderTime: hasReminder && reminderTime != null
            ? reminderTime.format(Get.context!)
            : null,
        createdBy: user!.uid,
        createdAt: Timestamp.fromMillisecondsSinceEpoch(0),
      );

      await FirebaseFirestore.instance.collection('habits').add({
        ...habit.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      fetchHabits();

      clearFields();

      Fluttertoast.showToast(
        msg: 'Habit added successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Get.off(() => const HomePageMobile());
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

  //heat map
  Map<DateTime, int> calculateCompletionCounts(List<Habit> habits) {
    final Map<DateTime, int> completionCounts = {};

    for (final habit in habits) {
      final date = DateTime(
        habit.createdAt!.toDate().year,
        habit.createdAt!.toDate().month,
        habit.createdAt!.toDate().day,
      );

      if (habit.isCompleted) {
        completionCounts[date] = (completionCounts[date] ?? 0) + 1;
      }
    }

    return completionCounts;
  }
}
