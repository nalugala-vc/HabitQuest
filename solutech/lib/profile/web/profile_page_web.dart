import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:solutech/common/constants.dart';
import 'package:solutech/common/widgets/nav_bar.dart';
import 'package:solutech/profile/widgets/profile_image_widget.dart';
import 'package:solutech/profile/widgets/profile_widgets.dart';
import 'package:solutech/streaks/web/streaks_web.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class ProfilePageWeb extends StatefulWidget {
  const ProfilePageWeb({super.key});

  @override
  State<ProfilePageWeb> createState() => _ProfilePageWebState();
}

class _ProfilePageWebState extends State<ProfilePageWeb> {
  @override
  Widget build(BuildContext context) {
    List<Color> profileColors = [
      Theme.of(context).colorScheme.primaryFixed,
      Theme.of(context).colorScheme.shadow,
      Theme.of(context).colorScheme.onSurface,
    ];
    return Scaffold(
        body: Row(
      children: [
        NavBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH20,
                  const ProfileImageWidget(
                    imageUrl: 'assets/icons/logo.png',
                    userName: 'Nalugala Venessa',
                  ),
                  spaceH20,
                  RobotoCondensed(
                    text: 'Account',
                    fontSize: 18,
                  ),
                  spaceH10,
                  ListView.separated(
                    separatorBuilder: (context, index) => spaceH15,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ProfileWidget(
                      bgColor: profileColors[index],
                      icon: accountIcons[index],
                      onTap: () {},
                      title: accountTitles[index],
                    ),
                    itemCount: accountIcons.length,
                  ),
                  spaceH20,
                  RobotoCondensed(
                    text: 'Customization',
                    fontSize: 18,
                  ),
                  spaceH10,
                  ListView.separated(
                    separatorBuilder: (context, index) => spaceH15,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ProfileWidget(
                      bgColor: profileColors[index],
                      icon: customizationIcons[index],
                      onTap: () {
                        if (index == 0) Get.toNamed('/theme-screen');
                      },
                      title: custimizationTitles[index],
                    ),
                    itemCount: custimizationTitles.length,
                  ),
                  spaceH20,
                  RobotoCondensed(
                    text: 'Support',
                    fontSize: 18,
                  ),
                  spaceH10,
                  ListView.separated(
                    separatorBuilder: (context, index) => spaceH15,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ProfileWidget(
                      bgColor: profileColors[index],
                      icon: supportIcons[index],
                      onTap: () {},
                      title: supportTitles[index],
                    ),
                    itemCount: supportIcons.length,
                  ),
                  spaceH15,
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: double.infinity,
          child: VerticalDivider(
            color: Theme.of(context).colorScheme.onSecondary,
            thickness: 1,
          ),
        ),
        Expanded(child: StreaksWeb()),
      ],
    ));
  }
}
