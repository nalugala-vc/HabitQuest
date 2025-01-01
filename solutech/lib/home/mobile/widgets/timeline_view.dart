import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

import 'package:solutech/utils/app_colors.dart';

class TimelineView extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(DateTime) onSelectedDateChanged;
  const TimelineView(
      {super.key,
      required this.onSelectedDateChanged,
      required this.selectedDate});

  @override
  State<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: EasyDateTimeLine(
        initialDate: widget.selectedDate,
        onDateChange: widget.onSelectedDateChanged,
        headerProps: const EasyHeaderProps(
          showHeader: false,
          showSelectedDate: true,
        ),
        dayProps: EasyDayProps(
          activeDayStyle: DayStyle(
            dayNumStyle: const TextStyle(
                color: AppColors.purple500,
                fontSize: 18,
                fontWeight: FontWeight.w900),
            dayStrStyle: const TextStyle(
                color: AppColors.purple500, fontWeight: FontWeight.w500),
            monthStrStyle: const TextStyle(
                color: AppColors.purple500, fontWeight: FontWeight.w500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.purple100,
            ),
          ),
        ),
      ),
    );
  }
}
