import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/provider.dart';
import '../../../data/repositories/standup_repository.dart';
import '../../../shared/date_utils.dart';
import '../../../shared/clipboard_helpers.dart';
import '../providers/standup_providers.dart';

class StandupEditorScreen extends ConsumerStatefulWidget {
  const StandupEditorScreen({super.key, this.entryId});

  final String? entryId;

  @override
  ConsumerState<StandupEditorScreen> createState() => _StandupEditorScreenState();
}

class _StandupEditorScreenState extends ConsumerState<StandupEditorScreen> {
  final _doneController = TextEditingController();
  final _doingController = TextEditingController();
  final _blockersController = TextEditingController();
  DateTime _date = DateTime.now();
  String? _generatedText;
  bool _loaded = false;

  @override
  void dispose() {
    _doneController.dispose();
    _doingController.dispose();
    _blockersController.dispose();
    super.dispose();
  }

  void _load(String? id, StandupEntry? e) {
    if (e == null || _loaded) return;
    _doneController.text = e.doneText;
    _doingController.text = e.doingText;
    _blockersController.text = e.blockersText;
    _date = DateTime.tryParse(e.date) ?? DateTime.now();
    setState(() => _loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.entryId;
    final entryAsync = id != null ? ref.watch(standupEntryDetailProvider(id)) : const AsyncValue<StandupEntry?>.data(null);

    return Scaffold(
      appBar: AppBar(
        title: Text(id == null ? 'New Standup Entry' : 'Edit Standup'),
      ),
      body: entryAsync.when(
        data: (e) {
          if (e != null) _load(id, e);
          if (id == null) _loaded = true;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) setState(() => _date = picked);
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(formatDateDisplay(_date)),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _doneController,
                  decoration: const InputDecoration(
                    labelText: 'Done',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _doingController,
                  decoration: const InputDecoration(
                    labelText: 'Doing',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _blockersController,
                  decoration: const InputDecoration(
                    labelText: 'Blockers',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => setState(() {
                          _generatedText = generateStandupShort(
                            done: _doneController.text,
                            doing: _doingController.text,
                            blockers: _blockersController.text,
                          );
                        }),
                        icon: const Icon(Icons.short_text),
                        label: const Text('Generate Standup'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => setState(() {
                          _generatedText = generateWeekly(
                            done: _doneController.text,
                            doing: _doingController.text,
                            blockers: _blockersController.text,
                          );
                        }),
                        icon: const Icon(Icons.article),
                        label: const Text('Generate Weekly'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (_generatedText != null && _generatedText!.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Preview', style: Theme.of(context).textTheme.titleSmall),
                              TextButton.icon(
                                onPressed: () async {
                                  final ok = await copyToClipboard(_generatedText!);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(ok ? 'Copied' : 'Copy failed')),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.copy, size: 18),
                                label: const Text('Copy'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SelectableText(_generatedText!),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _save,
                  child: Text(id == null ? 'Create' : 'Save'),
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
    final dateYmd = formatDateYmd(_date);
    final repo = ref.read(standupRepositoryProvider);
    final id = widget.entryId;
    if (id == null) {
      final newId = await repo.addEntry(
        dateYmd: dateYmd,
        doneText: _doneController.text,
        doingText: _doingController.text,
        blockersText: _blockersController.text,
      );
      if (context.mounted) context.go('/standup/$newId/edit');
    } else {
      await repo.updateEntry(
        id: id,
        dateYmd: dateYmd,
        doneText: _doneController.text,
        doingText: _doingController.text,
        blockersText: _blockersController.text,
      );
      ref.invalidate(standupEntryDetailProvider(id));
      ref.invalidate(standupEntriesProvider);
      if (context.mounted) context.pop();
    }
  }
}
