import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/home/mobile/widgets/timeline_view.dart';

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
                children: [
                  TimelineView(
                    selectedDate: selectedDate.value,
                    onSelectedDateChanged: (date) =>
                        setState(() => selectedDate.value = date),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
