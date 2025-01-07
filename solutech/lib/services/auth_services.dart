import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  Future<UserCredential?> loginWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web authentication with Google sign-in popup
        GoogleAuthProvider authProvider = GoogleAuthProvider();

        // Sign-in using the popup
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithPopup(authProvider);

        return userCredential;
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
        return await FirebaseAuth.instance.signInWithCredential(cred);
      }
    } catch (e) {
      // Log and handle the error
      print("Error during Google sign-in: ${e.toString()}");
    }
    return null;
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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

  Future<void> logout() async => await FirebaseAuth.instance.signOut();
}
