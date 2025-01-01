import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String? id;
  String title;
  String description;
  bool isCompleted;
  String? createdBy;
  Timestamp? createdAt;
  bool? hasReminder;
  String? reminderTime;
  bool? isDaily;

  Habit({
    required this.title,
    required this.description,
    this.createdBy,
    this.createdAt,
    this.isCompleted = false,
    this.id,
    this.hasReminder,
    this.reminderTime,
    this.isDaily,
  });

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

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
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

  factory Habit.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Habit(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      isDaily: data['isDaily'] ?? false,
      hasReminder: data['hasReminder'] ?? false,
      reminderTime: data['reminderTime'],
      createdBy: data['createdBy'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}
