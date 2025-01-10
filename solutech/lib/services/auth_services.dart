import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  Future<UserCredential?> loginWithGoogle() async {
    try {
      UserCredential? userCredential;

      if (kIsWeb) {
        GoogleAuthProvider authProvider = GoogleAuthProvider();

        userCredential =
            await FirebaseAuth.instance.signInWithPopup(authProvider);
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn();

        final googleUser = await googleSignIn.signIn();

        if (googleUser == null) {
          print("Google Sign-In canceled by user");
          return null;
        }

        final googleAuth = await googleUser.authentication;

        final cred = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        userCredential = await FirebaseAuth.instance.signInWithCredential(cred);
      }

      print(userCredential.user);

      await _saveUserDataToPrefs(userCredential);
      return userCredential;
    } catch (e) {
      print("Error during Google sign-in: ${e.toString()}");
      return null;
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await _saveUserDataToPrefs(userCredential);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      }

      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await _saveUserDataToPrefs(userCredential);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'The user cannot be found';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided';
      }

      Fluttertoast.showToast(
        msg: message.isNotEmpty ? message : e.code,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      throw Exception(message);
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
      throw Exception('An unknown error occurred: ${e.toString()}');
    }
  }

  Future<void> _saveUserDataToPrefs(UserCredential userCredential) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', userCredential.user?.email ?? '');
    await prefs.setString('userName', userCredential.user?.displayName ?? '');
    await prefs.setString('userPhotoURL', userCredential.user?.photoURL ?? '');
    await prefs.setString('userId', userCredential.user?.uid ?? '');
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    return userId != null && userId.isNotEmpty;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Get.offAllNamed('/');
  }
}
