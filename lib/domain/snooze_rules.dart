/// Business days: 1 = Monday, 7 = Sunday. Default Mon-Fri = [1,2,3,4,5].
/// [weekday] 1 = Monday, 7 = Sunday (DateTime.weekday).
/// [workStartHour] default 9, [workEndHour] default 18 (24h).
/// Returns next business day at 09:00 as milliseconds since epoch (local interpretation).
int snoozeToNextBusinessDayAt09({
  required int fromMs,
  required List<int> businessDays,
  int workStartHour = 9,
  int workEndHour = 18,
}) {
  if (businessDays.isEmpty) businessDays = [1, 2, 3, 4, 5];
  final from = DateTime.fromMillisecondsSinceEpoch(fromMs);
  final today = DateTime(from.year, from.month, from.day);
  final weekday = from.weekday;
  final hour = from.hour;
  final minute = from.minute;
  final minuteOfDay = hour * 60 + minute;
  final workEndMinute = workEndHour * 60;
  final workStartMinute = workStartHour * 60;

  DateTime next = today;
  if (businessDays.contains(weekday)) {
    if (minuteOfDay < workStartMinute) {
      next = DateTime(today.year, today.month, today.day, workStartHour, 0);
      return next.millisecondsSinceEpoch;
    }
    if (minuteOfDay >= workEndMinute) {
      next = today.add(const Duration(days: 1));
    } else {
      next = DateTime(today.year, today.month, today.day, workStartHour, 0);
      return next.millisecondsSinceEpoch;
    }
  }

  while (true) {
    if (businessDays.contains(next.weekday)) {
      next = DateTime(next.year, next.month, next.day, workStartHour, 0);
      return next.millisecondsSinceEpoch;
    }
    next = next.add(const Duration(days: 1));
  }
}

/// Convenience: default Mon-Fri, 09:00-18:00.
int snoozeToNextBusinessDayAt09Default(int fromMs) {
  return snoozeToNextBusinessDayAt09(
    fromMs: fromMs,
    businessDays: [1, 2, 3, 4, 5],
    workStartHour: 9,
    workEndHour: 18,
  );
}
