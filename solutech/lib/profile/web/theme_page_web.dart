import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/common/widgets/nav_bar.dart';
import 'package:solutech/home/controller/theme_controller.dart';
import 'package:solutech/streaks/web/streaks_web.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class ThemeScreenWeb extends StatelessWidget {
  const ThemeScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Row(
        children: [
          NavBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          return Text(
                            themeController.isDarkMode.value
                                ? 'Change to Light Mode'
                                : 'Change to Dark Mode',
                            style: const TextStyle(fontSize: 18),
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
                    spaceH200,
                    spaceH200,
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: VerticalDivider(
              color: Theme.of(context).colorScheme.onSecondary,
              thickness: 1,
            ),
          ),
          Expanded(child: StreaksWeb()),
        ],
      ),
    );
  }
}
