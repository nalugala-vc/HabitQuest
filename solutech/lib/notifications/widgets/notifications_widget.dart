import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class NotificationWidget extends StatelessWidget {
  final String type;
  final String title;
  final String description;
  final String time;
  final bool isRead;
  final VoidCallback onMarkAsRead;

  const NotificationWidget({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    HeroIcons icon;
    Color backgroundColor;

    switch (type) {
      case "Reminder":
        icon = HeroIcons.clock;
        backgroundColor = AppColors.peach200;
        break;
      case "Tip":
        icon = HeroIcons.lightBulb;
        backgroundColor = AppColors.pink400;
        break;
      case "Update":
        icon = HeroIcons.heart;
        backgroundColor = AppColors.purple100;
        break;
      default:
        icon = HeroIcons.bell;
        backgroundColor = Colors.grey.shade300;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isRead)
            const Padding(
              padding: EdgeInsets.only(right: 5, top: 10),
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.red,
              ),
            ),
          CircleAvatar(
            radius: 25,
            backgroundColor: backgroundColor,
            child: HeroIcon(
              icon,
              style: HeroIconStyle.outline,
              size: 24,
            ),
          ),
          spaceW15,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RobotoCondensed(
                      text: title,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    RobotoCondensed(
                        text: time, fontSize: 12, textColor: AppColors.grey500),
                  ],
                ),
                spaceH5,
                RobotoCondensed(
                  text: description,
                  fontSize: 14,
                  textColor: AppColors.grey700,
                ),
                spaceH5,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onMarkAsRead,
                    child: const Text(
                      "Mark as Read",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
