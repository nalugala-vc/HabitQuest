import 'package:flutter/material.dart';

import 'package:solutech/utils/fonts/rock_salt.dart';
import 'package:solutech/utils/spacers.dart';

class LogoWidget extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final double radius;
  final double imageDimension;
  const LogoWidget(
      {super.key,
      this.containerHeight = 300,
      this.containerWidth = double.maxFinite,
      this.imageDimension = 90,
      this.radius = 90});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      color: Theme.of(context).colorScheme.onTertiary,
      height: containerHeight,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Image(
              image: AssetImage('assets/icons/logo.png'),
              height: imageDimension,
              width: imageDimension,
              fit: BoxFit.contain,
            ),
          ),
          spaceH10,
          RockSalt(
              text: 'HabitQuest',
              fontSize: 28,
              textColor: Theme.of(context).colorScheme.primary)
        ],
      )),
    );
  }
}
