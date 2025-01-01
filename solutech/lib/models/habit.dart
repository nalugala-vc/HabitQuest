import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModel {
  String id;
  String title;
  String description;
  bool isCompleted;
  String createdBy; // User ID of the creator
  Timestamp createdAt;
  bool hasReminder;
  String reminderTime;
  bool isDaily;

  HabitModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdBy,
    required this.createdAt,
    required this.hasReminder,
    required this.reminderTime,
    required this.isDaily,
  });

  // Convert a Habit object to a Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'hasReminder': hasReminder,
      'reminderTime': reminderTime,
      'isDaily': isDaily,
    };
  }

  // Create a Habit object from a Map (from Firestore)
  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
      createdBy: map['createdBy'],
      createdAt: map['createdAt'],
      hasReminder: map['hasReminder'],
      reminderTime: map['reminderTime'],
      isDaily: map['isDaily'],
    );
  }
}
