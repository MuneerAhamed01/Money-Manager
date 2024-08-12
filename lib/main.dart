import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/user.dart';
import 'package:money_manager/screens/auth/auth_screen.dart';
import 'package:money_manager/screens/dashboard/dashbaord_screen.dart';
import 'package:money_manager/services/auth/firebase_auth.dart';
import 'package:money_manager/services/database/transactions.dart';
import 'package:money_manager/services/notifications/schedule_notification_local.dart';
import 'package:money_manager/services/notifications/schedule_notification_service.dart';
import 'package:money_manager/services/routes/routes.dart';
import 'package:money_manager/themes/colors.dart';
import 'package:money_manager/themes/decoration_theme.dart';
import 'package:money_manager/themes/fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  tz.initializeTimeZones();

  await Get.putAsync(() => TransactionsDataRepostiory().onInit());
  await Get.putAsync(() => ScheduleNotificationLocal().init());
  await ScheduleNotificationService.getInstance(true);

  final loggedIn = await AuthService.instance.getCurrentUserDetails();

  // ScheduleNotificationLocal.instance.storeSchedule(false);

  UserEntity? user;
  if (loggedIn.isRight && loggedIn.right != null) {
    user = loggedIn.right;
  }

  runApp(MyApp(loggedUser: user));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.loggedUser});

  final UserEntity? loggedUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Money Manager',
      getPages: Routes.instance.getGetXPages(),
      initialRoute:
          loggedUser == null ? AuthScreen.routeName : DashbaordScreen.routeName,
      theme: ThemeData(
        colorScheme: const AppColors(),
        fontFamily: AppTextTheme.fontFamily,
        textTheme: AppTextTheme.instance,
        useMaterial3: true,
        inputDecorationTheme: AppInputDecorationTheme(),
      ),
    );
  }
}
