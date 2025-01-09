import 'package:flutter/material.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class SocialIcons extends StatelessWidget {
  final VoidCallback onTap;
  final String socialLogo;
  final String? text;
  final double logoheight;
  final double logowidth;
  const SocialIcons(
      {super.key,
      required this.onTap,
      this.text = "Google",
      required this.socialLogo,
      required this.logoheight,
      required this.logowidth});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: 47,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
            child: Row(
          children: [
            Container(
              height: logoheight,
              width: logoheight,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(socialLogo))),
            ),
            spaceW10,
            RobotoCondensed(
              text: text!,
              fontSize: 16,
              textColor: Theme.of(context).colorScheme.surface,
            )
          ],
        )),
      ),
    );
  }
}
