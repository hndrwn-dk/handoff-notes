import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/database/app_database.dart';
import '../../../shared/date_utils.dart';
import '../providers/standup_providers.dart';

class StandupListScreen extends ConsumerStatefulWidget {
  const StandupListScreen({super.key});

  @override
  ConsumerState<StandupListScreen> createState() => _StandupListScreenState();
}

class _StandupListScreenState extends ConsumerState<StandupListScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final entriesAsync = ref.watch(standupEntriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Standup'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by tags or text...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),
          Expanded(
            child: entriesAsync.when(
              data: (entries) {
                var filtered = entries;
                if (_search.trim().isNotEmpty) {
                  final q = _search.trim().toLowerCase();
                  filtered = entries.where((e) {
                    return e.doneText.toLowerCase().contains(q) ||
                        e.doingText.toLowerCase().contains(q) ||
                        e.blockersText.toLowerCase().contains(q) ||
                        (e.tagsJson?.toLowerCase().contains(q) ?? false);
                  }).toList();
                }
                if (filtered.isEmpty) {
                  return const Center(child: Text('No standup entries. Tap + to add one.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    final e = filtered[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: ListTile(
                        title: Text(formatDateDisplay(DateTime.tryParse(e.date) ?? DateTime.now())),
                        subtitle: Text(
                          _preview(e),
                        ),
                        onTap: () => context.push('/standup/${e.id}/edit'),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/standup/add'),
        icon: const Icon(Icons.add),
        label: const Text('New entry'),
      ),
    );
  }

  String _preview(StandupEntry e) {
    if (e.doneText.isEmpty && e.doingText.isEmpty && e.blockersText.isEmpty) return 'Empty';
    final t = '${e.doneText} ${e.doingText} ${e.blockersText}'.trim();
    return t.length > 40 ? '${t.substring(0, 40)}...' : t;
  }
}
