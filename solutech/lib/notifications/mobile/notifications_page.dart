import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/common/widgets/bottom_nav_bar.dart';
import 'package:solutech/notifications/widgets/no_notifications_widget.dart';
import 'package:solutech/notifications/widgets/notifications_widget.dart';
import 'package:solutech/utils/spacers.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    String title = '';
    String message = '';
    String time = '';
    // Check if arguments are null
    if (arguments != null) {
      title = arguments['title'];
      message = arguments['message'];
      time = arguments['currentTime'];
    } else {
      // Handle the case where no arguments are passed
      print("No arguments passed!");
    }

    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
          child: (message.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [spaceH150, NoNotificationsWidget()],
                  ),
                )
              : Column(
                  children: [
                    spaceH15,
                    NotificationWidget(
                      description: message,
                      onMarkAsRead: () {},
                      time: time,
                      title: title,
                      type: "Reminder",
                      isRead: false,
                    ),
                    spaceH15,
                  ],
                )),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
