import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/home/mobile/widgets/daily_summary.dart';
import 'package:solutech/home/mobile/widgets/habit_card_list.dart';
import 'package:solutech/home/mobile/widgets/timeline_view.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  @override
  Widget build(BuildContext context) {
    var selectedDate = DateTime.now().obs;
    return Scaffold(
        appBar: const MainAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TimelineView(
                    selectedDate: selectedDate.value,
                    onSelectedDateChanged: (date) =>
                        setState(() => selectedDate.value = date),
                  ),
                  spaceH20,
                  const DailySummary(
                    completedTasts: 4,
                    date: '2024-12-31',
                    totalTasks: 7,
                  ),
                  spaceH15,
                  RobotoCondensed(
                    text: 'My Habits',
                    fontSize: 16,
                  ),
                  spaceH15,
                  HabitCardList(
                    selectedDate: selectedDate.value,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
