import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:solutech/auth/onboarding/onboarding_questions.dart';
import 'package:solutech/home/mobile/home_page.dart';
import 'package:solutech/services/auth_services.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();
  final AuthServices _authServices = AuthServices();

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser(String email, String password) async {
    try {
      await _authServices.signIn(email: email, password: password);
      Get.offAll(() => const HomePageMobile());
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Login failed: ${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void loginWithGoogle() async {
    try {
      print('Starting Google login process...');

      final result = await _authServices.loginWithGoogle();
      print('Auth service result: $result');

      // Check if user is actually signed in
      final currentUser = FirebaseAuth.instance.currentUser;
      print('Current Firebase User: ${currentUser?.email ?? "No user"}');

      Get.offAll(() => const HomePageMobile());
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Login failed: ${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final AuthServices _authServices = AuthServices();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  String? validatePassword(String password) {
    if (password.length < 6) {
      Fluttertoast.showToast(
          msg: 'Password must be at least 6 characters long',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return 'Password must be at least 6 characters long';
    }
    if (!RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(password)) {
      Fluttertoast.showToast(
          msg: 'Password must contain at least one special character',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return 'Password must contain at least one special character';
    }
    if (!RegExp(r'(?=.*?[0-9])').hasMatch(password)) {
      Fluttertoast.showToast(
          msg: 'Password must contain at least one number',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return 'Password must contain at least one number';
    }
    return null;
  }

  String? validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      Fluttertoast.showToast(
          msg: 'Passwords do not match',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Email is required',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return 'Email is required';
    }
    if (!emailRegex.hasMatch(email)) {
      Fluttertoast.showToast(
          msg: 'Enter a valid email address',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return 'Enter a valid email address';
    }
    return null;
  }

  void register(String email, String password, String confirmPassword) async {
    String? emailError = validateEmail(email);
    String? passwordError = validatePassword(password);
    String? confirmPasswordError =
        validateConfirmPassword(password, confirmPassword);

    if (emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      return;
    }

    try {
      await _authServices.signUp(email: email, password: password);
      Get.offAll(() => OnboardingQuestions());
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Registration failed: ${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  final otp = TextEditingController();

  void verifyOTP(
    String otp,
  ) {}
}
