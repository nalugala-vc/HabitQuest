import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutech/notifications/mobile/notifications_page.dart';

import 'package:solutech/utils/fonts/rock_salt.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onTertiary,
      title: RockSalt(
          text: 'HabitQuest',
          fontSize: 24,
          textColor: Theme.of(context).colorScheme.primary),
      actions: [
        IconButton(
            icon: const HeroIcon(
              HeroIcons.bell,
              style: HeroIconStyle.outline,
              size: 30,
            ),
            onPressed: () {
              Get.to(
                () => NotificationsPage(),
              );
            }),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
