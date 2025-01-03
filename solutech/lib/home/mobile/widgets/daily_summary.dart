import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class DailySummary extends StatelessWidget {
  final int completedTasts;
  final int totalTasks;
  final String date;
  const DailySummary(
      {super.key,
      required this.completedTasts,
      required this.totalTasks,
      required this.date});

  @override
  Widget build(BuildContext context) {
    final progress = totalTasks == 0 ? 0.0 : completedTasts / totalTasks;
    return Card(
      elevation: 8,
      shadowColor: AppColors.grey200,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.purple100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RobotoCondensed(
                  text: 'Daily Summary',
                  fontSize: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: RobotoCondensed(
                    text: date,
                    textColor: AppColors.purple750,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            spaceH20,
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: AppColors.grey700.withOpacity(0.1),
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.purple500),
                  ),
                )
              ],
            ),
            spaceH20,
            Row(
              children: [
                const HeroIcon(
                  HeroIcons.checkCircle,
                  style: HeroIconStyle.outline,
                  color: AppColors.purple750,
                ),
                spaceW10,
                RobotoCondensed(
                  text: '$completedTasts / $totalTasks',
                  fontSize: 15,
                  textColor: AppColors.purple750,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
