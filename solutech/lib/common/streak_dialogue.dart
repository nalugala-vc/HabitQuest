import 'package:flutter/material.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

void streakDialogue({
  required BuildContext context,
  required String title,
  required bool isUnlocked, // Add isUnlocked as a parameter
}) {
  // Define a map for the titles and corresponding base messages
  Map<String, String> titleMessages = {
    "DAY ONE DONE": "your 1st habit",
    "TRIPLE THREAT": "3 day streak",
    "HIGH FIVE": "5 day streak",
    "WEEKLY WARRIOR": "7 day streak",
    "PERFECT TEN": "10 day streak",
    "FIFTEEN FORTITUDE": "15 day streak",
    "TWENTY TROOPER": "20 day streak",
    "MONTHLY MARVEL": "30 day streak",
    "TRIPLE TRIUMPH": "a total of 3 habits",
    "TENACIOUS TEN": "50 total habits",
    "THIRTY THRIVER": "30 total habits",
    "HABIT HERO": "100 total habits",
  };

  // Fetch the base message for the title
  String baseMessage = titleMessages[title] ??
      "Title not found"; // Default message if the title is not found

  // Customize the message based on isUnlocked
  String message = isUnlocked
      ? "You completed $baseMessage!"
      : "Complete $baseMessage to unlock this badge";

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: RobotoCondensed(
                  text: title,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.grey900,
                  shouldTruncate: false,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: isUnlocked
                          ? const AssetImage('assets/images/happy.png')
                          : const AssetImage('assets/images/warning.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              spaceH10,
              RobotoCondensed(
                text: message,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: AppColors.grey900,
                shouldTruncate: false,
              ),
              spaceH10,
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      );
    },
  );
}
