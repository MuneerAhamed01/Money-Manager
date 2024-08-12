import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/services/notifications/schedule_notification_service.dart';
import 'package:money_manager/utils/snackbar.dart';
import 'package:money_manager/widgets/button.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: Get.width,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Schedule your notification: ',
            style: Get.textTheme.titleMedium,
          ),
          const SizedBox(height: 30),
          Center(
            child: Image.network(
              'https://cdn.pixabay.com/photo/2015/12/16/17/41/bell-1096280_1280.png',
              scale: 10,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Schedule when you need to add your expense will remind you frequently',
            style: Get.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 48,
            child: AppButton(
              label: 'Schedule',
              style: AppButtonStyle.primary,
              onTap: () => _scheduleNotifciation(context),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 48,
            child: AppButton(
              label: 'Click here for a test notification',
              style: AppButtonStyle.textButton,
              onTap: () => _scheduleNotifciation(context, true),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _scheduleNotifciation(BuildContext context,
      [bool testNotificaton = false]) async {
    if (testNotificaton) {
      ScheduleNotificationService.instance
          .scheduleDailyNotification(2, TimeOfDay.now(), true);
      return;
    }
    final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (ctx, child) {
          return Theme(
              data: Get.theme.copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.black, // Header background color
                  onPrimary: Colors.white, // Header text color
                  onSurface: Colors.black, // Body text color
                  secondary: Colors.black.withOpacity(0.2),
                  // Selected date circle color
                ),
              ),
              child: child!);
        });

    if (time != null) {
      ScheduleNotificationService.instance
          .scheduleDailyNotification(1, time)
          .then((v) {
        Get.back();
        showSnackBar('Notificaton is scheduled', true);
      });
    }
  }
}
