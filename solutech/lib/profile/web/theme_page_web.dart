import 'package:flutter/material.dart';
import 'package:solutech/common/widgets/nav_bar.dart';
import 'package:solutech/streaks/web/streaks_web.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class ThemeScreenWeb extends StatefulWidget {
  const ThemeScreenWeb({super.key});

  @override
  State<ThemeScreenWeb> createState() => _ThemeScreenWebState();
}

class _ThemeScreenWebState extends State<ThemeScreenWeb> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        NavBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                        isDarkMode
                            ? 'Change to Light Mode'
                            : 'Change to Dark Mode',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = value;
                          });
                        },
                      ),
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
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Expanded(child: StreaksWeb()),
      ],
    ));
  }
}
