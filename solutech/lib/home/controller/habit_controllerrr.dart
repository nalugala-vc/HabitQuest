// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:solutech/home/mobile/home_page.dart';
// import 'package:solutech/models/habit.dart';

// class HabitController extends GetxController {
//   static HabitController get instance => Get.find();

//   final user = FirebaseAuth.instance.currentUser;

//   var habits = <Habit>[].obs;

//   final title = TextEditingController();
//   final description = TextEditingController();
//   var isDaily = false.obs;
//   var hasReminder = false.obs;
//   var reminderTime = Rx<TimeOfDay?>(const TimeOfDay(hour: 10, minute: 0));
//   final habitBox = Hive.box<Habit>('Habit_quest_Database');
//   RxBool isSyncing = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     syncData();
//   }

//   Future<void> syncData() async {
//     // Check if the device is online
//     final isOnline = await _checkConnectivity();

//     if (isOnline) {
//       await fetchFromFirebase(); // Fetch from Firebase and sync to Hive
//     } else {
//       fetchFromHive(); // Fetch from local Hive database
//     }
//   }

//   Future<void> fetchFromFirebase() async {
//     if (user == null) return;

//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('habits')
//           .where('createdBy', isEqualTo: user!.uid)
//           .get();

//       final firebaseHabits =
//           snapshot.docs.map((doc) => Habit.fromDocument(doc)).toList();

//       // Update Hive
//       for (var habit in firebaseHabits) {
//         habitBox.put(habit.id, habit);
//       }

//       habits.value = firebaseHabits;
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed to fetch habit From Firebase: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   void fetchFromHive() {
//     final localHabits = habitBox.values.toList();
//     habits.value = localHabits;
//   }

//   Future<bool> _checkConnectivity() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "No active internet connection: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//       return false;
//     }
//   }

//   Future<void> onSave({
//     required String title,
//     required String description,
//     required bool isDaily,
//     required bool hasReminder,
//     TimeOfDay? reminderTime,
//   }) async {
//     if (user == null) {
//       Get.snackbar("Error", "User not logged in");
//       return;
//     }
//     try {
//       final createdAt = Timestamp.fromDate(DateTime.now());

//       final habit = Habit(
//         title: title,
//         description: description,
//         isCompleted: false,
//         isDaily: isDaily,
//         hasReminder: hasReminder,
//         reminderTime: hasReminder && reminderTime != null
//             ? reminderTime.format(Get.context!)
//             : null,
//         createdBy: user!.uid,
//         createdAt: createdAt,
//       );

//       habits.add(habit);
//       habitBox.put(habit.id, habit); 

//       final isOnline = await _checkConnectivity();
//       if (isOnline) {
//         await FirebaseFirestore.instance.collection('habits').add({
//           ...habit.toMap(),
//           'createdAt': FieldValue.serverTimestamp(),
//         });

//         fetchHabits();
//       } else {
//         _queueForSync(habit, action: 'add');
//       }

//       clearFields();

//       Fluttertoast.showToast(
//         msg: 'Habit added successfully',
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );

//       Get.off(() => const HomePageMobile());
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed to add habit: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   Future<void> deleteHabit(String habitId) async {
//     try {
//       if (user == null) {
//         Fluttertoast.showToast(
//           msg: "User not logged in",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.TOP,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//         return;
//       }

//       // Remove habit locally
//       final habit = habits.firstWhere((habit) => habit.id == habitId);
//       habits.remove(habit);
//       habits.refresh();

//       final isOnline = await _checkConnectivity();
//       if (isOnline) {
//         await FirebaseFirestore.instance
//             .collection('habits')
//             .doc(habitId)
//             .delete();
//       } else {
//         _queueForSync(
//           Habit(
//             id: habitId,
//             title: habit.title,
//             description: habit.description,
//             isCompleted: habit.isCompleted,
//             hasReminder: habit.hasReminder ?? false,
//             reminderTime: habit.reminderTime,
//             isDaily: habit.isDaily ?? false,
//             createdBy: habit.createdBy,
//             createdAt: habit.createdAt,
//           ),
//           action: 'delete',
//         );
//       }

//       Fluttertoast.showToast(
//         msg: "Habit deleted successfully",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed to delete habit: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   Future<void> updateHabit({
//     required Habit habit,
//   }) async {
//     print('created At ${habit.createdAt} createdBy ${habit.createdBy} ');
//     try {
//       Map<String, dynamic> updateData = {
//         'title': habit.title,
//         'description': habit.description,
//         'isDaily': habit.isDaily,
//         'hasReminder': habit.hasReminder,
//         'isCompleted': habit.isCompleted,
//         'createdAt': habit.createdAt,
//         'createdBy': habit.createdBy,
//       };

//       if (habit.hasReminder == true && habit.reminderTime != null) {
//         updateData['reminderTime'] = habit.reminderTime;
//       } else {
//         updateData['reminderTime'] = null;
//       }

//       final index =
//           habits.indexWhere((existingHabit) => existingHabit.id == habit.id);
//       if (index != -1) {
//         habits[index] = habit;
//         habitBox.put(habit.id, habit);
//         habits.refresh();
//         final isOnline = await _checkConnectivity();
//         if (isOnline) {
//           await FirebaseFirestore.instance
//               .collection('habits')
//               .doc(habit.id)
//               .update(updateData);
//         } else {
//           _queueForSync(habit, action: 'update');
//         }
//       }

//       Fluttertoast.showToast(
//         msg: "Habit updated successfully",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );

//       clearFields();
//     } catch (e) {
//       print("Error updating habit: $e"); // Add this for debugging
//       clearFields();
//       Fluttertoast.showToast(
//         msg: "Failed to update habit: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   Future<void> _syncToFirebase(Habit habit, {required bool isDelete}) async {
//     try {
//       final ref = FirebaseFirestore.instance.collection('habits').doc(habit.id);
//       if (isDelete) {
//         await ref.delete();
//       } else {
//         await ref.set(habit.toMap());
//       }
//     } catch (e) {
//       print("Sync to Firebase failed: $e");
//     }
//   }

// void _queueForSync(Habit habit, {required String action}) {
//   // Retrieve the queue from Hive (it will now store Habit objects)
//   final queue = habitBox.get('syncQueue', defaultValue: <Habit>[]); // Default value is an empty list of Habit objects
  
//   // Add the habit to the queue with the action
//   queue!.add({'habit': habit, 'action': action});
  
//   // Store the updated queue in the Hive box
//   habitBox.put('syncQueue', queue);
// }



//   void setReminderTime(TimeOfDay time) {
//     reminderTime.value = time;
//   }

//   void toggleHasReminder(bool value) {
//     hasReminder.value = value;
//   }

//   Future<void> fetchHabits() async {
//     try {
//       if (user == null) return;

//       final snapshot = await FirebaseFirestore.instance
//           .collection('habits')
//           .where('createdBy', isEqualTo: user!.uid)
//           .get();

//       habits.value =
//           snapshot.docs.map((doc) => Habit.fromDocument(doc)).toList();
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed to fetch habit: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   void setHabitValues(Habit? habit) {
//     if (habit != null) {
//       title.text = habit.title;
//       description.text = habit.description;
//       isDaily.value = habit.isDaily ?? false;
//       hasReminder.value = habit.hasReminder ?? false;

//       final rawReminderTime = habit.reminderTime;
//       print('Raw reminder time string: "$rawReminderTime"');

//       if (rawReminderTime != null) {
//         try {
//           final timeStr = rawReminderTime.trim();
//           final timeParts = timeStr.split(' ');
//           final time = timeParts[0].split(':');
//           final period = timeParts[1].toUpperCase();

//           int hour = int.parse(time[0]);
//           final int minute = int.parse(time[1]);

//           if (period == 'PM' && hour != 12) {
//             hour += 12;
//           } else if (period == 'AM' && hour == 12) {
//             hour = 0;
//           }

//           reminderTime.value = TimeOfDay(hour: hour, minute: minute);
//           print(
//               "Reminder time set: ${reminderTime.value?.format(Get.context!)}");
//         } catch (e) {
//           print("Error parsing reminder time: $e");
//           reminderTime.value = null;
//         }
//       } else {
//         reminderTime.value = null;
//       }
//     }
//   }

//   Future<void> updateHabitCompletion(String habitId, bool isCompleted) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) return;

//       final isOnline = await _checkConnectivity(); // Check internet connection

//       if (isOnline) {
//         // Update in Firestore
//         await FirebaseFirestore.instance
//             .collection('habits')
//             .doc(habitId)
//             .update({
//           'isCompleted': isCompleted,
//         });
//       } else {
//         // Queue for sync if offline
//         final habit = habitBox.get(habitId);
//         if (habit != null) {
//           _queueForSync(habit.copyWith(isCompleted: isCompleted),
//               action: 'update');
//         }
//       }

//       // Update in the in-memory habits list
//       final index = habits.indexWhere((habit) => habit.id == habitId);
//       if (index != -1) {
//         habits[index].isCompleted = isCompleted;
//         habits.refresh();
//       }

//       // Update in Hive database
//       final habit = habitBox.get(habitId);
//       if (habit != null) {
//         habit.isCompleted = isCompleted; // Update the field
//         habitBox.put(habitId, habit); // Save the updated habit back
//       }
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed to update habit: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   void clearFields() {
//     title.clear();
//     description.clear();
//     isDaily.value = false;
//     hasReminder.value = false;
//     reminderTime.value = const TimeOfDay(hour: 10, minute: 0);
//   }

//   Future<void> syncQueuedChanges() async {
//     final isOnline = await _checkConnectivity();
//     if (!isOnline) return;

//     final queue = habitBox.get('syncQueue', defaultValue: []);
//     for (var item in queue) {
//       final habitMap = item['habit'];
//       final action = item['action'];
//       final habit = Habit.fromMap(habitMap);

//       if (action == 'add') {
//         await _syncToFirebase(habit, isDelete: false);
//       } else if (action == 'update') {
//         await _syncToFirebase(habit, isDelete: false);
//       } else if (action == 'delete') {
//         await _syncToFirebase(habit, isDelete: true);
//       }
//     }

//     // Clear the sync queue
//     habitBox.delete('syncQueue');
//   }

//   Future<void> resolveConflicts(List<Habit> local, List<Habit> remote) async {
//     for (var remoteHabit in remote) {
//       final localIndex =
//           local.indexWhere((habit) => habit.id == remoteHabit.id);

//       if (localIndex != -1) {
//         final localHabit = local[localIndex];

//         // Compare timestamps
//         if (remoteHabit.createdAt!
//             .toDate()
//             .isAfter(localHabit.createdAt! as DateTime)) {
//           habitBox.put(remoteHabit.id, remoteHabit);
//         } else {
//           await _syncToFirebase(localHabit, isDelete: false);
//         }
//       } else {
//         habitBox.put(remoteHabit.id, remoteHabit);
//       }
//     }
//   }

//   void startSync() async {
//     isSyncing.value = true;
//     await syncQueuedChanges();
//     isSyncing.value = false;
//   }
// }
