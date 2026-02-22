import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/version.dart';
import '../../../data/repositories/provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Follow-up intervals (days)', style: Theme.of(context).textTheme.titleSmall),
          ListTile(
            title: const Text('High priority'),
            trailing: SizedBox(
              width: 80,
              child: TextFormField(
                initialValue: '${settings.intervalHighDays}',
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  final n = int.tryParse(v);
                  if (n != null && n > 0) settings.intervalHighDays = n;
                },
              ),
            ),
          ),
          ListTile(
            title: const Text('Medium priority'),
            trailing: SizedBox(
              width: 80,
              child: TextFormField(
                initialValue: '${settings.intervalMedDays}',
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  final n = int.tryParse(v);
                  if (n != null && n > 0) settings.intervalMedDays = n;
                },
              ),
            ),
          ),
          ListTile(
            title: const Text('Low priority'),
            trailing: SizedBox(
              width: 80,
              child: TextFormField(
                initialValue: '${settings.intervalLowDays}',
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  final n = int.tryParse(v);
                  if (n != null && n > 0) settings.intervalLowDays = n;
                },
              ),
            ),
          ),
          const Divider(),
          Text('Work hours', style: Theme.of(context).textTheme.titleSmall),
          ListTile(
            title: const Text('Start hour (09 = 09:00)'),
            trailing: SizedBox(
              width: 80,
              child: TextFormField(
                initialValue: '${settings.workStartHour}',
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  final n = int.tryParse(v);
                  if (n != null && n >= 0 && n <= 23) settings.workStartHour = n;
                },
              ),
            ),
          ),
          ListTile(
            title: const Text('End hour (18 = 18:00)'),
            trailing: SizedBox(
              width: 80,
              child: TextFormField(
                initialValue: '${settings.workEndHour}',
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  final n = int.tryParse(v);
                  if (n != null && n >= 0 && n <= 23) settings.workEndHour = n;
                },
              ),
            ),
          ),
          const Divider(),
          Text('Notifications', style: Theme.of(context).textTheme.titleSmall),
          SwitchListTile(
            title: const Text('Daily summary at 09:00'),
            value: settings.dailySummaryEnabled,
            onChanged: (v) => setState(() => settings.dailySummaryEnabled = v),
          ),
          SwitchListTile(
            title: const Text('Per-item at next ping time'),
            value: settings.perItemNotificationsEnabled,
            onChanged: (v) => setState(() => settings.perItemNotificationsEnabled = v),
          ),
          const Divider(),
          ListTile(
            title: const Text('Templates'),
            subtitle: const Text('Manage message templates'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/templates'),
          ),
          const Divider(),
          ListTile(
            title: Text('Version ${appVersion}+$appBuildNumber'),
          ),
        ],
      ),
    );
  }
}
