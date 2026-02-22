import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../../data/repositories/provider.dart';
import '../../../domain/enums.dart';
import '../providers/template_providers.dart';

class TemplatesScreen extends ConsumerStatefulWidget {
  const TemplatesScreen({super.key});

  @override
  ConsumerState<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends ConsumerState<TemplatesScreen> {
  @override
  Widget build(BuildContext context) {
    final templatesAsync = ref.watch(templatesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates'),
      ),
      body: templatesAsync.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('No templates.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, i) {
              final t = list[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(t.name),
                  subtitle: Text(t.body),
                  onTap: () => _editTemplate(context, t),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _editTemplate(BuildContext context, Template t) async {
    final bodyController = TextEditingController(text: t.body);
    final nameController = TextEditingController(text: t.name);

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit: ${t.name}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  labelText: 'Body (use {name} and {topic})',
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (ok == true) {
      await ref.read(templateRepositoryProvider).updateTemplate(
            t.id,
            name: nameController.text.trim(),
            body: bodyController.text.trim(),
          );
      ref.invalidate(templatesListProvider);
      ref.invalidate(templateByToneProvider(TemplateTone.gentle));
      ref.invalidate(templateByToneProvider(TemplateTone.firm));
      ref.invalidate(templateByToneProvider(TemplateTone.urgent));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Template saved')));
      }
    }
  }
}
