import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class HabitCard extends StatelessWidget {
  final String title;
  final int streak;
  final double progress;
  final String habitId;
  final bool isCompleted;
  final DateTime date;
  final Function(bool?) onChanged;
  const HabitCard(
      {super.key,
      required this.date,
      required this.habitId,
      required this.isCompleted,
      required this.progress,
      required this.streak,
      required this.onChanged,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.purple500,
          ),
          gradient: LinearGradient(
            colors: isCompleted
                ? [AppColors.purple100, AppColors.purple400]
                : [AppColors.pink100, AppColors.pink400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.grey300,
              blurRadius: 16,
            ),
          ]),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Checkbox(value: isCompleted, onChanged: onChanged),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RobotoCondensed(
                    text: title,
                    fontSize: 16,
                  ),
                  if (streak > 0) ...[
                    Row(
                      children: [
                        const HeroIcon(
                          HeroIcons.fire,
                          style: HeroIconStyle.outline,
                          color: AppColors.purple750,
                        ),
                        spaceW5,
                        RobotoCondensed(
                          text: '$streak days',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.purple750,
                        )
                      ],
                    )
                  ]
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
