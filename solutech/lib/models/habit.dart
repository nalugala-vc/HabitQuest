import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
  Map<Timestamp, bool>? completionStatus;

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
    this.completionStatus,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic>? convertedCompletionStatus;
    if (completionStatus != null) {
      convertedCompletionStatus = {};
      completionStatus!.forEach((key, value) {
        // Convert Timestamp to DateTime and then format it
        String formattedKey = DateFormat('yyyyMMdd').format(key.toDate());

        // Store the value with the formatted date as the key
        convertedCompletionStatus![formattedKey] = value;
      });
    }
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
      'completionStatus': convertedCompletionStatus,
    };
  }

  factory Habit.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Helper function to safely convert to Timestamp
    Timestamp? toTimestamp(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value;
      if (value is String) {
        try {
          // Convert string to DateTime and then to Timestamp
          return Timestamp.fromDate(DateTime.parse(value));
        } catch (e) {
          print('Error converting string to Timestamp: $e');
          return null;
        }
      }
      return null;
    }

    // Handle completionStatus conversion
    Map<Timestamp, bool>? completionStatus;
    if (data['completionStatus'] != null) {
      try {
        completionStatus =
            (data['completionStatus'] as Map<dynamic, dynamic>).map(
          (key, value) => MapEntry(
            key is Timestamp ? key : toTimestamp(key) ?? Timestamp.now(),
            value as bool,
          ),
        );
      } catch (e) {
        print('Error converting completionStatus: $e');
        completionStatus = {};
      }
    }

    return Habit(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isDaily: data['isDaily'] ?? false,
      isWeekly: data['isWeekly'] ?? false,
      hasReminder: data['hasReminder'] ?? false,
      reminderTime: data['reminderTime']?.toString(),
      createdBy: data['createdBy']?.toString() ?? '',
      createdAt: toTimestamp(data['createdAt']) ?? Timestamp.now(),
      completionStatus: completionStatus,
    );
  }
}
