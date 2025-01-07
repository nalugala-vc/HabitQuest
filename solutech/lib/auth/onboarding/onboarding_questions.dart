import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:solutech/common/constants.dart';
import 'package:solutech/common/widgets/rounded_button.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class OnboardingQuestions extends StatefulWidget {
  @override
  _OnboardingQuestionsState createState() => _OnboardingQuestionsState();
}

class _OnboardingQuestionsState extends State<OnboardingQuestions> {
  int _currentIndex = 0;
  final Map<String, dynamic> _userAnswers = {
    "wake_up_time": null,
    "bed_time": null,
    "motivation": null,
    "challenges": null,
    "reminders": null,
  };

  final PageController _controller = PageController();

  void _onNextPressed() {
    final currentQuestionKey = questions[_currentIndex]["key"];
    if (_userAnswers[currentQuestionKey] == null) {
      // Show a message or do something if the user hasn't selected a choice
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select an option before proceeding.')),
      );
      return;
    }

    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      print("User Answers: $_userAnswers");
      Get.offAllNamed('/homepage');
    }
  }

  void _onChoiceSelected(String key, String choice) {
    setState(() {
      _userAnswers[key] = choice;
    });
  }

  Widget _buildTimePicker(String key) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RobotoCondensed(
            text: questions[_currentIndex]['question'],
            fontSize: 24,
            textAlignment: TextAlign.center,
            shouldTruncate: false,
          ),
          spaceH20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    perspective: 0.003,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _userAnswers[key] = {
                          "hour": (index % 12) + 1,
                          "minute": _userAnswers[key]?["minute"] ?? 0,
                          "period": _userAnswers[key]?["period"] ?? "AM"
                        };
                      });
                    },
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final hour = (index % 12) + 1;
                        return Center(
                            child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: _userAnswers[key]?["hour"] == hour
                                ? AppColors.purple100
                                : Colors
                                    .transparent, // Light purple background for selected item
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: RobotoCondensed(
                            text: hour.toString().padLeft(2, '0'),
                            fontSize: 24,
                            textColor: _userAnswers[key]?["hour"] == hour
                                ? AppColors.purple600
                                : Colors.grey,
                          ),
                        ));
                      },
                      childCount: 12,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    perspective: 0.003,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _userAnswers[key] = {
                          "hour": _userAnswers[key]?["hour"] ?? 1,
                          "minute": index,
                          "period": _userAnswers[key]?["period"] ?? "AM"
                        };
                      });
                    },
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        if (index >= 0 && index < 60) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: _userAnswers[key]?["minute"] == index
                                    ? AppColors.purple100
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: RobotoCondensed(
                                text: index.toString().padLeft(2, '0'),
                                fontSize: 24,
                                textColor: _userAnswers[key]?["minute"] == index
                                    ? AppColors.purple600
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }
                        return null;
                      },
                      childCount: 60,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 150,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    perspective: 0.003,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _userAnswers[key] = {
                          "hour": _userAnswers[key]?["hour"] ?? 1,
                          "minute": _userAnswers[key]?["minute"] ?? 0,
                          "period": index == 0 ? "AM" : "PM"
                        };
                      });
                    },
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        final period = index == 0 ? "AM" : "PM";
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: _userAnswers[key]?["period"] == period
                                  ? AppColors.purple100
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: RobotoCondensed(
                              text: period,
                              fontSize: 24,
                              textColor: _userAnswers[key]?["period"] == period
                                  ? AppColors.purple600
                                  : Colors.grey,
                            ),
                          ),
                        );
                      },
                      childCount: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          spaceH150,
          RoundedButton(
            onPressed: _userAnswers[key] == null ? () {} : _onNextPressed,
            label: 'Next',
            width: 200,
          )
        ],
      ),
    );
  }

  Widget _buildChoiceQuestion(String key, List<String> choices) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RobotoCondensed(
            text: questions[_currentIndex]['question'],
            fontSize: 24,
            textAlignment: TextAlign.center,
            shouldTruncate: false,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: choices.map((choice) {
            final isSelected = _userAnswers[key] == choice;
            return GestureDetector(
              onTap: () => _onChoiceSelected(key, choice),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? AppColors.purple600 : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: isSelected ? AppColors.purple600 : Colors.grey,
                    ),
                    spaceW10,
                    RobotoCondensed(
                      text: choice,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        spaceH150,
        RoundedButton(
          onPressed: _userAnswers[key] == null ? () {} : _onNextPressed,
          label: 'Next',
          width: 200,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentIndex + 1) / questions.length;
    return Scaffold(
      body: Column(
        children: [
          spaceH20,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 40,
            ),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: AppColors.purple500,
              minHeight: 7,
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                _currentIndex = index;
                final question = questions[index];
                if (question["type"] == "time") {
                  return _buildTimePicker(question["key"]);
                } else if (question["type"] == "choice") {
                  return _buildChoiceQuestion(
                      question["key"], question["choices"]);
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
