import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solutech/common/constants.dart';
import 'package:solutech/common/widgets/rounded_button.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

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
    if (_currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed('/sign-up');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onTertiary,
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
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final isSvg = pages[index]["isSvg"] == "true";
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: _buildImage(pages[index]["image"]!, isSvg),
                      ),
                      spaceH20,
                      RobotoCondensed(
                        text: pages[index]["title"]!,
                        fontSize: 24,
                        textColor: Theme.of(context).colorScheme.primary,
                      ),
                      spaceH10,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: RobotoCondensed(
                          text: pages[index]["description"]!,
                          textAlignment: TextAlign.center,
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.normal,
                          shouldTruncate: false,
                          fontSize: 17,
                        ),
                      ),
                      spaceH20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: _currentIndex == index ? 25 : 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSecondary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      spaceH50,
                      RoundedButton(
                        onPressed: _onNextPressed,
                        width: 300,
                        label: _currentIndex == pages.length - 1
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
