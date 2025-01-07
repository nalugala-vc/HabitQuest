import 'package:flutter/material.dart';
import 'package:solutech/profile/mobile/profile_page.dart';
import 'package:solutech/profile/web/profile_page_web.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return const ProfilePageWeb();
        } else {
          return const ProfilePageMobile();
        }
      },
    );
  }
}
