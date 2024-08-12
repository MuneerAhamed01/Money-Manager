import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:money_manager/services/notifications/schedule_notification_local.dart';
import 'package:timezone/data/latest_all.dart' show initializeTimeZones;
import 'package:timezone/timezone.dart'
    show setLocalLocation, getLocation, TZDateTime, local;

class ScheduleNotificationService {
  ScheduleNotificationService._internal();

  static final _instance = ScheduleNotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  static Future<ScheduleNotificationService?> getInstance(
      bool wantInstanceIfNotCreated) async {
    if (!_instance._initialized && wantInstanceIfNotCreated) {
      await _instance.initialize();
      return _instance;
    }
    return null;
  }

  static ScheduleNotificationService get instance {
    if (!_instance._initialized) {
      throw Exception('Please call [getInstance()] before call this');
    } else {
      return _instance;
    }
  }

  Future<void> initialize() async {
    initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    setLocalLocation(getLocation(timeZoneName));
    _initializeLocalNotification();
    _initialized = true;
  }

  Future<bool> _requestPermissions() async {
    bool? hasPermission;
    if (Platform.isIOS) {
      final IOSFlutterLocalNotificationsPlugin? iosImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>();
      hasPermission = await iosImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();
      hasPermission =
          await androidImplementation?.requestNotificationsPermission();
    }
    return hasPermission ?? false;
  }

  void _initializeLocalNotification() {
    try {
      AndroidInitializationSettings androidInitializationSettings =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      DarwinInitializationSettings iosInitializationSettings =
          const DarwinInitializationSettings();
      _flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        ),
        // onDidReceiveBackgroundNotificationResponse: onDidReceiveLocalNotification,
        onDidReceiveNotificationResponse: onDidReceiveLocalNotification,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> onDidReceiveLocalNotification(
      NotificationResponse response) async {}

  Future<void> scheduleDailyNotification(int id, TimeOfDay date,
      [bool forTesting = false]) async {
    try {
      if (!await _requestPermissions()) return;

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Hi! buddy',
        "Let's note down today's transaction",
        forTesting
            ? TZDateTime.now(local).add(const Duration(seconds: 1))
            : _scheduledDate(date),
        const NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          android: AndroidNotificationDetails(
            'Money Manager',
            'New Notification',
            importance: Importance.max,
            priority: Priority.max,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exact,
      );

      if (!forTesting) {
        ScheduleNotificationLocal.instance.storeSchedule(true);
      } else {
        Future.delayed(const Duration(seconds: 5)).then((_) {
          cancelNotification(id: 2);
        });
      }
    } catch (e) {
      log("e");
    }
  }

  TZDateTime _scheduledDate(TimeOfDay date) {
    TZDateTime scheduledDate = TZDateTime(
      local,
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
      date.hour,
      date.minute,
    );

    return scheduledDate;
  }

  Future<void> cancelNotification({int? id}) async {
    if (id != null) {
      await _flutterLocalNotificationsPlugin.cancel(id);
    } else {
      await _flutterLocalNotificationsPlugin.cancelAll();
    }
  }
}
