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
          monthPickerType: MonthPickerType.dropDown,
          showHeader: false,
          showSelectedDate: true,
        ),
        dayProps: EasyDayProps(
          activeDayStyle: DayStyle(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [AppColors.pink400, AppColors.purple500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
