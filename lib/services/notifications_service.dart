import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../data/database/app_database.dart';

class NotificationsService {
  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static const _channelId = 'handoff_followups';
  static const _dailyChannelId = 'handoff_daily';

  static Future<void> initialize(AppDatabase db) async {
    tz_data.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation('UTC'));
    } catch (_) {
      // Fallback: UTC if device zone unavailable
    }
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: android);
    await _plugin.initialize(initSettings, onDidReceiveNotificationResponse: _onSelect);
    if (Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
        _channelId,
        'Follow-up reminders',
        description: 'Notifications when a follow-up is due',
        importance: Importance.defaultImportance,
      ));
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
        _dailyChannelId,
        'Daily summary',
        description: 'Daily summary of overdue and due today',
        importance: Importance.low,
      ));
    }
    await scheduleDailySummaryIfEnabled();
  }

  static void _onSelect(NotificationResponse? response) {}

  static Future<void> scheduleDailySummaryIfEnabled() async {
    final local = tz.local;
    final now = tz.TZDateTime.now(local);
    var scheduled = tz.TZDateTime(local, now.year, now.month, now.day, 9, 0);
    if (scheduled.isBefore(now)) scheduled = scheduled.add(const Duration(days: 1));
    await _plugin.zonedSchedule(
      0,
      'Handoff Notes',
      'Daily summary',
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _dailyChannelId,
          'Daily summary',
          channelDescription: 'Daily summary of overdue and due today',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> showDailySummary({required int overdueCount, required int dueTodayCount}) async {
    await _plugin.show(
      0,
      'Handoff Notes',
      'Overdue: $overdueCount, Due today: $dueTodayCount',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _dailyChannelId,
          'Daily summary',
          channelDescription: 'Daily summary',
        ),
      ),
    );
    await scheduleDailySummaryIfEnabled();
  }

  static Future<void> scheduleFollowUpNotification(String followUpId, int nextPingAtMs) async {
    final id = followUpId.hashCode.abs() % 0x7FFFFFFF;
    final dt = DateTime.fromMillisecondsSinceEpoch(nextPingAtMs);
    final local = tz.local;
    final tzDt = tz.TZDateTime.from(dt, local);
    if (tzDt.isBefore(tz.TZDateTime.now(local))) return;
    await _plugin.zonedSchedule(
      id,
      'Follow-up due',
      'A follow-up is due',
      tzDt,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'Follow-up reminders',
          channelDescription: 'When a follow-up is due',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelFollowUpNotification(String followUpId) async {
    final id = followUpId.hashCode.abs() % 0x7FFFFFFF;
    await _plugin.cancel(id);
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
