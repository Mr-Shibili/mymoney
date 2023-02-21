import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:timezone/timezone.dart' as tz;

import 'package:timezone/data/latest_10y.dart' as ts;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initialiseNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max));
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? playload}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future periodicalshowNotification(
      {ctx, int id = 0, String? title, String? body, String? playload}) async {
    TimeOfDay initTime = TimeOfDay.now();
    ts.initializeTimeZones();
    final now = DateTime.now();
    TimeOfDay? time;

    final picked = await showTimePicker(context: ctx, initialTime: initTime);
    if (picked != null) {
      time = picked;
    }
    final scheduleTime =
        DateTime(now.year, now.month, now.day, time!.hour, time.minute, 0);
    if (scheduleTime.isBefore(now)) {
      scheduleTime.add(const Duration(days: 1));
    }

    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 1)),
        notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future stopNotification() async {
    notificationsPlugin.cancel(0);
  }
}
