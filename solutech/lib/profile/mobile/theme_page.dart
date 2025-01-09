import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/home/controller/theme_controller.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class ThemeScreenMobile extends StatefulWidget {
  const ThemeScreenMobile({super.key});

  @override
  State<ThemeScreenMobile> createState() => _ThemeScreenMobileState();
}

class _ThemeScreenMobileState extends State<ThemeScreenMobile> {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
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
                Obx(() {
                  return RobotoCondensed(
                    text: themeController.isDarkMode.value
                        ? 'Change to Light Mode'
                        : 'Change to Dark Mode',
                    fontSize: 18,
                  );
                }),
                Obx(() {
                  return Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: (value) => themeController.toggleTheme(),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
