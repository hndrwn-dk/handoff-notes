import 'package:flutter_test/flutter_test.dart';
import 'package:handoff_notes/domain/enums.dart';
import 'package:handoff_notes/domain/next_ping_rules.dart';

void main() {
  group('nextPingIntervalMs', () {
    test('high priority returns 1 day in ms', () {
      expect(nextPingIntervalMs(FollowUpPriority.high), 1 * 24 * 60 * 60 * 1000);
    });
    test('medium priority returns 2 days in ms', () {
      expect(nextPingIntervalMs(FollowUpPriority.medium), 2 * 24 * 60 * 60 * 1000);
    });
    test('low priority returns 4 days in ms', () {
      expect(nextPingIntervalMs(FollowUpPriority.low), 4 * 24 * 60 * 60 * 1000);
    });
    test('respects custom highDays, medDays, lowDays', () {
      expect(
        nextPingIntervalMs(FollowUpPriority.high, highDays: 2),
        2 * 24 * 60 * 60 * 1000,
      );
      expect(
        nextPingIntervalMs(FollowUpPriority.medium, medDays: 3),
        3 * 24 * 60 * 60 * 1000,
      );
      expect(
        nextPingIntervalMs(FollowUpPriority.low, lowDays: 7),
        7 * 24 * 60 * 60 * 1000,
      );
    });
  });

  group('computeNextPingAtMs', () {
    test('adds interval to now for high', () {
      final now = 1000000;
      final next = computeNextPingAtMs(nowMs: now, priority: FollowUpPriority.high);
      expect(next - now, 1 * 24 * 60 * 60 * 1000);
    });
    test('adds interval to now for medium', () {
      final now = 1000000;
      final next = computeNextPingAtMs(nowMs: now, priority: FollowUpPriority.medium);
      expect(next - now, 2 * 24 * 60 * 60 * 1000);
    });
    test('adds interval to now for low', () {
      final now = 1000000;
      final next = computeNextPingAtMs(nowMs: now, priority: FollowUpPriority.low);
      expect(next - now, 4 * 24 * 60 * 60 * 1000);
    });
  });

  group('shouldShowEscalationIndicator', () {
    test('true when pingCount >= 3 and status waiting', () {
      expect(shouldShowEscalationIndicator(3, FollowUpStatus.waiting), true);
      expect(shouldShowEscalationIndicator(4, FollowUpStatus.waiting), true);
    });
    test('false when pingCount < 3', () {
      expect(shouldShowEscalationIndicator(2, FollowUpStatus.waiting), false);
      expect(shouldShowEscalationIndicator(0, FollowUpStatus.waiting), false);
    });
    test('false when status is not waiting', () {
      expect(shouldShowEscalationIndicator(3, FollowUpStatus.replied), false);
      expect(shouldShowEscalationIndicator(3, FollowUpStatus.closed), false);
    });
  });
}
