import 'package:flutter/material.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

void errorDialogue({
  required BuildContext context,
  required bool isCompleted,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onSecondaryFixed,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: RobotoCondensed(
                  text: 'OOPS!',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  textColor: Theme.of(context).colorScheme.onTertiaryFixed,
                  shouldTruncate: false,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/warning.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              spaceH10,
              RobotoCondensed(
                text: isCompleted
                    ? 'You can only mark habits as completed for today!'
                    : 'You can only unmark habits as not completed for today!',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: Theme.of(context).colorScheme.onTertiaryFixed,
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
