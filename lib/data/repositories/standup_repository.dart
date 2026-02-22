import 'package:drift/drift.dart';
import '../database/app_database.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class StandupRepository {
  StandupRepository(this._db);

  final AppDatabase _db;

  Future<List<StandupEntry>> getAll() => _db.watchStandupEntries();

  Future<StandupEntry?> getById(String id) => _db.getStandupEntry(id);

  Future<String> addEntry({
    required String dateYmd,
    String doneText = '',
    String doingText = '',
    String blockersText = '',
    String? tagsJson,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final id = _uuid.v4();
    await _db.insertStandupEntry(StandupEntriesCompanion(
      id: Value(id),
      date: Value(dateYmd),
      doneText: Value(doneText),
      doingText: Value(doingText),
      blockersText: Value(blockersText),
      tagsJson: Value(tagsJson),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));
    return id;
  }

  Future<void> updateEntry({
    required String id,
    String? dateYmd,
    String? doneText,
    String? doingText,
    String? blockersText,
    String? tagsJson,
  }) async {
    final existing = await _db.getStandupEntry(id);
    if (existing == null) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.writeStandupEntry(id, StandupEntriesCompanion(
      date: dateYmd != null ? Value(dateYmd) : Value(existing.date),
      doneText: doneText != null ? Value(doneText) : Value(existing.doneText),
      doingText: doingText != null ? Value(doingText) : Value(existing.doingText),
      blockersText: blockersText != null ? Value(blockersText) : Value(existing.blockersText),
      tagsJson: tagsJson != null ? Value(tagsJson) : Value(existing.tagsJson),
      updatedAt: Value(now),
    ));
  }
}

/// Generates short standup text (Done / Doing / Blocked).
String generateStandupShort({required String done, required String doing, required String blockers}) {
  final buf = StringBuffer();
  if (done.trim().isNotEmpty) buf.writeln('Done:\n$done');
  if (doing.trim().isNotEmpty) buf.writeln('Doing:\n$doing');
  if (blockers.trim().isNotEmpty) buf.writeln('Blockers:\n$blockers');
  return buf.toString().trim();
}

/// Generates longer weekly update style text.
String generateWeekly({required String done, required String doing, required String blockers}) {
  final buf = StringBuffer();
  buf.writeln('Weekly update');
  buf.writeln('---');
  if (done.trim().isNotEmpty) buf.writeln('Completed:\n$done\n');
  if (doing.trim().isNotEmpty) buf.writeln('In progress:\n$doing\n');
  if (blockers.trim().isNotEmpty) buf.writeln('Blockers / needs:\n$blockers');
  return buf.toString().trim();
}
