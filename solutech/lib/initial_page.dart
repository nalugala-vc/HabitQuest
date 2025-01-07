import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    // Access SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if a user is stored
    bool isUserLoggedIn =
        prefs.containsKey('userEmail'); // Adjust key as needed

    // Navigate to the appropriate screen
    if (isUserLoggedIn) {
      Get.offAllNamed('/sign-in');
    } else {
      Navigator.pushReplacementNamed(context, '/login'); // Login route
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
