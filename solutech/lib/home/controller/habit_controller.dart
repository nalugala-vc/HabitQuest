import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:solutech/core/controller/base_controller.dart';
import 'package:solutech/home/mobile/home_page.dart';
import 'package:solutech/models/habit.dart';
import 'package:intl/intl.dart';

class HabitController extends BaseController {
  static HabitController get instance => Get.find();

  final user = FirebaseAuth.instance.currentUser;

  var habits = <Habit>[].obs;
  final datasets = <DateTime, int>{}.obs;

  var unlockedBadges = <String>[].obs;

  final title = TextEditingController();
  final description = TextEditingController();
  var isDaily = false.obs;
  var isWeekly = false.obs;
  var hasReminder = false.obs;

  var reminderTime = Rx<TimeOfDay?>(const TimeOfDay(hour: 10, minute: 0));

  @override
  void onInit() {
    super.onInit();
    fetchHabits();
    initializeBadges();
  }

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
      print(
        "Failed to fetch habit: $e",
      );
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

  Future<void> updateHabit({required Habit habit}) async {
    try {
      // Get the data to update
      Map<String, dynamic> updateData = habit.toMap();

      // Remove the id field as it shouldn't be updated
      updateData.remove('id');

      // Handle reminder time
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
      print("Error updating habit: $e");
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
      isWeekly.value = habit.isWeekly ?? false;
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

  Future<void> updateHabitCompletion(
    String habitId,
    DateTime completedOn,
    bool isCompleted,
  ) async {
    try {
      final formattedDate = DateFormat('yyyyMMdd').format(completedOn);
      final timestampKey = Timestamp.fromDate(DateTime(
        int.parse(formattedDate.substring(0, 4)), // year
        int.parse(formattedDate.substring(4, 6)), // month
        int.parse(formattedDate.substring(6, 8)), // day
      ));

      final habitDoc = await FirebaseFirestore.instance
          .collection('habits')
          .doc(habitId)
          .get();

      final currentStatus =
          habitDoc.data()?['completionStatus']?[formattedDate] ?? false;

      final newStatus =
          formattedDate == DateFormat('yyyyMMdd').format(DateTime.now())
              ? !currentStatus
              : isCompleted;

      final updateData = {
        'completionStatus.$formattedDate': newStatus,
      };

      await FirebaseFirestore.instance
          .collection('habits')
          .doc(habitId)
          .update(updateData);

      final index = habits.indexWhere((habit) => habit.id == habitId);
      if (index != -1) {
        habits[index].lastCompletedOn = Timestamp.fromDate(completedOn);
        if (habits[index].completionStatus == null) {
          habits[index].completionStatus = {};
        }
        habits[index].completionStatus![timestampKey] = newStatus;
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
    required bool isWeekly,
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
        completionStatus: {},
        isDaily: isDaily,
        isWeekly: isWeekly,
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
      print(
        "Failed to add habit: $e",
      );
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
    isWeekly.value = false;
    hasReminder.value = false;
    reminderTime.value = const TimeOfDay(hour: 10, minute: 0);
  }

// Initialize all badges as locked (false)
  void initializeBadges() {
    unlockedBadges.clear();
  }

  Future<void> checkAchievements() async {
    Map<DateTime, bool> consecutiveDays =
        {}; // Track consecutive days for streaks

    // Track longest streak
    int currentStreak = 0;
    int maxStreak = 0;
    DateTime? prevDate;

    // Loop through each habit's completion status
    for (var habit in habits) {
      if (habit.completionStatus != null) {
        habit.completionStatus!.forEach((timestamp, isCompleted) {
          if (isCompleted) {
            final date = timestamp.toDate();

            print('date $date');

            if (!consecutiveDays.containsKey(date)) {
              consecutiveDays[date] = true;
            }

            // Calculate streaks
            if (prevDate != null && date.difference(prevDate!).inDays == 1) {
              currentStreak++;
            } else {
              currentStreak = 1;
            }
            maxStreak = currentStreak > maxStreak ? currentStreak : maxStreak;
            prevDate = date;
          }
        });
      }
    }

    // Helper function to unlock a badge
    void unlockBadge(String badgeTitle) {
      if (!unlockedBadges.contains(badgeTitle)) {
        unlockedBadges.add(badgeTitle);
      }
    }

    // Check streak-based achievements
    if (maxStreak >= 1) unlockBadge("DAY ONE DONE");
    if (maxStreak >= 3) unlockBadge("TRIPLE THREAT");
    if (maxStreak >= 5) unlockBadge("HIGH FIVE");
    if (maxStreak >= 7) unlockBadge("WEEKLY WARRIOR");
    if (maxStreak >= 10) unlockBadge("PERFECT TEN");
    if (maxStreak >= 15) unlockBadge("FIFTEEN FORTITUDE");
    if (maxStreak >= 20) unlockBadge("TWENTY TROOPER");
    if (maxStreak >= 30) unlockBadge("MONTHLY MARVEL");

    int totalTasksCompleted = 0;
    for (var habit in habits) {
      totalTasksCompleted +=
          habit.completionStatus?.values.where((status) => status).length ?? 0;
    }

    if (totalTasksCompleted >= 3) unlockBadge("TRIPLE TRIUMPH");
    if (totalTasksCompleted >= 10) unlockBadge("TENACIOUS TEN");
    if (totalTasksCompleted >= 30) unlockBadge("THIRTY THRIVER");
    if (totalTasksCompleted >= 100) unlockBadge("HABIT HERO");
  }
}
