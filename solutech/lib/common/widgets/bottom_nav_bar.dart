import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutech/home/mobile/home_page.dart';
import 'package:solutech/streaks/mobile/streaks.dart';
import 'package:solutech/utils/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  String address = '0x2783';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.purple500,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(HeroIcons.home, "Home", 0),
          _buildNavItem(HeroIcons.plusCircle, "Search", 1),
          _buildNavItem(
            HeroIcons.fire,
            (address != null && address.isNotEmpty) ? "Add" : 'Connect',
            2,
          ),
          _buildNavItem(HeroIcons.user, "Profile", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(HeroIcons icon, String label, int index) {
    final bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });

        if (index == 0) {
          Get.to(
            () => const HomePageMobile(),
          );
        } else if (index == 1) {
          Get.to(
            () => const HomePageMobile(),
          );
        } else if (index == 2) {
          Get.to(
            () => const StreaksMobile(),
          );
        } else {}
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? const Color.fromARGB(255, 149, 121, 168)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(isActive ? 100 : 0),
        ),
        child: HeroIcon(
          icon,
          color: isActive ? Colors.white : Colors.white,
          style: HeroIconStyle.outline,
          size: 28,
        ),
      ),
    );
  }
}
