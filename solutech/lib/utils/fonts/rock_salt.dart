import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RockSalt extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double fontSize;
  final bool shouldTruncate;
  final FontWeight fontWeight;
  final int truncateLength;
  final TextAlign textAlignment;
  final bool underline;

  RockSalt({
    super.key,
    required this.text,
    this.shouldTruncate = true,
    this.textColor,
    this.fontSize = 0,
    this.truncateLength = 45,
    this.fontWeight = FontWeight.bold,
    this.textAlignment = TextAlign.center,
    this.underline = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor =
        textColor ?? Theme.of(context).colorScheme.onPrimary;
    return Text(
      shouldTruncate
          ? text.length > truncateLength
              ? '${text.substring(0, truncateLength)}...'
              : text
          : text,
      textAlign: textAlignment,
      style: GoogleFonts.rockSalt(
        color: effectiveTextColor,
        fontSize: fontSize == 0 ? 30 : fontSize,
        fontWeight: fontWeight,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
