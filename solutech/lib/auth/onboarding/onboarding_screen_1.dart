import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solutech/auth/mobile/sign_up.dart';
import 'package:solutech/common/widgets/rounded_button.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      "title": "Habit Quest",
      "description":
          "Embark on a quest to build better habits and transform your life with small daily steps. Unlock your potential and achieve your dreams.",
      "image": "assets/icons/logo.png",
      "isSvg": "false"
    },
    {
      "title": "Manage Your Daily Habits",
      "description":
          "Keep your streaks alive by completing daily tasks. Build momentum and achieve big goals with consistent habits.",
      "image": "assets/images/events.svg",
      "isSvg": "true"
    },
    {
      "title": "Challenge Yourself!",
      "description":
          "Take on 30-day challenges to set new goals and push your limits. Discover what you're truly capable of!",
      "image": "assets/images/winners.svg",
      "isSvg": "true"
    }
  ];

  Widget _buildImage(String imagePath, bool isSvg) {
    if (isSvg) {
      return SvgPicture.asset(
        imagePath,
        height: 150,
        width: 150,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        imagePath,
        height: 150,
        width: 150,
        fit: BoxFit.contain,
      );
    }
  }

  void _onNextPressed() {
    if (_currentIndex < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAll(() => const SignUpMobile());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple100,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final isSvg = _pages[index]["isSvg"] == "true";
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: AppColors.purple500,
                        child: _buildImage(_pages[index]["image"]!, isSvg),
                      ),
                      spaceH20,
                      RobotoCondensed(
                        text: _pages[index]["title"]!,
                        fontSize: 24,
                        textColor: AppColors.purple500,
                      ),
                      spaceH10,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: RobotoCondensed(
                          text: _pages[index]["description"]!,
                          textAlignment: TextAlign.center,
                          textColor: AppColors.grey600,
                          fontWeight: FontWeight.normal,
                          shouldTruncate: false,
                          fontSize: 17,
                        ),
                      ),
                      spaceH20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: _currentIndex == index ? 25 : 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? AppColors.purple500
                                  : Colors.grey[350],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      spaceH50,
                      RoundedButton(
                        onPressed: _onNextPressed,
                        width: 300,
                        label: _currentIndex == _pages.length - 1
                            ? "Get Started"
                            : "Next",
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
