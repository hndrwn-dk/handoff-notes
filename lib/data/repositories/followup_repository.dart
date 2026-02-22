import 'package:drift/drift.dart';
import '../../domain/enums.dart';
import '../../domain/next_ping_rules.dart';
import '../../domain/snooze_rules.dart';
import '../database/app_database.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class FollowUpRepository {
  FollowUpRepository(this._db);

  final AppDatabase _db;

  Future<List<FollowUp>> getActiveSortedByNextPing() async {
    return _db.watchFollowUpsByNextPing();
  }

  Future<List<FollowUp>> getOverdue(int nowMs) async {
    final all = await _db.watchFollowUpsByNextPing();
    return all.where((f) => f.status == 'waiting' && f.nextPingAt != null && f.nextPingAt! < nowMs).toList();
  }

  Future<List<FollowUp>> getDueToday(int startMs, int endMs) async {
    final all = await _db.watchFollowUpsByNextPing();
    return all.where((f) {
      if (f.status != 'waiting' || f.nextPingAt == null) return false;
      final n = f.nextPingAt!;
      return n >= startMs && n <= endMs;
    }).toList();
  }

  Future<List<FollowUp>> getUpcomingNext7Days(int endOfTodayMs, int endOfPlus7Ms) async {
    final all = await _db.watchFollowUpsByNextPing();
    return all.where((f) {
      if (f.status != 'waiting' || f.nextPingAt == null) return false;
      final n = f.nextPingAt!;
      return n > endOfTodayMs && n <= endOfPlus7Ms;
    }).toList();
  }

  Future<FollowUp?> getById(String id) => _db.getFollowUp(id);

  Future<String> addFollowUp({
    required String title,
    required String waitingOnName,
    String? waitingOnOrg,
    String channel = 'teams',
    String priority = 'medium',
    String status = 'waiting',
    String? notes,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = _uuid.v4();
    await _db.insertFollowUp(FollowUpsCompanion(
      id: Value(id),
      title: Value(title),
      waitingOnName: Value(waitingOnName),
      waitingOnOrg: Value(waitingOnOrg),
      channel: Value(channel),
      priority: Value(priority),
      status: Value(status),
      notes: Value(notes),
      createdAt: Value(now),
      updatedAt: Value(now),
      lastPingAt: const Value.absent(),
      nextPingAt: Value(now),
      pingCount: const Value(0),
    ));
    await _db.insertEvent(EventsCompanion(
      id: Value(_uuid.v4()),
      followupId: Value(id),
      type: const Value('created'),
      at: Value(now),
    ));
    return id;
  }

  Future<void> updateFollowUp({
    required String id,
    String? title,
    String? waitingOnName,
    String? waitingOnOrg,
    String? channel,
    String? priority,
    String? status,
    String? notes,
  }) async {
    final existing = await _db.getFollowUp(id);
    if (existing == null) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.updateFollowUp(FollowUpsCompanion(
      id: Value(id),
      title: title != null ? Value(title) : Value(existing.title),
      waitingOnName: waitingOnName != null ? Value(waitingOnName) : Value(existing.waitingOnName),
      waitingOnOrg: waitingOnOrg != null ? Value(waitingOnOrg) : Value(existing.waitingOnOrg),
      channel: channel != null ? Value(channel) : Value(existing.channel),
      priority: priority != null ? Value(priority) : Value(existing.priority),
      status: status != null ? Value(status) : Value(existing.status),
      notes: notes != null ? Value(notes) : Value(existing.notes),
      createdAt: Value(existing.createdAt),
      updatedAt: Value(now),
      lastPingAt: Value(existing.lastPingAt),
      nextPingAt: Value(existing.nextPingAt),
      pingCount: Value(existing.pingCount),
    ));
    await _db.insertEvent(EventsCompanion(
      id: Value(_uuid.v4()),
      followupId: Value(id),
      type: const Value('edited'),
      at: Value(now),
    ));
  }

  Future<void> pingedNow(
    String id, {
    required void Function(int?) onNextPingAt,
    int? highDays,
    int? medDays,
    int? lowDays,
  }) async {
    final f = await _db.getFollowUp(id);
    if (f == null || f.status != 'waiting') return;
    final now = DateTime.now().millisecondsSinceEpoch;
    final priority = FollowUpPriority.fromString(f.priority);
    final nextPingAt = computeNextPingAtMs(
      nowMs: now,
      priority: priority,
      previousPingCount: f.pingCount,
      highDays: highDays,
      medDays: medDays,
      lowDays: lowDays,
    );
    await _db.writeFollowUp(id, FollowUpsCompanion(
      updatedAt: Value(now),
      lastPingAt: Value(now),
      nextPingAt: Value(nextPingAt),
      pingCount: Value(f.pingCount + 1),
    ));
    await _db.insertEvent(EventsCompanion(
      id: Value(_uuid.v4()),
      followupId: Value(id),
      type: const Value('pinged'),
      at: Value(now),
    ));
    onNextPingAt(nextPingAt);
  }

  Future<void> snooze(String id, {required List<int> businessDays, int workStartHour = 9, int workEndHour = 18}) async {
    final f = await _db.getFollowUp(id);
    if (f == null) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    final next = snoozeToNextBusinessDayAt09(
      fromMs: now,
      businessDays: businessDays,
      workStartHour: workStartHour,
      workEndHour: workEndHour,
    );
    await _db.writeFollowUp(id, FollowUpsCompanion(
      nextPingAt: Value(next),
      updatedAt: Value(now),
    ));
    await _db.insertEvent(EventsCompanion(
      id: Value(_uuid.v4()),
      followupId: Value(id),
      type: const Value('snoozed'),
      at: Value(now),
      metaJson: Value('{"nextPingAt":$next}'),
    ));
  }

  Future<void> markReplied(String id) async {
    final f = await _db.getFollowUp(id);
    if (f == null) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.writeFollowUp(id, FollowUpsCompanion(
      status: const Value('replied'),
      updatedAt: Value(now),
    ));
    await _db.insertEvent(EventsCompanion(
      id: Value(_uuid.v4()),
      followupId: Value(id),
      type: const Value('replied'),
      at: Value(now),
    ));
  }

  Future<void> markClosed(String id) async {
    final f = await _db.getFollowUp(id);
    if (f == null) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.writeFollowUp(id, FollowUpsCompanion(
      status: const Value('closed'),
      updatedAt: Value(now),
    ));
    await _db.insertEvent(EventsCompanion(
      id: Value(_uuid.v4()),
      followupId: Value(id),
      type: const Value('closed'),
      at: Value(now),
    ));
  }

  Future<List<Event>> getEvents(String followupId) => _db.getEventsForFollowUp(followupId);
}
