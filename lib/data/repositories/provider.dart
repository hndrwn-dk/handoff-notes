import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/app_database.dart';
import 'followup_repository.dart';
import 'standup_repository.dart';
import 'template_repository.dart';
import 'settings_repository.dart';

final followupRepositoryProvider = Provider<FollowUpRepository>((ref) {
  return FollowUpRepository(ref.watch(appDatabaseProvider));
});

final standupRepositoryProvider = Provider<StandupRepository>((ref) {
  return StandupRepository(ref.watch(appDatabaseProvider));
});

final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  return TemplateRepository(ref.watch(appDatabaseProvider));
});

/// Override in main() with actual SharedPreferences after getInstance().
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw StateError('SharedPreferences must be overridden in main()');
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(sharedPreferencesProvider));
});
