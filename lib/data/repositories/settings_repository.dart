import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const _keyWorkStartHour = 'work_start_hour';
const _keyWorkEndHour = 'work_end_hour';
const _keyBusinessDays = 'business_days';
const _keyDailySummaryEnabled = 'daily_summary_enabled';
const _keyPerItemNotificationsEnabled = 'per_item_notifications_enabled';
const _keyIntervalHighDays = 'interval_high_days';
const _keyIntervalMedDays = 'interval_med_days';
const _keyIntervalLowDays = 'interval_low_days';

class SettingsRepository {
  SettingsRepository(this._prefs);

  final SharedPreferences _prefs;

  int get workStartHour => _prefs.getInt(_keyWorkStartHour) ?? 9;
  set workStartHour(int v) => _prefs.setInt(_keyWorkStartHour, v);

  int get workEndHour => _prefs.getInt(_keyWorkEndHour) ?? 18;
  set workEndHour(int v) => _prefs.setInt(_keyWorkEndHour, v);

  List<int> get businessDays {
    final s = _prefs.getString(_keyBusinessDays);
    if (s == null) return [1, 2, 3, 4, 5];
    final list = jsonDecode(s) as List<dynamic>?;
    return list?.map((e) => (e as num).toInt()).toList() ?? [1, 2, 3, 4, 5];
  }

  set businessDays(List<int> v) => _prefs.setString(_keyBusinessDays, jsonEncode(v));

  bool get dailySummaryEnabled => _prefs.getBool(_keyDailySummaryEnabled) ?? true;
  set dailySummaryEnabled(bool v) => _prefs.setBool(_keyDailySummaryEnabled, v);

  bool get perItemNotificationsEnabled => _prefs.getBool(_keyPerItemNotificationsEnabled) ?? true;
  set perItemNotificationsEnabled(bool v) => _prefs.setBool(_keyPerItemNotificationsEnabled, v);

  int get intervalHighDays => _prefs.getInt(_keyIntervalHighDays) ?? 1;
  set intervalHighDays(int v) => _prefs.setInt(_keyIntervalHighDays, v);

  int get intervalMedDays => _prefs.getInt(_keyIntervalMedDays) ?? 2;
  set intervalMedDays(int v) => _prefs.setInt(_keyIntervalMedDays, v);

  int get intervalLowDays => _prefs.getInt(_keyIntervalLowDays) ?? 4;
  set intervalLowDays(int v) => _prefs.setInt(_keyIntervalLowDays, v);
}
