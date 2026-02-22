import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/database/app_database.dart';
import '../../../domain/enums.dart';
import '../../../shared/date_utils.dart';
import '../providers/followup_providers.dart';
import '../../settings/providers/template_providers.dart';
import '../../../data/repositories/provider.dart';
import '../../../data/repositories/template_repository.dart';
import '../../../shared/clipboard_helpers.dart';
import '../../../domain/next_ping_rules.dart';
import '../../../services/notifications_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowupCard extends ConsumerWidget {
  const FollowupCard({super.key, required this.followUp});

  final FollowUp followUp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priority = FollowUpPriority.fromString(followUp.priority);
    final channel = FollowUpChannel.fromString(followUp.channel);
    final status = FollowUpStatus.fromString(followUp.status);
    final showEscalate = shouldShowEscalationIndicator(followUp.pingCount, status);

    return Card(
      child: InkWell(
        onTap: () => context.push('/followup/${followUp.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      followUp.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  _PriorityChip(priority: priority),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Waiting on: ${followUp.waitingOnName}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _ChannelChip(channel: channel),
                  Text(
                    nextPingLabel(followUp.nextPingAt),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: followUp.nextPingAt != null && followUp.nextPingAt! < startOfTodayMs()
                              ? Theme.of(context).colorScheme.error
                              : null,
                        ),
                  ),
                ],
              ),
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
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => _onPingedNow(context, ref),
                    icon: const Icon(Icons.send, size: 18),
                    label: const Text('Pinged Now'),
                  ),
                  TextButton.icon(
                    onPressed: () => _onCopy(context, ref),
                    icon: const Icon(Icons.copy, size: 18),
                    label: const Text('Copy'),
                  ),
                  TextButton.icon(
                    onPressed: () => _onSnooze(context, ref),
                    icon: const Icon(Icons.snooze, size: 18),
                    label: const Text('Snooze'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPingedNow(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(followupRepositoryProvider);
    final settings = ref.read(settingsRepositoryProvider);
    await repo.pingedNow(
      followUp.id,
      highDays: settings.intervalHighDays,
      medDays: settings.intervalMedDays,
      lowDays: settings.intervalLowDays,
      onNextPingAt: (nextMs) {
        if (settings.perItemNotificationsEnabled && nextMs != null) {
          NotificationsService.scheduleFollowUpNotification(followUp.id, nextMs);
        }
      },
    );
    ref.invalidate(todaySectionsProvider);
    ref.invalidate(allFollowUpsProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pinged. Next follow-up scheduled.')));
    }
  }

  Future<void> _onCopy(BuildContext context, WidgetRef ref) async {
    final template = await ref.read(templateByToneProvider(TemplateTone.gentle).future);
    final body = template != null
        ? fillTemplate(template.body, name: followUp.waitingOnName, topic: followUp.title)
        : 'Hi ${followUp.waitingOnName}, following up on ${followUp.title}.';
    final ok = await copyToClipboard(body);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ok ? 'Copied to clipboard' : 'Copy failed')),
      );
    }
  }

  Future<void> _onSnooze(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(followupRepositoryProvider);
    final settings = ref.read(settingsRepositoryProvider);
    await repo.snooze(
      followUp.id,
      businessDays: settings.businessDays,
      workStartHour: settings.workStartHour,
      workEndHour: settings.workEndHour,
    );
    if (settings.perItemNotificationsEnabled) {
      final f = await repo.getById(followUp.id);
      if (f?.nextPingAt != null) {
        await NotificationsService.scheduleFollowUpNotification(followUp.id, f!.nextPingAt!);
      }
    }
    ref.invalidate(todaySectionsProvider);
    ref.invalidate(allFollowUpsProvider);
    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Snoozed to next business day 09:00')));
  }
}

class _PriorityChip extends StatelessWidget {
  const _PriorityChip({required this.priority});

  final FollowUpPriority priority;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (priority) {
      case FollowUpPriority.high:
        color = Theme.of(context).colorScheme.error;
        break;
      case FollowUpPriority.medium:
        color = Theme.of(context).colorScheme.tertiary;
        break;
      case FollowUpPriority.low:
        color = Theme.of(context).colorScheme.outline;
        break;
    }
    return Chip(
      label: Text(priority.displayName),
      backgroundColor: color.withValues(alpha: 0.2),
      side: BorderSide(color: color),
    );
  }
}

class _ChannelChip extends StatelessWidget {
  const _ChannelChip({required this.channel});

  final FollowUpChannel channel;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (channel) {
      case FollowUpChannel.whatsapp:
        icon = Icons.chat;
        break;
      case FollowUpChannel.teams:
        icon = Icons.groups;
        break;
      case FollowUpChannel.email:
        icon = Icons.email;
        break;
      case FollowUpChannel.call:
        icon = Icons.call;
        break;
      default:
        icon = Icons.more_horiz;
    }
    return Chip(
      avatar: Icon(icon, size: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
      label: Text(channel.displayName),
    );
  }
}
