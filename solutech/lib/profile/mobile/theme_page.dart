import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class ThemeScreenMobile extends StatefulWidget {
  const ThemeScreenMobile({super.key});

  @override
  State<ThemeScreenMobile> createState() => _ThemeScreenMobileState();
}

class _ThemeScreenMobileState extends State<ThemeScreenMobile> {
  bool isDarkMode = false;

  // Function to get the saved theme preference
  Future<void> _getThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode = prefs.getBool('isDarkMode') ?? false;
    setState(() {
      isDarkMode = darkMode;
    });
    // Apply the theme when getting initial preference
    _applyTheme(darkMode);
  }

  // Function to apply theme
  void _applyTheme(bool darkMode) {
    Get.changeThemeMode(darkMode ? ThemeMode.dark : ThemeMode.light);
  }

  // Function to save the theme preference and update the app theme
  Future<void> _setThemePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);

    setState(() {
      isDarkMode = value;
    });

    // Apply the new theme
    _applyTheme(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      // Remove explicit backgroundColor setting to use theme's scaffold background color
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RobotoCondensed(
              text: 'Change Theme',
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
            spaceH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDarkMode ? 'Change to Light Mode' : 'Change to Dark Mode',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Switch(
                  value: isDarkMode,
                  onChanged: _setThemePreference,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
