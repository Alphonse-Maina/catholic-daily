import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import '../services/daily_verse_service.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  static const int _dailyVerseId = 100;

  // ---------------- INITIALIZE ----------------
  static Future<void> init() async {
    tz.initializeTimeZones();

    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(
      tz.getLocation(timezoneInfo.identifier),
    );

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings);

    // Request notification permission (Android 13+)
    await _notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // ---------------- LOAD VERSE ----------------
  static Future<Map<String, dynamic>> _getTodayVerse() async {
    final String jsonString =
    await rootBundle.loadString('lib/data/daily_verses.json');

    final List<dynamic> verses = json.decode(jsonString);

    final int index =
        DateTime.now().difference(DateTime(2024)).inDays %
            verses.length;

    return verses[index];
  }

  // ---------------- SCHEDULE DAILY ----------------
  static Future<void> scheduleNextDailyVerse({
    required int hour,
    required int minute,
  }) async {
    final verse = await DailyVerseService.getTodayVerse();

    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      _dailyVerseId,
      verse["reference"],
      verse["text"],
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_verse',
          'Daily Verse',
          channelDescription: 'Daily Bible verse reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // matchDateTimeComponents: DateTimeComponents.time,
      matchDateTimeComponents: null,
    );
    final pending = await _notifications.pendingNotificationRequests();
    print("Pending notifications: ${pending.length}");
  }

  // ---------------- CANCEL ----------------
  static Future<void> cancelDailyVerse() async {
    await _notifications.cancel(_dailyVerseId);
  }

  // ---------------- INSTANT TEST ----------------
  static Future<void> showInstantTest() async {
    await _notifications.show(
      999,
      "Test Notification",
      "If you see this, notifications work",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test',
          'Test',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}