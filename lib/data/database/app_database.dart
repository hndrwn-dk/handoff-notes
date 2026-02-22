import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_database.g.dart';

class FollowUps extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get waitingOnName => text()();
  TextColumn get waitingOnOrg => text().nullable()();
  TextColumn get channel => text()();
  TextColumn get priority => text()();
  TextColumn get status => text()();
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get lastPingAt => integer().nullable()();
  IntColumn get nextPingAt => integer().nullable()();
  IntColumn get pingCount => integer().withDefault(const Constant(0))();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Events extends Table {
  TextColumn get id => text()();
  TextColumn get followupId => text()();
  TextColumn get type => text()();
  IntColumn get at => integer()();
  TextColumn get metaJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class StandupEntries extends Table {
  TextColumn get id => text()();
  TextColumn get date => text()();
  TextColumn get doneText => text()();
  TextColumn get doingText => text()();
  TextColumn get blockersText => text()();
  TextColumn get tagsJson => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  IntColumn get deletedAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Templates extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get tone => text()();
  TextColumn get body => text()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [FollowUps, Events, StandupEntries, Templates])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'handoff_notes.db'));
      return NativeDatabase.createInBackground(file);
    });
  }

  static Future<AppDatabase> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'handoff_notes.db'));
    final db = AppDatabase(NativeDatabase.createInBackground(file));
    return db;
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Future migrations: add steps here, e.g. if (from < 2) await m.addColumn(...);
        },
      );

  // Follow-ups: active = deletedAt is null
  Future<List<FollowUp>> watchActiveFollowUps() {
    return (select(followUps)..where((t) => t.deletedAt.isNull())).get();
  }

  Future<List<FollowUp>> watchFollowUpsByNextPing() {
    return (select(followUps)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([
            (t) => OrderingTerm(expression: t.nextPingAt, mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  Future<FollowUp?> getFollowUp(String id) {
    return (select(followUps)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertFollowUp(FollowUpsCompanion entry) {
    return into(followUps).insert(entry);
  }

  Future<bool> updateFollowUp(FollowUpsCompanion entry) {
    return update(followUps).replace(entry);
  }

  Future<int> writeFollowUp(String id, FollowUpsCompanion updates) {
    return (update(followUps)..where((t) => t.id.equals(id))).write(updates);
  }

  Future<int> softDeleteFollowUp(String id, int deletedAt) {
    return (update(followUps)..where((t) => t.id.equals(id)))
        .write(FollowUpsCompanion(updatedAt: Value(deletedAt), deletedAt: Value(deletedAt)));
  }

  Future<List<Event>> getEventsForFollowUp(String followupId) {
    return (select(events)
          ..where((t) => t.followupId.equals(followupId))
          ..orderBy([(t) => OrderingTerm(expression: t.at, mode: OrderingMode.desc)]))
        .get();
  }

  Future<int> insertEvent(EventsCompanion entry) {
    return into(events).insert(entry);
  }

  Future<List<StandupEntry>> watchStandupEntries() {
    return (select(standupEntries)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
        .get();
  }

  Future<StandupEntry?> getStandupEntry(String id) {
    return (select(standupEntries)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertStandupEntry(StandupEntriesCompanion entry) {
    return into(standupEntries).insert(entry);
  }

  Future<bool> updateStandupEntry(StandupEntriesCompanion entry) {
    return update(standupEntries).replace(entry);
  }

  Future<int> writeStandupEntry(String id, StandupEntriesCompanion updates) {
    return (update(standupEntries)..where((t) => t.id.equals(id))).write(updates);
  }

  Future<List<Template>> getAllTemplates() {
    return select(templates).get();
  }

  Future<Template?> getTemplateByTone(String tone) {
    return (select(templates)..where((t) => t.tone.equals(tone))).getSingleOrNull();
  }

  Future<int> insertTemplate(TemplatesCompanion entry) {
    return into(templates).insert(entry);
  }

  Future<bool> updateTemplate(TemplatesCompanion entry) {
    return update(templates).replace(entry);
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError(
    'AppDatabase must be overridden in main() with initialize()',
  );
});
