import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/provider.dart';
import '../../../domain/enums.dart';

final templatesListProvider = FutureProvider<List<Template>>((ref) async {
  final repo = ref.watch(templateRepositoryProvider);
  await repo.ensureDefaults();
  return repo.getAll();
});

final templateByToneProvider = FutureProvider.family<Template?, TemplateTone>((ref, tone) async {
  final repo = ref.watch(templateRepositoryProvider);
  await repo.ensureDefaults();
  return repo.getByTone(tone.name);
});
