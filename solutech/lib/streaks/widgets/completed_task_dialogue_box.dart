import 'package:flutter/material.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

void completedTaskDialogue({
  required BuildContext context,
  required int completedTasks,
  required String formattedDate,
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
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: (completedTasks > 0)
                          ? AssetImage('assets/images/happy.png')
                          : AssetImage('assets/images/sad.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              spaceH10,
              RobotoCondensed(
                text: (completedTasks > 0)
                    ? 'You completed $completedTasks tasks on $formattedDate'
                    : 'You did not complete any task on $formattedDate',
                fontSize: 16,
                fontWeight: FontWeight.w700,
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
