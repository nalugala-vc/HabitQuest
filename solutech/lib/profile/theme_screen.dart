import 'package:flutter/material.dart';
import 'package:solutech/profile/mobile/theme_page.dart';
import 'package:solutech/profile/web/theme_page_web.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return const ThemeScreenWeb();
        } else {
          return const ThemeScreenMobile();
        }
      },
    );
  }
}
