import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ScheduleNotificationLocal extends GetxService {
  static ScheduleNotificationLocal instance =
      Get.find<ScheduleNotificationLocal>();

  late bool _isScheduled;

  bool get scheduled => _isScheduled;

  late Box notificationBox;

  Future<ScheduleNotificationLocal> init() async {
    notificationBox = await Hive.openBox('notification');
    _isScheduled = notificationBox.get('is-scheduled', defaultValue: false);
    return this;
  }

  Future<void> storeSchedule(bool value,) async {
    _isScheduled = value;
    await notificationBox.put('is-scheduled', value);
    await notificationBox.put('is-scheduled', value);

  }
}
