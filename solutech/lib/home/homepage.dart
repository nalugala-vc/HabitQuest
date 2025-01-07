import 'package:flutter/material.dart';
import 'package:solutech/home/mobile/home_page.dart';
import 'package:solutech/home/web/homepage_web.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return const HomepageWeb();
        } else {
          return const HomePageMobile();
        }
      },
    );
  }
}
