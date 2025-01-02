import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:solutech/models/habit.dart';

List<Habit> getTasksForSelectedDate(
    List<Habit> habits, Rx<DateTime> selectedDate) {
  return habits.where((habit) {
    DateTime createdAt = habit.createdAt?.toDate() ?? DateTime.now();

    // Handle isDaily habits: Always appear on every date
    if (habit.isDaily == true) {
      // Check if the habit was already completed today
      DateTime? lastCompleted = habit.lastCompletedOn?.toDate();
      if (lastCompleted != null &&
          lastCompleted.year == selectedDate.value.year &&
          lastCompleted.month == selectedDate.value.month &&
          lastCompleted.day == selectedDate.value.day) {
        habit.isCompleted = true; // Keep completed status
      } else {
        habit.isCompleted = false; // Reset status for a new day
      }
      return true;
    }

    // Handle isWeekly habits: Appear on the same weekday as the creation date
    if (habit.isWeekly == true &&
        createdAt.weekday == selectedDate.value.weekday) {
      // Check if the habit was already completed this week
      DateTime? lastCompleted = habit.lastCompletedOn?.toDate();
      if (lastCompleted != null &&
          lastCompleted.year == selectedDate.value.year &&
          lastCompleted.month == selectedDate.value.month &&
          lastCompleted.day == selectedDate.value.day) {
        habit.isCompleted = true; // Keep completed status
      } else {
        habit.isCompleted = false; // Reset status for a new week
      }
      return true;
    }

    // Handle regular habits: Appear only on their creation date
    return createdAt.year == selectedDate.value.year &&
        createdAt.month == selectedDate.value.month &&
        createdAt.day == selectedDate.value.day;
  }).toList();
}
