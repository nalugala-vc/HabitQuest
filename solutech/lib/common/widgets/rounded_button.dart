import 'package:flutter/material.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/poppins.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double width;
  final bool border;

  const RoundedButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.height = 54,
      this.width = double.maxFinite,
      this.border = false,
      this.backgroundColor = AppColors.purple500,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor, // Text color
        padding: const EdgeInsets.all(0), // Padding for the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      child: Container(
        height: height, // Set the height
        alignment: Alignment.center,
        width: width,
        decoration: border
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: AppColors.purple500, width: 1.5))
            : null,
        child: Poppins(
          text: label,
          fontSize: 20,
          textColor: textColor,
        ),
      ),
    );
  }
}
