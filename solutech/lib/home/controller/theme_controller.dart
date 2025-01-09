import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech/utils/app_colors.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  void toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
        isDarkMode.value ? AppColors.darkTheme : AppColors.lightTheme);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode.value);
  }

  void _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    Get.changeTheme(
        isDarkMode.value ? AppColors.darkTheme : AppColors.lightTheme);
  }
}
