import 'package:flutter/material.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';

class SignUpOptions extends StatelessWidget {
  final String text;
  const SignUpOptions({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 100.0,
          child: Divider(thickness: 1.0, color: AppColors.grey600),
        ),
        const SizedBox(width: 10.0),
        RobotoCondensed(
            text: text,
            fontSize: 18,
            fontWeight: FontWeight.normal,
            textColor: AppColors.grey600),
        const SizedBox(width: 10.0),
        const SizedBox(
          width: 100.0,
          child: Divider(thickness: 1.0, color: AppColors.grey600),
        ),
      ],
    );
  }
}
