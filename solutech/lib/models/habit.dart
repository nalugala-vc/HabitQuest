import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  String? id;
  String title;
  String description;
  String? createdBy;
  Timestamp? createdAt;
  bool? hasReminder;
  String? reminderTime;
  bool? isDaily;
  bool? isWeekly;
  Timestamp? completedOn;
  Timestamp? lastCompletedOn;
  int? weeklyDay;
  Map<Timestamp, bool>? completionStatus; // Tracks completion status per date

  Habit({
    required this.title,
    required this.description,
    this.createdBy,
    this.createdAt,
    this.id,
    this.hasReminder,
    this.reminderTime,
    this.isDaily,
    this.isWeekly,
    this.lastCompletedOn,
    this.weeklyDay,
    this.completedOn,
    this.completionStatus, // Initialize the new field
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'hasReminder': hasReminder,
      'reminderTime': reminderTime,
      'isDaily': isDaily,
      'isWeekly': isWeekly,
      'completedOn': completedOn,
      'lastCompletedOn': lastCompletedOn,
      'weeklyDay': weeklyDay,
      'completionStatus': completionStatus, // Add to serialization
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdBy: map['createdBy'],
      createdAt: map['createdAt'],
      hasReminder: map['hasReminder'],
      reminderTime: map['reminderTime'],
      isDaily: map['isDaily'],
      isWeekly: map['isWeekly'],
      completedOn: map['completedOn'],
      lastCompletedOn: map['lastCompletedOn'],
      weeklyDay: map['weeklyDay'],
      completionStatus:
          Map<Timestamp, bool>.from(map['completionStatus'] ?? {}),
    );
  }

  factory Habit.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Habit(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isDaily: data['isDaily'] ?? false,
      isWeekly: data['isWeekly'] ?? false,
      hasReminder: data['hasReminder'] ?? false,
      reminderTime: data['reminderTime'],
      createdBy: data['createdBy'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      completedOn: data['completedOn'],
      lastCompletedOn: data['lastCompletedOn'],
      weeklyDay: data['weeklyDay'],
      completionStatus:
          Map<Timestamp, bool>.from(data['completionStatus'] ?? {}),
    );
  }
}
