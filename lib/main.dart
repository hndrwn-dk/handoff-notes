import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app_theme.dart';
import 'app/router.dart';
import 'app/version.dart';
import 'data/database/app_database.dart';
import 'data/repositories/provider.dart';
import 'services/notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await AppDatabase.initialize();
  final prefs = await SharedPreferences.getInstance();
  await NotificationsService.initialize(db);
  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: HandoffNotesApp(),
    ),
  );
}

class HandoffNotesApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Handoff Notes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(Brightness.light),
      darkTheme: AppTheme.light(Brightness.dark),
      themeMode: ThemeMode.system,
      routerConfig: createAppRouter(),
    );
  }
}
