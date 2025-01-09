import 'package:flutter/material.dart';

class AchievementBadgeA extends StatefulWidget {
  final String imgURL;

  const AchievementBadgeA({
    super.key,
    required this.imgURL,
  });
  @override
  AchievementBadgeAState createState() => AchievementBadgeAState();
}

class AchievementBadgeAState extends State<AchievementBadgeA> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.asset(
          widget.imgURL, // Replace with your image URL
          width: 70.0,
          height: 70.0,
        ),
      ),
    );
  }
}
