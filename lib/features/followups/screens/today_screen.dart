import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/followup_providers.dart';
import '../widgets/followup_card.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = ref.watch(todaySectionsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
      ),
      body: today.when(
        data: (sections) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(todaySectionsProvider),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 80),
              children: [
                if (sections.overdue.isNotEmpty) ...[
                  _SectionHeader(title: 'Overdue', count: sections.overdue.length),
                  ...sections.overdue.map((f) => FollowupCard(followUp: f)),
                ],
                if (sections.dueToday.isNotEmpty) ...[
                  _SectionHeader(title: 'Due Today', count: sections.dueToday.length),
                  ...sections.dueToday.map((f) => FollowupCard(followUp: f)),
                ],
                if (sections.upcoming.isNotEmpty) ...[
                  _SectionHeader(title: 'Upcoming (next 7 days)', count: sections.upcoming.length),
                  ...sections.upcoming.map((f) => FollowupCard(followUp: f)),
                ],
                if (sections.overdue.isEmpty && sections.dueToday.isEmpty && sections.upcoming.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: Text('No follow-ups due. Add one from All.')),
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        '$title ($count)',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
