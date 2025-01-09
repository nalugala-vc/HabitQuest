import 'package:flutter/material.dart';

import 'package:solutech/utils/fonts/roboto_condensed.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final double width;
  final bool border;

  const RoundedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.height = 54,
    this.width = double.maxFinite,
    this.border = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor =
        backgroundColor ?? Theme.of(context).colorScheme.primary;
    final Color effectiveTextColor =
        textColor ?? Theme.of(context).colorScheme.onPrimary;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: effectiveBackgroundColor,
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      child: Container(
        height: height,
        alignment: Alignment.center,
        width: width,
        decoration: border
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                    color: Theme.of(context).colorScheme.surface, width: 1.5))
            : null,
        child: RobotoCondensed(
          text: label,
          fontSize: 20,
          textColor: effectiveTextColor,
        ),
      ),
    );
  }
}
