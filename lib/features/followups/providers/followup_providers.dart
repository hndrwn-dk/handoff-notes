import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/provider.dart';
import '../../../shared/date_utils.dart';

final todaySectionsProvider = FutureProvider<TodaySections>((ref) async {
  final repo = ref.watch(followupRepositoryProvider);
  final now = DateTime.now().millisecondsSinceEpoch;
  final startToday = startOfTodayMs();
  final endToday = endOfTodayMs();
  final endPlus7 = startOfDayFromTodayMs(7) + 24 * 60 * 60 * 1000 - 1;
  final overdue = await repo.getOverdue(now);
  final dueToday = await repo.getDueToday(startToday, endToday);
  final upcoming = await repo.getUpcomingNext7Days(endToday, endPlus7);
  return TodaySections(overdue: overdue, dueToday: dueToday, upcoming: upcoming);
});

class TodaySections {
  TodaySections({
    required this.overdue,
    required this.dueToday,
    required this.upcoming,
  });
  final List<FollowUp> overdue;
  final List<FollowUp> dueToday;
  final List<FollowUp> upcoming;
}

final allFollowUpsProvider = FutureProvider<List<FollowUp>>((ref) async {
  final repo = ref.watch(followupRepositoryProvider);
  return repo.getActiveSortedByNextPing();
});

final followUpDetailProvider = FutureProvider.family<FollowUp?, String>((ref, id) async {
  final repo = ref.watch(followupRepositoryProvider);
  return repo.getById(id);
});

final followUpEventsProvider = FutureProvider.family<List<Event>, String>((ref, followupId) async {
  final db = ref.watch(appDatabaseProvider);
  return db.getEventsForFollowUp(followupId);
});
