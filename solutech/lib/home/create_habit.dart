import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solutech/common/widgets/app_bar.dart';
import 'package:solutech/common/widgets/auth_field.dart';
import 'package:solutech/common/widgets/rounded_button.dart';
import 'package:solutech/home/controller/habit_controller.dart';
import 'package:solutech/models/habit.dart';
import 'package:solutech/utils/app_colors.dart';
import 'package:solutech/utils/fonts/roboto_condensed.dart';
import 'package:solutech/utils/spacers.dart';

class CreateHabit extends StatefulWidget {
  final Habit? habit;

  const CreateHabit({super.key, this.habit});

  @override
  State<CreateHabit> createState() => _CreateHabitState();
}

class _CreateHabitState extends State<CreateHabit> {
  final controller = Get.put(HabitController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.setHabitValues(widget.habit);
  }

  @override
  void dispose() {
    controller.clearFields();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.habit != null;

    return Scaffold(
      appBar: const MainAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RobotoCondensed(
              text: isEditing ? 'Edit Habit' : 'Create New Habit',
              fontSize: 32,
            ),
            spaceH30,
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthField(
                    controller: controller.title,
                    hintText: 'Title',
                  ),
                  spaceH15,
                  AuthField(
                    controller: controller.description,
                    fieldType: FieldType.description,
                    hintText: 'Description',
                  ),
                  spaceH15,
                  RobotoCondensed(
                    text: 'Goal',
                    fontSize: 18,
                  ),
                  spaceH15,
                  Row(
                    children: [
                      RobotoCondensed(
                        text: 'Daily',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        textColor: AppColors.grey600,
                      ),
                      spaceW20,
                      Obx(() => Switch(
                          value: controller.isDaily.value,
                          onChanged: (value) {
                            // Disable isWeekly if isDaily is set to true
                            if (value) {
                              controller.isWeekly.value = false;
                            }
                            controller.isDaily.value = value;
                          })),
                    ],
                  ),
                  spaceH15,
                  Row(
                    children: [
                      RobotoCondensed(
                        text: 'Weekly',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        textColor: AppColors.grey600,
                      ),
                      spaceW20,
                      Obx(() => Switch(
                          value: controller.isWeekly.value,
                          onChanged: (value) {
                            // Disable isDaily if isWeekly is set to true
                            if (value) {
                              controller.isWeekly.value = false;
                            }
                            controller.isWeekly.value = value;
                          })),
                    ],
                  ),
                  spaceH15,
                  RobotoCondensed(
                    text: 'Reminder',
                    fontSize: 18,
                  ),
                  spaceH15,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RobotoCondensed(
                            text: 'Has Reminder',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            textColor: AppColors.grey600,
                          ),
                          Obx(() => controller.hasReminder.value
                              ? RobotoCondensed(
                                  text: controller.reminderTime.value
                                          ?.format(context) ??
                                      'Not Selected',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                )
                              : RobotoCondensed(
                                  text: 'Not Selected',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                )),
                        ],
                      ),
                      spaceW20,
                      Obx(() => Switch(
                            value: controller.hasReminder.value,
                            onChanged: (value) {
                              controller.toggleHasReminder(value);
                              if (value) {
                                showTimePicker(
                                        context: context,
                                        initialTime:
                                            controller.reminderTime.value ??
                                                const TimeOfDay(
                                                    hour: 10, minute: 0))
                                    .then((time) {
                                  if (time != null) {
                                    controller.setReminderTime(time);
                                  }
                                });
                              }
                            },
                          ))
                    ],
                  ),
                  spaceH100,
                  RoundedButton(
                    label: isEditing ? 'Save Changes' : 'Create Habit',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (isEditing) {
                          controller.updateHabit(
                            habit: Habit(
                              id: widget.habit!.id,
                              isWeekly: controller.isWeekly.value,
                              completionStatus: widget.habit!.completionStatus,
                              createdAt: widget.habit!.createdAt,
                              createdBy: widget.habit!.createdBy,
                              title: controller.title.text.trim(),
                              description: controller.description.text.trim(),
                              isDaily: controller.isDaily.value,
                              hasReminder: controller.hasReminder.value,
                              reminderTime: controller.reminderTime.value
                                  ?.format(Get.context!),
                            ),
                          );
                        } else {
                          controller.onSave(
                            isWeekly: controller.isWeekly.value,
                            title: controller.title.text.trim(),
                            description: controller.description.text.trim(),
                            isDaily: controller.isDaily.value,
                            hasReminder: controller.hasReminder.value,
                            reminderTime: controller.reminderTime.value,
                          );
                        }
                        Navigator.pop(context); // Close the screen
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
