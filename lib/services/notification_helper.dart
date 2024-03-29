// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
// import 'package:reminder_app/models/task_model.dart';
// import 'package:reminder_app/screens/display_task.dart';
// import 'package:timezone/timezone.dart' as timeZone;
// import 'package:timezone/data/latest.dart' as tzdata;
// import 'package:get/get.dart';
//
// class NotificationHelper {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   initNotification() async {
//     _configLocalTimeZone();
//     final IOSInitializationSettings iosInitializationSettings =
//         IOSInitializationSettings(
//             requestAlertPermission: false,
//             requestBadgePermission: false,
//             defaultPresentSound: false,
//             onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     final AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@drawable/ic_launcher');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       iOS: iosInitializationSettings,
//       android: androidInitializationSettings,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: selectNotification);
//   }
//
//   void requestIOSPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   }
//
//   Future selectNotification(String? payload) async {
//     if (payload != null) {
//       print('$payload');
//     } else {
//       print('done');
//     }
//     Get.to(() => DisplayTask(
//           id: int.parse(payload.toString()),
//         ));
//   }
//
//   Future onDidReceiveLocalNotification(
//       int? id, String? title, String? content, String? payload) async {
//     Get.dialog(Text('Welcome'));
//   }
//
//   displayNotification({required String title, required String content}) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       '0', 'fvb', 'fbvb',
//       importance: Importance.max,
//       priority: Priority.high,
//       // Specify the PendingIntent flags here
//       additionalFlags: Int32List.fromList(<int>[
//         4,
//         64
//       ]), // Use FLAG_IMMUTABLE (value: 4) and FLAG_UPDATE_CURRENT (value: 64)
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//     flutterLocalNotificationsPlugin.show(
//       0,
//       '$title',
//       '$content',
//       platformChannelSpecifics,
//       payload: 'Default_Sound',
//     );
//   }
//
//   scheduledNotification({
//     required int hour,
//     required int minute,
//     required Task task, // New parameter added
//   }) async {
//     try {
//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         task.id!.toInt(),
//         task.title,
//         task.content,
//         _convertTime(hour, minute),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'channelId',
//             'channelName',
//             'channelDescription',
//             importance: Importance.max,
//             priority: Priority.high,
//           ),
//           iOS: IOSNotificationDetails(),
//         ),
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time,
//         payload: '${task.id}',
//         androidAllowWhileIdle: true,
//       );
//     } on Exception catch (e) {
//       // TODO
//       print("error :: $e");
//     }
//   }
//
//   timeZone.TZDateTime _convertTime(int hour, int minute) {
//     timeZone.TZDateTime now = timeZone.TZDateTime.now(timeZone.local);
//     timeZone.TZDateTime scheduledDate = timeZone.TZDateTime(
//         timeZone.local, now.year, now.month, now.day, hour, minute);
//     return scheduledDate;
//   }
//
//   Future<void> _configLocalTimeZone() async {
//     tzdata.initializeTimeZones();
//     final String locationName = await FlutterNativeTimezone.getLocalTimezone();
//     timeZone.setLocalLocation(timeZone.getLocation(locationName));
//   }
// }
