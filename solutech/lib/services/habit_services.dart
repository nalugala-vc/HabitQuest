import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HabitServices {
  Future<void> addHabit(Map<String, dynamic> habit) async {
    try {
      await FirebaseFirestore.instance.collection('habits').add(habit);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.code,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(e.code);
      throw Exception(e.code);
    } catch (e) {
      Fluttertoast.showToast(
        msg: ' failed to create new habit: ${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(e.toString());
      throw Exception('An unknown error occurred: ${e.toString()}');
    }
  }
}
