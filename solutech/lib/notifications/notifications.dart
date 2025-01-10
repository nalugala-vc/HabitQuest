import 'package:flutter/material.dart';
import 'package:solutech/notifications/web/notifications_web.dart';
import 'package:solutech/profile/mobile/profile_page.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return const NotificationsWeb();
        } else {
          return const ProfilePageMobile();
        }
      },
    );
  }
}
