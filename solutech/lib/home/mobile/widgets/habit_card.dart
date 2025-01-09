import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class HabitCard extends StatelessWidget {
  final String title;
  final String description;
  final double progress;
  final String habitId;
  final bool isCompleted;
  final DateTime date;
  final Function(BuildContext)? editTapped;
  final Function(BuildContext)? deleteTapped;
  final Function(bool?)? onChanged;
  const HabitCard(
      {super.key,
      required this.date,
      required this.habitId,
      required this.isCompleted,
      required this.progress,
      required this.description,
      required this.onChanged,
      required this.deleteTapped,
      required this.editTapped,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [
        SlidableAction(
          onPressed: editTapped,
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          icon: Icons.edit,
          borderRadius: BorderRadius.circular(12),
        ),
        SlidableAction(
          onPressed: deleteTapped,
          backgroundColor: Theme.of(context).colorScheme.error,
          icon: Icons.delete,
          borderRadius: BorderRadius.circular(12),
        )
      ]),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            gradient: LinearGradient(
              colors: isCompleted
                  ? [
                      Theme.of(context).colorScheme.onTertiary,
                      Theme.of(context).colorScheme.onSurface,
                    ]
                  : [
                      Theme.of(context).colorScheme.shadow,
                      Theme.of(context).colorScheme.secondary,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSecondary,
                blurRadius: 16,
              ),
            ]),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Checkbox(value: isCompleted, onChanged: onChanged),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RobotoCondensed(
                      text: title,
                      fontSize: 16,
                    ),
                    Row(
                      children: [
                        HeroIcon(
                          HeroIcons.pencil,
                          style: HeroIconStyle.outline,
                          color:
                              Theme.of(context).colorScheme.secondaryFixedDim,
                        ),
                        spaceW5,
                        RobotoCondensed(
                          text: description,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          textColor:
                              Theme.of(context).colorScheme.secondaryFixedDim,
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
