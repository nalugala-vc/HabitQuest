import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

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
            dayNumStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.w900),
            dayStrStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500),
            monthStrStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
