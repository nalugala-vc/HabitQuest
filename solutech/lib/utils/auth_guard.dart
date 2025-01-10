import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    bool isAuthenticated = checkUserAuthentication();

    if (!isAuthenticated) {
      return RouteSettings(name: '/onboarding');
    }

    return null; // Allow access if authenticated
  }

  bool checkUserAuthentication() {
    return _loadUserDetails() != null;
  }

  Future<bool> _loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    return userId != null && userId.isNotEmpty;
  }
}
