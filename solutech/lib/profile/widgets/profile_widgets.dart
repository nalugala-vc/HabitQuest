import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class ProfileWidget extends StatelessWidget {
  final HeroIcons icon;
  final String title;
  final Color bgColor;
  final VoidCallback onTap;
  const ProfileWidget(
      {super.key,
      required this.bgColor,
      required this.icon,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: bgColor,
                  child: HeroIcon(
                    icon,
                    color: Theme.of(context).colorScheme.onTertiaryFixed,
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
          HeroIcon(
            HeroIcons.chevronRight,
            color: Theme.of(context).colorScheme.onTertiaryFixed,
            style: HeroIconStyle.outline,
            size: 24,
          ),
        ],
      ),
    );
  }
}
