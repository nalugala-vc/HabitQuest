import 'package:flutter/material.dart';
import 'package:solutech/common/constants.dart';

import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/common/widgets/bottom_nav_bar.dart';
import 'package:solutech/notifications/widgets/no_notifications_widget.dart';
import 'package:solutech/notifications/widgets/notifications_widget.dart';
import 'package:solutech/utils/spacers.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
          child: notifications == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [spaceH150, NoNotificationsWidget()],
                  ),
                )
              : Column(
                  children: [
                    spaceH15,
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return NotificationWidget(
                            type: notification['type'],
                            title: notification['title'],
                            description: notification['description'],
                            time: notification['time'],
                            isRead: notification['isRead'],
                            onMarkAsRead: () {},
                          );
                        }),
                  ],
                )),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
