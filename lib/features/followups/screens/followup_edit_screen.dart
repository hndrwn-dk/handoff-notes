import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/database/app_database.dart';
import '../../../domain/enums.dart';
import '../../../data/repositories/provider.dart';
import '../providers/followup_providers.dart';

class FollowupEditScreen extends ConsumerStatefulWidget {
  const FollowupEditScreen({super.key, this.followupId});

  final String? followupId;

  @override
  ConsumerState<FollowupEditScreen> createState() => _FollowupEditScreenState();
}

class _FollowupEditScreenState extends ConsumerState<FollowupEditScreen> {
  final _titleController = TextEditingController();
  final _waitingOnController = TextEditingController();
  final _orgController = TextEditingController();
  final _notesController = TextEditingController();
  String _channel = 'teams';
  String _priority = 'medium';
  String _status = 'waiting';
  bool _loaded = false;

  @override
  void dispose() {
    _titleController.dispose();
    _waitingOnController.dispose();
    _orgController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _load(FollowUp? f) async {
    if (f == null || _loaded) return;
    _titleController.text = f.title;
    _waitingOnController.text = f.waitingOnName;
    _orgController.text = f.waitingOnOrg ?? '';
    _notesController.text = f.notes ?? '';
    setState(() {
      _channel = f.channel;
      _priority = f.priority;
      _status = f.status;
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.followupId;
    final detail = id != null ? ref.watch(followUpDetailProvider(id)) : const AsyncValue<FollowUp?>.data(null);

    return Scaffold(
      appBar: AppBar(
        title: Text(id == null ? 'Add Follow-Up' : 'Edit Follow-Up'),
        actions: [
          if (id != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _delete(context),
            ),
        ],
      ),
      body: detail.when(
        data: (f) {
          if (f != null) _load(f);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title *'),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _waitingOnController,
                  decoration: const InputDecoration(labelText: 'Waiting on *'),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _orgController,
                  decoration: const InputDecoration(labelText: 'Org / Company (optional)'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _channel,
                  decoration: const InputDecoration(labelText: 'Channel'),
                  items: FollowUpChannel.values
                      .map((e) => DropdownMenuItem(value: e.name, child: Text(e.displayName)))
                      .toList(),
                  onChanged: (v) => setState(() => _channel = v ?? 'teams'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _priority,
                  decoration: const InputDecoration(labelText: 'Priority'),
                  items: FollowUpPriority.values
                      .map((e) => DropdownMenuItem(value: e.name, child: Text(e.displayName)))
                      .toList(),
                  onChanged: (v) => setState(() => _priority = v ?? 'medium'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: FollowUpStatus.values
                      .map((e) => DropdownMenuItem(value: e.name, child: Text(e.displayName)))
                      .toList(),
                  onChanged: (v) => setState(() => _status = v ?? 'waiting'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _notesController,
                  decoration: const InputDecoration(labelText: 'Notes'),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _save,
                  child: Text(id == null ? 'Add' : 'Save'),
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

  Future<void> _save() async {
    final title = _titleController.text.trim();
    final waitingOn = _waitingOnController.text.trim();
    if (title.isEmpty || waitingOn.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and Waiting on are required')),
      );
      return;
    }
    final repo = ref.read(followupRepositoryProvider);
    final id = widget.followupId;
    if (id == null) {
      final newId = await repo.addFollowUp(
        title: title,
        waitingOnName: waitingOn,
        waitingOnOrg: _orgController.text.trim().isEmpty ? null : _orgController.text.trim(),
        channel: _channel,
        priority: _priority,
        status: _status,
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      if (context.mounted) {
        context.go('/followup/$newId');
      }
    } else {
      await repo.updateFollowUp(
        id: id,
        title: title,
        waitingOnName: waitingOn,
        waitingOnOrg: _orgController.text.trim().isEmpty ? null : _orgController.text.trim(),
        channel: _channel,
        priority: _priority,
        status: _status,
        notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      );
      ref.invalidate(followUpDetailProvider(id));
      ref.invalidate(allFollowUpsProvider);
      ref.invalidate(todaySectionsProvider);
      if (context.mounted) {
        context.pop();
      }
    }
  }

  Future<void> _delete(BuildContext context) async {
    final db = ref.read(appDatabaseProvider);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete follow-up?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true || widget.followupId == null) return;
    await db.softDeleteFollowUp(widget.followupId!, DateTime.now().millisecondsSinceEpoch);
    ref.invalidate(allFollowUpsProvider);
    ref.invalidate(todaySectionsProvider);
    if (context.mounted) context.go('/all');
  }
}
