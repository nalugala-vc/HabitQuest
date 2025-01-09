import 'package:flutter/material.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class SignUpOptions extends StatelessWidget {
  final String text;
  const SignUpOptions({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.0,
          child: Divider(
            thickness: 1.0,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        spaceH10,
        RobotoCondensed(
            text: text,
            fontSize: 18,
            fontWeight: FontWeight.normal,
            textColor: Theme.of(context).colorScheme.onPrimary),
        spaceH10,
        SizedBox(
          width: 100.0,
          child: Divider(
              thickness: 1.0, color: Theme.of(context).colorScheme.onPrimary),
        ),
      ],
    );
  }
}
