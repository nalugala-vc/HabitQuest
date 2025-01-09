import 'package:flutter/material.dart';
import 'package:solutech/common/widgets/rounded_button.dart';

import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

void confirmDialogue(
    {required BuildContext context,
    required String label,
    required String icon,
    required String message,
    required VoidCallback onConfirm}) {
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
                        image: AssetImage(icon), fit: BoxFit.cover),
                  ),
                ),
              ),
              spaceH10,
              RobotoCondensed(
                text: message,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                textColor: Theme.of(context).colorScheme.onTertiaryFixed,
              ),
              spaceH10,
              RoundedButton(
                onPressed: () {
                  onConfirm();

                  Navigator.of(context).pop();
                },
                label: label,
                width: 364,
                height: 38,
              ),
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
