import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reminder_app/app_themes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reminder_app/app_themes.dart';
import 'package:reminder_app/database_service/sql_service.dart';
import 'package:reminder_app/screens/splash_screen.dart';
import 'package:reminder_app/services/dark_theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlServices.initDatabase();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // runApp(DevicePreview(builder: (context)=>const MyApp()));
  runApp(MyApp());
}

void getPermission() async {
  var status = await Permission.notification.request();
  if (status.isGranted) {
    log("-=-0980-=09870-");
  } else if (status.isDenied) {
    log("-=-0980-987690-987690-987690-");
    openAppSettings();
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Title text',
      //builder:DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightMode,
      themeMode: ThemeService().theme,
      darkTheme: AppThemes.darkMode,
      home: SplashScreen(),
    );
  }
}
