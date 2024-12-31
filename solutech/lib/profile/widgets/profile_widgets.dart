import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class ProfileWidget extends StatelessWidget {
  final HeroIcons icon;
  final String title;
  final Color bgColor;
  final VoidCallback onSelectedDateChanged;
  const ProfileWidget(
      {super.key,
      required this.bgColor,
      required this.icon,
      required this.onSelectedDateChanged,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: bgColor,
                child: HeroIcon(
                  icon,
                  color: AppColors.grey900,
                  style: HeroIconStyle.outline,
                  size: 24,
                ),
              ),
              spaceW10,
              RobotoCondensed(
                text: title,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        const HeroIcon(
          HeroIcons.chevronRight,
          color: AppColors.grey900,
          style: HeroIconStyle.outline,
          size: 24,
        ),
      ],
    );
  }
}
