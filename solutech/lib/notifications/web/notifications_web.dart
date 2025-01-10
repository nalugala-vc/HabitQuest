import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:solutech/common/widgets/nav_bar.dart';
import 'package:solutech/notifications/widgets/no_notifications_widget.dart';
import 'package:solutech/notifications/widgets/notifications_widget.dart';
import 'package:solutech/streaks/web/streaks_web.dart';
import 'package:solutech/utils/spacers.dart';

class NotificationsWeb extends StatefulWidget {
  const NotificationsWeb({super.key});

  @override
  State<NotificationsWeb> createState() => _NotificationsWebState();
}

class _NotificationsWebState extends State<NotificationsWeb> {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final title = arguments['title'];
    final message = arguments['message'];
    final time = arguments['currentTime'];

    return Scaffold(
        body: Row(
      children: [
        NavBar(),
        Expanded(
          child: SingleChildScrollView(
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
                      ],
                    )),
        ),
        SizedBox(
          height: double.infinity,
          child: VerticalDivider(
            color: Theme.of(context).colorScheme.onSecondary,
            thickness: 1,
          ),
        ),
        Expanded(child: StreaksWeb()),
      ],
    ));
  }
}
