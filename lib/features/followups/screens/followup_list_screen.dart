import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/followup_providers.dart';
import '../widgets/followup_card.dart';

class FollowupListScreen extends ConsumerStatefulWidget {
  const FollowupListScreen({super.key});

  @override
  ConsumerState<FollowupListScreen> createState() => _FollowupListScreenState();
}

class _FollowupListScreenState extends ConsumerState<FollowupListScreen> {
  String _query = '';
  String? _statusFilter;
  String? _priorityFilter;
  String? _channelFilter;

  @override
  Widget build(BuildContext context) {
    final allAsync = ref.watch(allFollowUpsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilters(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search title or waiting on...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: allAsync.when(
              data: (list) {
                var filtered = list;
                if (_query.trim().isNotEmpty) {
                  final q = _query.trim().toLowerCase();
                  filtered = list.where((f) {
                    return f.title.toLowerCase().contains(q) ||
                        f.waitingOnName.toLowerCase().contains(q);
                  }).toList();
                }
                if (_statusFilter != null) {
                  filtered = filtered.where((f) => f.status == _statusFilter).toList();
                }
                if (_priorityFilter != null) {
                  filtered = filtered.where((f) => f.priority == _priorityFilter).toList();
                }
                if (_channelFilter != null) {
                  filtered = filtered.where((f) => f.channel == _channelFilter).toList();
                }
                if (filtered.isEmpty) {
                  return const Center(child: Text('No follow-ups match.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: filtered.length,
                  itemBuilder: (context, i) => FollowupCard(followUp: filtered[i]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/followup/add'),
        icon: const Icon(Icons.add),
        label: const Text('Add Follow-Up'),
      ),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filters', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('Waiting'),
                      selected: _statusFilter == 'waiting',
                      onSelected: (v) => setModalState(() => _statusFilter = v ? 'waiting' : null),
                    ),
                    FilterChip(
                      label: const Text('Replied'),
                      selected: _statusFilter == 'replied',
                      onSelected: (v) => setModalState(() => _statusFilter = v ? 'replied' : null),
                    ),
                    FilterChip(
                      label: const Text('Closed'),
                      selected: _statusFilter == 'closed',
                      onSelected: (v) => setModalState(() => _statusFilter = v ? 'closed' : null),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('High'),
                      selected: _priorityFilter == 'high',
                      onSelected: (v) => setModalState(() => _priorityFilter = v ? 'high' : null),
                    ),
                    FilterChip(
                      label: const Text('Medium'),
                      selected: _priorityFilter == 'medium',
                      onSelected: (v) => setModalState(() => _priorityFilter = v ? 'medium' : null),
                    ),
                    FilterChip(
                      label: const Text('Low'),
                      selected: _priorityFilter == 'low',
                      onSelected: (v) => setModalState(() => _priorityFilter = v ? 'low' : null),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('Teams'),
                      selected: _channelFilter == 'teams',
                      onSelected: (v) => setModalState(() => _channelFilter = v ? 'teams' : null),
                    ),
                    FilterChip(
                      label: const Text('Email'),
                      selected: _channelFilter == 'email',
                      onSelected: (v) => setModalState(() => _channelFilter = v ? 'email' : null),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setModalState(() {
                          _statusFilter = null;
                          _priorityFilter = null;
                          _channelFilter = null;
                        });
                        setState(() {
                          _statusFilter = null;
                          _priorityFilter = null;
                          _channelFilter = null;
                        });
                        Navigator.pop(ctx);
                      },
                      child: const Text('Clear'),
                    ),
                    FilledButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(ctx);
                      },
                      child: const Text('Apply'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
