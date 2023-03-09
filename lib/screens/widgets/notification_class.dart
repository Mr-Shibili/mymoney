// import 'package:flutter/material.dart';
// import 'package:timezone/browser.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_10y.dart' as ts;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationServices {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   // Future<void> initialiseNotification() async {
//   //   AndroidInitializationSettings androidInitializationSettings =
//   //       const AndroidInitializationSettings('mipmap/ic_launcher');
//   //   var initializationSettings =
//   //       InitializationSettings(android: androidInitializationSettings);
//   //   await notificationsPlugin.initialize(
//   //     initializationSettings,
//   //     onDidReceiveNotificationResponse:
//   //         (NotificationResponse notificationResponse) async {},
//   //   );mymoney => package:timezone => dart:html
//   // }

//   notificationDetails() {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails('channelId', 'channelName',
//             importance: Importance.max));
//   }

//   // Future showNotification(
//   //     {int id = 0, String? title, String? body, String? playload}) async {
//   //   return notificationsPlugin.show(
//   //       id, title, body, await notificationDetails());
//   // }

//   // Future periodicalshowNotification(
//   //     {ctx, int id = 0, String? title, String? body}) async {
//   //   ts.initializeTimeZones();
//   //   TimeOfDay initTime = const TimeOfDay(hour: 22, minute: 0);

//   //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//   //   TZDateTime? scheduleTime;

//   //   var picked = await showTimePicker(context: ctx, initialTime: initTime);
//   //   if (picked != null) {
//   //     scheduleTime = tz.TZDateTime(tz.local, now.year, now.month, now.month,
//   //         now.day, picked.hour, picked.minute);
//   //   }

//   //   return notificationsPlugin.zonedSchedule(
//   //       id, title, body, scheduleTime!, notificationDetails(),
//   //       uiLocalNotificationDateInterpretation:
//   //           UILocalNotificationDateInterpretation.absoluteTime,
//   //       androidAllowWhileIdle: true);
//   // }

//   Future stopNotification() async {
//     notificationsPlugin.cancel(0);
//   }
// }
