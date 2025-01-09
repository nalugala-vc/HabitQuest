import 'package:flutter/material.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class NoNotificationsWidget extends StatelessWidget {
  const NoNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 90,
            backgroundColor: Theme.of(context).colorScheme.onTertiary,
            child: Image(
              image: AssetImage('assets/images/bell.png'),
              height: 90,
              width: 90,
              fit: BoxFit.contain,
            ),
          ),
          spaceH10,
          RobotoCondensed(
            text: 'You are all Caught up',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
