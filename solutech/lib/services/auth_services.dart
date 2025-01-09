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
        // Web authentication with Google sign-in popup
        GoogleAuthProvider authProvider = GoogleAuthProvider();

        // Sign-in using the popup
        userCredential =
            await FirebaseAuth.instance.signInWithPopup(authProvider);
      } else {
        // Mobile authentication with Google sign-in
        final GoogleSignIn googleSignIn = GoogleSignIn();

        // Attempt to sign in
        final googleUser = await googleSignIn.signIn();

        // Check if the user is null (user might have canceled sign-in)
        if (googleUser == null) {
          print("Google Sign-In canceled by user");
          return null;
        }

        // Get authentication tokens from Google
        final googleAuth = await googleUser.authentication;

        // Create credentials using the tokens
        final cred = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        // Sign in with credentials and return the result
        userCredential = await FirebaseAuth.instance.signInWithCredential(cred);
      }

      // Save user info in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userEmail', userCredential.user?.email ?? '');
      prefs.setString('userName', userCredential.user?.displayName ?? '');
      prefs.setString('userPhotoURL', userCredential.user?.photoURL ?? '');
      prefs.setString('userId', userCredential.user?.uid ?? '');

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
      // Save user info in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('userEmail', userCredential.user?.email ?? '');
      prefs.setString('userName', userCredential.user?.displayName ?? '');
      prefs.setString('userPhotoURL', userCredential.user?.photoURL ?? '');
      prefs.setString('userId', userCredential.user?.uid ?? '');
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

      // Save user info in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userEmail', userCredential.user?.email ?? '');
      prefs.setString('userName', userCredential.user?.displayName ?? '');
      prefs.setString('userPhotoURL', userCredential.user?.photoURL ?? '');
      prefs.setString('userId', userCredential.user?.uid ?? '');
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
      throw Exception(message); // Throw an exception to be caught in the caller
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

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Get.offAllNamed('/');
  }
}
