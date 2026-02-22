# Handoff Notes

**Follow-ups & handover notes, offline.**

Handoff Notes is an offline-first Flutter (Android) app for managing follow-ups you are waiting on others for—approvals, vendor replies, peer reviews, HR, teammates—and generating standup/weekly update text. No backend, no login, no internet required. Data is stored locally with SQLite via [Drift](https://drift.simonbinder.eu/).

## Features

- **Follow-up inbox**: Today (overdue / due today / upcoming), All with search and filters
- **Next ping rules**: Tap "Pinged Now" to set last ping and schedule next follow-up by priority (High 1d, Med 2d, Low 4d; configurable in Settings)
- **Snooze**: Snooze to next business day at 09:00 (Mon–Fri, configurable)
- **Copy message**: One-tap copy of follow-up message using templates (Gentle / Firm / Urgent)
- **Standup / Weekly generator**: Done / Doing / Blockers with Generate Standup, Generate Weekly, and Copy
- **Templates**: Manage Gentle, Firm, Urgent message templates with `{name}` and `{topic}` variables
- **Local notifications**: Daily summary at 09:00 and per-item at next ping time (when enabled)
- **Escalation hint**: "Consider escalate" when ping count >= 3 and still waiting

## Setup and run

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable, 3.2+)
- Android SDK (for Android builds)

### Install dependencies

```bash
cd handoff-notes
flutter pub get
```

### Generate Drift code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Run on Android

```bash
flutter run
```

Or open the project in your IDE and run the **main** configuration targeting an Android device or emulator.

### Build release APK

```bash
flutter build apk
```

Output: `build/app/outputs/flutter-apk/app-release.apk`.

## Run tests

```bash
flutter test
```

Or run specific test files:

```bash
flutter test test/domain/next_ping_rules_test.dart
flutter test test/domain/snooze_rules_test.dart
flutter test test/data/followup_repository_test.dart
```

Tests cover:

- **Next ping rules**: interval by priority (high/med/low), custom days, escalation indicator
- **Snooze**: next business day at 09:00 (weekday, Friday after work, weekend)
- **Follow-up repository**: insert, get, pingedNow, update

## Project structure

```
lib/
  app/              # Theme, router, version constants
  data/
    database/       # Drift schema, migrations (app_database.dart + .g.dart)
    repositories/   # FollowUp, Standup, Template, Settings repos + providers
  domain/           # Enums, next_ping_rules, snooze_rules
  features/
    followups/      # Today, All, Add/Edit, Detail screens + card widget
    standup/        # Standup list + editor screens
    settings/       # Settings + Templates screens
  services/         # Local notifications
  shared/            # Date utils, clipboard helpers
test/
  domain/           # next_ping_rules_test, snooze_rules_test
  data/             # followup_repository_test
```

## Database (Drift)

- **FollowUps**: id, title, waitingOnName, waitingOnOrg, channel, priority, status, notes, createdAt, updatedAt, lastPingAt, nextPingAt, pingCount, deletedAt
- **Events**: id, followupId, type, at, metaJson (timeline per follow-up)
- **StandupEntries**: id, date, doneText, doingText, blockersText, tagsJson, createdAt, updatedAt, deletedAt
- **Templates**: id, name, tone, body, createdAt, updatedAt

Schema version: 1. Migration steps are in `AppDatabase.migration` for future upgrades.

## App version and changelog

- Version and build: `lib/app/version.dart` (`appVersion`, `appBuildNumber`)
- Changelog stub: `changelogStub` in the same file for future release notes.

## Notifications

- **Daily summary**: Scheduled at 09:00 (timezone: UTC in this build; can be extended to use device timezone).
- **Per-item**: Scheduled at `nextPingAt` when "Pinged Now" or "Snooze" is used; cancelled when item is marked Replied/Closed or when time is in the past.

On Android 13+ you may need to grant notification permission when first prompted.

## License

Use and modify as needed for your project.
