import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/database/app_database.dart';
import '../../../domain/enums.dart';
import '../../../domain/next_ping_rules.dart';
import '../../../data/repositories/provider.dart';
import '../../../data/repositories/template_repository.dart';
import '../../../shared/date_utils.dart';
import '../../../shared/clipboard_helpers.dart';
import '../../../services/notifications_service.dart';
import '../providers/followup_providers.dart';

class FollowupDetailScreen extends ConsumerWidget {
  const FollowupDetailScreen({super.key, required this.followupId});

  final String followupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(followUpDetailProvider(followupId));
    final eventsAsync = ref.watch(followUpEventsProvider(followupId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Follow-Up'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/followup/$followupId/edit'),
          ),
        ],
      ),
      body: detail.when(
        data: (f) {
          if (f == null) {
            return const Center(child: Text('Not found'));
          }
          final priority = FollowUpPriority.fromString(f.priority);
          final channel = FollowUpChannel.fromString(f.channel);
          final status = FollowUpStatus.fromString(f.status);
          final showEscalate = shouldShowEscalationIndicator(f.pingCount, status);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          f.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text('Waiting on: ${f.waitingOnName}'),
                        if (f.waitingOnOrg != null && f.waitingOnOrg!.isNotEmpty)
                          Text('Org: ${f.waitingOnOrg}'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            Chip(label: Text(priority.displayName)),
                            Chip(label: Text(channel.displayName)),
                            Chip(label: Text(status.displayName)),
                          ],
                        ),
                        Text('Next ping: ${nextPingLabel(f.nextPingAt)}'),
                        if (f.notes != null && f.notes!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text('Notes: ${f.notes}'),
                        ],
                        if (showEscalate) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Consider escalate',
                              style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => _pingedNow(context, ref, f),
                        icon: const Icon(Icons.send),
                        label: const Text('Pinged Now'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _copyMessage(context, ref, f),
                        icon: const Icon(Icons.copy),
                        label: const Text('Copy Message'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _snooze(context, ref, f),
                        icon: const Icon(Icons.snooze),
                        label: const Text('Snooze'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _markReplied(context, ref, f),
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('Mark Replied'),
                      ),
                    ),
                  ],
                ),
                if (status == FollowUpStatus.waiting)
                  OutlinedButton.icon(
                    onPressed: () => _markClosed(context, ref, f),
                    icon: const Icon(Icons.close),
                    label: const Text('Close'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
                const SizedBox(height: 24),
                Text('Timeline', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                eventsAsync.when(
                  data: (events) {
                    if (events.isEmpty) return const Text('No events yet.');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: events.map((e) {
                        final dt = DateTime.fromMillisecondsSinceEpoch(e.at);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '${e.type} - ${formatDateDisplay(dt)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => Text('Error: $e'),
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

  Future<void> _pingedNow(BuildContext context, WidgetRef ref, FollowUp f) async {
    final repo = ref.read(followupRepositoryProvider);
    final settings = ref.read(settingsRepositoryProvider);
    await repo.pingedNow(
      f.id,
      highDays: settings.intervalHighDays,
      medDays: settings.intervalMedDays,
      lowDays: settings.intervalLowDays,
      onNextPingAt: (nextMs) {
        if (settings.perItemNotificationsEnabled && nextMs != null) {
          NotificationsService.scheduleFollowUpNotification(f.id, nextMs);
        }
      },
    );
    ref.invalidate(followUpDetailProvider(followupId));
    ref.invalidate(followUpEventsProvider(followupId));
    ref.invalidate(todaySectionsProvider);
    ref.invalidate(allFollowUpsProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pinged. Next follow-up scheduled.')));
    }
  }

  Future<void> _copyMessage(BuildContext context, WidgetRef ref, FollowUp f) async {
    final tone = await showDialog<TemplateTone>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Choose template tone'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Gentle'),
              onTap: () => Navigator.pop(ctx, TemplateTone.gentle),
            ),
            ListTile(
              title: const Text('Firm'),
              onTap: () => Navigator.pop(ctx, TemplateTone.firm),
            ),
            ListTile(
              title: const Text('Urgent'),
              onTap: () => Navigator.pop(ctx, TemplateTone.urgent),
            ),
          ],
        ),
      ),
    );
    if (tone == null) return;
    final repo = ref.read(templateRepositoryProvider);
    await repo.ensureDefaults();
    final template = await repo.getByTone(tone.name);
    final body = template != null
        ? fillTemplate(template.body, name: f.waitingOnName, topic: f.title)
        : 'Hi ${f.waitingOnName}, following up on ${f.title}.';
    final ok = await copyToClipboard(body);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ok ? 'Copied to clipboard' : 'Copy failed')),
      );
    }
  }

  Future<void> _snooze(BuildContext context, WidgetRef ref, FollowUp f) async {
    final repo = ref.read(followupRepositoryProvider);
    final settings = ref.read(settingsRepositoryProvider);
    await repo.snooze(
      f.id,
      businessDays: settings.businessDays,
      workStartHour: settings.workStartHour,
      workEndHour: settings.workEndHour,
    );
    if (settings.perItemNotificationsEnabled) {
      final updated = await repo.getById(f.id);
      if (updated?.nextPingAt != null) {
        await NotificationsService.scheduleFollowUpNotification(f.id, updated!.nextPingAt!);
      }
    }
    ref.invalidate(followUpDetailProvider(followupId));
    ref.invalidate(todaySectionsProvider);
    ref.invalidate(allFollowUpsProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Snoozed to next business day 09:00')));
    }
  }

  Future<void> _markReplied(BuildContext context, WidgetRef ref, FollowUp f) async {
    await ref.read(followupRepositoryProvider).markReplied(f.id);
    ref.invalidate(followUpDetailProvider(followupId));
    ref.invalidate(followUpEventsProvider(followupId));
    ref.invalidate(todaySectionsProvider);
    ref.invalidate(allFollowUpsProvider);
    await NotificationsService.cancelFollowUpNotification(f.id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Marked as replied')));
    }
  }

  Future<void> _markClosed(BuildContext context, WidgetRef ref, FollowUp f) async {
    await ref.read(followupRepositoryProvider).markClosed(f.id);
    ref.invalidate(followUpDetailProvider(followupId));
    ref.invalidate(todaySectionsProvider);
    ref.invalidate(allFollowUpsProvider);
    await NotificationsService.cancelFollowUpNotification(f.id);
    if (context.mounted) {
      context.pop();
    }
  }
}
