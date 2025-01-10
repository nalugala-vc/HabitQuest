import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz_data.initializeTimeZones();

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> scheduleNotification(
      {required String title,
      required String message,
      required TimeOfDay reminderTime}) async {
    final now = DateTime.now();
    final reminderDateTime = DateTime(
        now.year, now.month, now.day, reminderTime.hour, reminderTime.minute);
    final notificationTime = reminderDateTime.subtract(Duration(minutes: 5));

    final scheduledTime = tz.TZDateTime.from(notificationTime, tz.local);
    int notificationId = 0;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId++,
      title,
      message,
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_reminders_channel', // Channel ID
          'Habit Reminders',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: 'Habit Reminder',
    );
  }
}
