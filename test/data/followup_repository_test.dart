import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:handoff_notes/data/database/app_database.dart';
import 'package:handoff_notes/data/repositories/followup_repository.dart';

void main() {
  late AppDatabase db;
  late FollowUpRepository repo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = FollowUpRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('FollowUpRepository', () {
    test('insert and get follow-up', () async {
      final id = await repo.addFollowUp(
        title: 'Test title',
        waitingOnName: 'Alice',
        channel: 'teams',
        priority: 'high',
        status: 'waiting',
      );
      expect(id, isNotEmpty);

      final f = await repo.getById(id);
      expect(f, isNotNull);
      expect(f!.title, 'Test title');
      expect(f.waitingOnName, 'Alice');
      expect(f.channel, 'teams');
      expect(f.priority, 'high');
      expect(f.status, 'waiting');
      expect(f.pingCount, 0);
      expect(f.nextPingAt, isNotNull);
    });

    test('pingedNow updates lastPingAt, nextPingAt, pingCount', () async {
      final id = await repo.addFollowUp(
        title: 'Ping test',
        waitingOnName: 'Bob',
        channel: 'email',
        priority: 'medium',
      );
      final before = await repo.getById(id);
      expect(before!.lastPingAt, isNull);
      expect(before.pingCount, 0);

      await repo.pingedNow(id, onNextPingAt: (_) {});

      final after = await repo.getById(id);
      expect(after!.lastPingAt, isNotNull);
      expect(after.pingCount, 1);
      expect(after.nextPingAt, isNotNull);
      expect(after.nextPingAt! > after.lastPingAt!, true);
    });

    test('updateFollowUp changes fields', () async {
      final id = await repo.addFollowUp(
        title: 'Original',
        waitingOnName: 'Carol',
      );
      await repo.updateFollowUp(id: id, title: 'Updated', status: 'replied');
      final f = await repo.getById(id);
      expect(f!.title, 'Updated');
      expect(f.status, 'replied');
    });
  });
}
