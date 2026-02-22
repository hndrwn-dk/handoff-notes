import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/provider.dart';

final standupEntriesProvider = FutureProvider<List<StandupEntry>>((ref) async {
  return ref.watch(standupRepositoryProvider).getAll();
});

final standupEntryDetailProvider = FutureProvider.family<StandupEntry?, String>((ref, id) async {
  return ref.watch(standupRepositoryProvider).getById(id);
});
