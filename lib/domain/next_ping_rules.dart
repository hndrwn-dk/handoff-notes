import 'enums.dart';

const int _msPerDay = 24 * 60 * 60 * 1000;

/// Interval in milliseconds for next ping by priority.
/// Defaults: High: 1 day, Medium: 2 days, Low: 4 days.
int nextPingIntervalMs(FollowUpPriority priority, {int? highDays, int? medDays, int? lowDays}) {
  int days;
  switch (priority) {
    case FollowUpPriority.high:
      days = highDays ?? 1;
      break;
    case FollowUpPriority.medium:
      days = medDays ?? 2;
      break;
    case FollowUpPriority.low:
      days = lowDays ?? 4;
      break;
  }
  return days * _msPerDay;
}

/// Computes nextPingAt when user taps "Pinged Now".
/// - lastPingAt = now
/// - pingCount += 1
/// - nextPingAt = now + interval(priority)
/// If never pinged (lastPingAt null), nextPingAt was set at creation to createdAt
/// so item appears immediately; after first ping we use now + interval.
int computeNextPingAtMs({
  required int nowMs,
  required FollowUpPriority priority,
  int? previousPingCount,
  int? highDays,
  int? medDays,
  int? lowDays,
}) {
  return nowMs + nextPingIntervalMs(priority, highDays: highDays, medDays: medDays, lowDays: lowDays);
}

/// Returns true if item should show "Consider escalate" (pingCount >= 3 and status = waiting).
bool shouldShowEscalationIndicator(int pingCount, FollowUpStatus status) {
  return pingCount >= 3 && status == FollowUpStatus.waiting;
}
