import 'package:flutter/material.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class AchievementBadgeB extends StatefulWidget {
  final String imgURL;
  final String title;
  final Color? bgColor;
  final Color titleColor;
  final VoidCallback onPressed;

  const AchievementBadgeB({
    super.key,
    required this.imgURL,
    this.bgColor,
    required this.title,
    required this.onPressed,
    this.titleColor = const Color(0xFF121212),
  });
  @override
  AchievementBadgeBState createState() => AchievementBadgeBState();
}

class AchievementBadgeBState extends State<AchievementBadgeB> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor =
        widget.bgColor ?? Theme.of(context).colorScheme.onTertiaryFixed;
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: effectiveBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: RobotoCondensed(text: widget.title, fontSize: 12),
              ),
              spaceH10,
              Image.asset(
                widget.imgURL,
                width: 80.0,
                height: 80.0,
              ),
            ],
          )),
    );
  }
}
