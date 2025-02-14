import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutech/common/widgets/confirm_dialogue.dart';
import 'package:solutech/common/widgets/nav_widget.dart';
import 'package:solutech/services/auth_services.dart';
import 'package:solutech/utils/fonts/rock_salt.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    String currentRoute = Get.currentRoute;

    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                RockSalt(
                  text: 'HabitQuest',
                  fontSize: 16,
                  textColor: Theme.of(context).colorScheme.surface,
                ),
              ],
            ),
          ),
          NavWidget(
            icon: HeroIcon(
              HeroIcons.home,
              style: HeroIconStyle.outline,
              color: Theme.of(context).colorScheme.surface,
              size: 24,
            ),
            name: 'Home',
            isActive: currentRoute.startsWith('/homepage'),
            onTap: () => Get.toNamed('/homepage'),
          ),
          NavWidget(
            icon: HeroIcon(
              HeroIcons.plusCircle,
              style: HeroIconStyle.outline,
              color: Theme.of(context).colorScheme.surface,
              size: 24,
            ),
            name: 'Create habit',
            isActive: currentRoute.startsWith('/create-habit'),
            onTap: () => Get.toNamed('/create-habit'),
          ),
          NavWidget(
            icon: HeroIcon(
              HeroIcons.user,
              style: HeroIconStyle.outline,
              color: Theme.of(context).colorScheme.surface,
              size: 24,
            ),
            name: 'Profile',
            isActive: currentRoute == '/profile-page',
            onTap: () => Get.toNamed('/profile-page'),
          ),
          const Spacer(),
          NavWidget(
            icon: HeroIcon(
              HeroIcons.arrowLeftEndOnRectangle,
              style: HeroIconStyle.outline,
              color: Theme.of(context).colorScheme.surface,
              size: 24,
            ),
            name: 'Logout',
            isActive: false,
            onTap: () => _handleLogout(context),
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    final AuthServices _authServices = AuthServices();
    confirmDialogue(
      context: context,
      icon: 'assets/images/warning.png',
      label: 'Log out',
      message: 'Are you sure you want to log out?',
      onConfirm: () async {
        await _authServices.logout();
      },
    );
  }
}
