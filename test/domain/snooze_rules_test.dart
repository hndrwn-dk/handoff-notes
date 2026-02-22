import 'package:flutter_test/flutter_test.dart';
import 'package:handoff_notes/domain/snooze_rules.dart';

void main() {
  group('snoozeToNextBusinessDayAt09', () {
    test('Monday 08:00 -> same day 09:00', () {
      final monday8 = DateTime(2025, 2, 3, 8, 0).millisecondsSinceEpoch;
      final result = snoozeToNextBusinessDayAt09Default(monday8);
      final r = DateTime.fromMillisecondsSinceEpoch(result);
      expect(r.year, 2025);
      expect(r.month, 2);
      expect(r.day, 3);
      expect(r.hour, 9);
      expect(r.minute, 0);
    });

    test('Monday 09:00 -> same day 09:00', () {
      final monday9 = DateTime(2025, 2, 3, 9, 0).millisecondsSinceEpoch;
      final result = snoozeToNextBusinessDayAt09Default(monday9);
      final r = DateTime.fromMillisecondsSinceEpoch(result);
      expect(r.day, 3);
      expect(r.hour, 9);
    });

    test('Friday after 18:00 -> Monday 09:00', () {
      final fri18 = DateTime(2025, 1, 31, 18, 30).millisecondsSinceEpoch;
      final result = snoozeToNextBusinessDayAt09(
        fromMs: fri18,
        businessDays: [1, 2, 3, 4, 5],
        workStartHour: 9,
        workEndHour: 18,
      );
      final r = DateTime.fromMillisecondsSinceEpoch(result);
      expect(r.weekday, DateTime.monday);
      expect(r.hour, 9);
      expect(r.minute, 0);
      expect(r.day, 3);
      expect(r.month, 2);
    });

    test('Saturday -> Monday 09:00', () {
      final sat = DateTime(2025, 2, 1, 12, 0).millisecondsSinceEpoch;
      final result = snoozeToNextBusinessDayAt09(
        fromMs: sat,
        businessDays: [1, 2, 3, 4, 5],
        workStartHour: 9,
        workEndHour: 18,
      );
      final r = DateTime.fromMillisecondsSinceEpoch(result);
      expect(r.weekday, DateTime.monday);
      expect(r.hour, 9);
      expect(r.day, 3);
    });

    test('Sunday -> Monday 09:00', () {
      final sun = DateTime(2025, 2, 2, 10, 0).millisecondsSinceEpoch;
      final result = snoozeToNextBusinessDayAt09(
        fromMs: sun,
        businessDays: [1, 2, 3, 4, 5],
        workStartHour: 9,
        workEndHour: 18,
      );
      final r = DateTime.fromMillisecondsSinceEpoch(result);
      expect(r.weekday, DateTime.monday);
      expect(r.hour, 9);
      expect(r.day, 3);
    });
  });
}
