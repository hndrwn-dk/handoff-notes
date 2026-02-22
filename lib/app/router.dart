import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/followups/screens/followup_detail_screen.dart';
import '../features/followups/screens/followup_edit_screen.dart';
import '../features/followups/screens/followup_list_screen.dart';
import '../features/followups/screens/today_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/settings/screens/templates_screen.dart';
import '../features/standup/screens/standup_editor_screen.dart';
import '../features/standup/screens/standup_list_screen.dart';

final GlobalKey<NavigatorState> _rootNavKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: _rootNavKey,
    initialLocation: '/today',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final path = state.uri.path;
          int index = 0;
          if (path.startsWith('/all')) index = 1;
          else if (path.startsWith('/standup') && path == '/standup') index = 2;
          else if (path.startsWith('/settings')) index = 3;
          return ScaffoldWithNavBar(selectedIndex: index, child: child);
        },
        routes: [
          GoRoute(
            path: '/today',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TodayScreen(),
            ),
          ),
          GoRoute(
            path: '/all',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FollowupListScreen(),
            ),
          ),
          GoRoute(
            path: '/standup',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: StandupListScreen(),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/followup/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return FollowupDetailScreen(followupId: id);
        },
      ),
      GoRoute(
        path: '/followup/:id/edit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return FollowupEditScreen(followupId: id);
        },
      ),
      GoRoute(
        path: '/followup/add',
        builder: (context, state) => const FollowupEditScreen(),
      ),
      GoRoute(
        path: '/standup/:id/edit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return StandupEditorScreen(entryId: id);
        },
      ),
      GoRoute(
        path: '/standup/add',
        builder: (context, state) => const StandupEditorScreen(),
      ),
      GoRoute(
        path: '/templates',
        builder: (context, state) => const TemplatesScreen(),
      ),
    ],
  );
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.selectedIndex, required this.child});

  final int selectedIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          switch (index) {
            case 0:
              context.go('/today');
              break;
            case 1:
              context.go('/all');
              break;
            case 2:
              context.go('/standup');
              break;
            case 3:
              context.go('/settings');
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.today_outlined),
            selectedIcon: Icon(Icons.today),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list),
            label: 'All',
          ),
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article),
            label: 'Standup',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
