import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
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
        backgroundColor = Theme.of(context).colorScheme.primaryFixed;
        break;
      case "Tip":
        icon = HeroIcons.lightBulb;
        backgroundColor = Theme.of(context).colorScheme.secondary;
        break;
      case "Update":
        icon = HeroIcons.heart;
        backgroundColor = Theme.of(context).colorScheme.onTertiary;
        break;
      default:
        icon = HeroIcons.bell;
        backgroundColor = Theme.of(context).colorScheme.onSecondary;
    }

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 7),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RobotoCondensed(
                              text: time,
                              fontSize: 12,
                              textColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryFixed),
                          spaceW10,
                          if (!isRead)
                            Padding(
                              padding: const EdgeInsets.only(right: 5, top: 10),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
                spaceH5,
                RobotoCondensed(
                  text: description,
                  fontSize: 14,
                  textColor: Theme.of(context).colorScheme.onInverseSurface,
                ),
                spaceH5,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onMarkAsRead,
                    child: RobotoCondensed(
                      text: "Mark as Read",
                      fontSize: 12,
                      textColor: Theme.of(context).colorScheme.primary,
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
