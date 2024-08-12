import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/screens/settings/settings_controller.dart';
import 'package:money_manager/services/notifications/schedule_notification_service.dart';
import 'package:money_manager/utils/snackbar.dart';

class SettingsScreen extends GetView<SettingsController> {
  static String routeName = '/settings';
  const SettingsScreen({super.key});

  List<String> get mySettings =>
      ['Change Notifcation time', 'Add Test Transaction'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.black,
        title: Text(
          'Settings',
          style: Get.textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: mySettings.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              if (index == 0) {
                _scheduleNotifciation(context);
              } else {
                controller.addBulktransactions();
              }
            },
            title: Text(mySettings[index]),
            subtitle: Text(
              index == 0
                  ? 'Change your Notification Time as you need'
                  : 'Add Test transactions (25 Transaction) for smooth testing',
              style: Get.textTheme.labelSmall
                  ?.copyWith(color: Get.theme.colorScheme.outline),
            ),
          );
        },
      ),
    );
  }

  Future<void> _scheduleNotifciation(
    BuildContext context,
  ) async {
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
        showSnackBar('Notificaton time is changed', true);
      });
    }
  }
}
