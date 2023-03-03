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
      {ctx, int id = 0, String? title, String? body}) async {
    TimeOfDay initTime = const TimeOfDay(hour: 22, minute: 0);
    // ts.initializeTimeZones();
    final now = DateTime.now();
    var scheduleTime;

    final picked = await showTimePicker(context: ctx, initialTime: initTime);
    if (picked != null) {
      scheduleTime =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute, 0);
    }

    return notificationsPlugin.zonedSchedule(id, title, body,
        _nextInstanceOfScheduledTime(scheduleTime), notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  tz.TZDateTime _nextInstanceOfScheduledTime(DateTime scheduledDateTime) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        scheduledDateTime.year,
        scheduledDateTime.month,
        scheduledDateTime.day,
        scheduledDateTime.hour,
        scheduledDateTime.minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  Future stopNotification() async {
    notificationsPlugin.cancel(0);
  }
}
