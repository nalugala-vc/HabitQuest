import 'package:flutter/material.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';

class MyMinutes extends StatelessWidget {
  final int mins;
  const MyMinutes({super.key, required this.mins});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          child: Center(
        child: RobotoCondensed(
          text: mins.toString(),
          fontSize: 20,
        ),
      )),
    );
  }
}
