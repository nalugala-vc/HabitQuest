import 'package:flutter/material.dart';

Widget get spaceH2 => const SizedBox(
      height: 2,
    );

Widget get spaceH5 => const SizedBox(
      height: 5,
    );

Widget get spaceH7 => const SizedBox(
      height: 7,
    );

Widget get spaceH10 => const SizedBox(
      height: 10,
    );

Widget get spaceH12 => const SizedBox(
      height: 12,
    );

Widget get spaceH14 => const SizedBox(
      height: 14,
    );

Widget get spaceH15 => const SizedBox(
      height: 15,
    );

Widget get spaceH20 => const SizedBox(
      height: 20,
    );

Widget get spaceH25 => const SizedBox(
      height: 26,
    );

Widget get spaceH30 => const SizedBox(
      height: 30,
    );

Widget get spaceH35 => const SizedBox(
      height: 35,
    );

Widget get spaceH40 => const SizedBox(
      height: 40,
    );

Widget get spaceH50 => const SizedBox(
      height: 50,
    );

Widget get spaceH60 => const SizedBox(
      height: 60,
    );

Widget get spaceH70 => const SizedBox(
      height: 70,
    );

Widget get spaceH80 => const SizedBox(
      height: 80,
    );

Widget get spaceH90 => const SizedBox(
      height: 90,
    );

Widget get spaceH100 => const SizedBox(
      height: 100,
    );

Widget get spaceH130 => const SizedBox(
      height: 130,
    );

Widget get spaceH150 => const SizedBox(
      height: 150,
    );

Widget get spaceH180 => const SizedBox(
      height: 180,
    );

Widget get spaceH200 => const SizedBox(
      height: 200,
    );

Widget get spaceH250 => const SizedBox(
      height: 250,
    );

Widget get spaceH300 => const SizedBox(
      height: 300,
    );

Widget get spaceW3 => const SizedBox(
      width: 3,
    );

Widget get spaceW5 => const SizedBox(
      width: 5,
    );

Widget get spaceW10 => const SizedBox(
      width: 10,
    );

Widget get spaceW12 => const SizedBox(
      width: 12,
    );

Widget get spaceW15 => const SizedBox(
      width: 15,
    );

Widget get spaceW20 => const SizedBox(
      width: 20,
    );

Widget get spaceW22 => const SizedBox(
      width: 22,
    );

Widget get spaceW25 => const SizedBox(
      width: 25,
    );

Widget get spaceW30 => const SizedBox(
      width: 30,
    );

Widget get spaceW40 => const SizedBox(
      width: 30,
    );

Widget get spaceW50 => const SizedBox(
      width: 50,
    );

Widget get spaceW60 => const SizedBox(
      width: 60,
    );

Widget get spaceW65 => const SizedBox(
      width: 65,
    );

Widget get spaceW70 => const SizedBox(
      width: 70,
    );

Widget get spaceW80 => const SizedBox(
      width: 80,
    );

SizedBox buildDynamicHSpacer(BuildContext context, double height) => SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
