import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    await _notifications.initialize(settings);

    // Initialize timezone package (needed for scheduling)
    tz.initializeTimeZones();
  }

  static Future<void> showDailyVerseNotification({
    required String verse,
    required int hour,
    required int minute,
  }) async {
    await _notifications.zonedSchedule(
      0, // notification id
      'Daily Verse', // title
      verse, // body
      _nextInstanceOfTime(hour, minute), // scheduled time
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_verse_channel',
          'Daily Verse Notifications',
          channelDescription: 'Receive a daily verse reminder',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // required in v13
      matchDateTimeComponents: DateTimeComponents.time, // repeat daily
    );
  }



  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
