import 'package:intl/intl.dart';

/// Returns start of today in local time (00:00:00) as epoch ms.
int startOfTodayMs() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
}

/// End of today 23:59:59.999 in local time as epoch ms.
int endOfTodayMs() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, 23, 59, 59, 999).millisecondsSinceEpoch;
}

/// Start of the day N days from today (e.g. +7 for next week same day).
int startOfDayFromTodayMs(int daysFromToday) {
  final now = DateTime.now();
  final d = DateTime(now.year, now.month, now.day).add(Duration(days: daysFromToday));
  return d.millisecondsSinceEpoch;
}

/// Human label for next ping: "Overdue by 2d", "Due today", "In 3d".
String nextPingLabel(int? nextPingAtMs) {
  if (nextPingAtMs == null) return 'No date';
  final now = DateTime.now();
  final next = DateTime.fromMillisecondsSinceEpoch(nextPingAtMs);
  final nextDay = DateTime(next.year, next.month, next.day);
  final todayDay = DateTime(now.year, now.month, now.day);
  final diffDays = nextDay.difference(todayDay).inDays;

  if (diffDays < 0) {
    final d = -diffDays;
    return d == 1 ? 'Overdue by 1d' : 'Overdue by ${d}d';
  }
  if (diffDays == 0) return 'Due today';
  if (diffDays == 1) return 'In 1d';
  return 'In ${diffDays}d';
}

final _dateFormat = DateFormat('yyyy-MM-dd');
final _dateDisplayFormat = DateFormat('MMM d, yyyy');

String formatDateYmd(DateTime d) => _dateFormat.format(d);
String formatDateDisplay(DateTime d) => _dateDisplayFormat.format(d);

String formatDateYmdFromMs(int ms) => _dateFormat.format(DateTime.fromMillisecondsSinceEpoch(ms));
