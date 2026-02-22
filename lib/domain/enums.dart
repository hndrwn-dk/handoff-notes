enum FollowUpChannel {
  whatsapp,
  teams,
  email,
  call,
  other;

  String get displayName {
    switch (this) {
      case FollowUpChannel.whatsapp:
        return 'WhatsApp';
      case FollowUpChannel.teams:
        return 'Teams';
      case FollowUpChannel.email:
        return 'Email';
      case FollowUpChannel.call:
        return 'Call';
      case FollowUpChannel.other:
        return 'Other';
    }
  }

  static FollowUpChannel fromString(String? v) {
    if (v == null) return FollowUpChannel.teams;
    return FollowUpChannel.values.firstWhere(
      (e) => e.name == v,
      orElse: () => FollowUpChannel.teams,
    );
  }
}

enum FollowUpPriority {
  low,
  medium,
  high;

  String get displayName {
    switch (this) {
      case FollowUpPriority.low:
        return 'Low';
      case FollowUpPriority.medium:
        return 'Medium';
      case FollowUpPriority.high:
        return 'High';
    }
  }

  static FollowUpPriority fromString(String? v) {
    if (v == null) return FollowUpPriority.medium;
    return FollowUpPriority.values.firstWhere(
      (e) => e.name == v,
      orElse: () => FollowUpPriority.medium,
    );
  }
}

enum FollowUpStatus {
  waiting,
  replied,
  closed;

  String get displayName {
    switch (this) {
      case FollowUpStatus.waiting:
        return 'Waiting';
      case FollowUpStatus.replied:
        return 'Replied';
      case FollowUpStatus.closed:
        return 'Closed';
    }
  }

  static FollowUpStatus fromString(String? v) {
    if (v == null) return FollowUpStatus.waiting;
    return FollowUpStatus.values.firstWhere(
      (e) => e.name == v,
      orElse: () => FollowUpStatus.waiting,
    );
  }
}

enum TemplateTone {
  gentle,
  firm,
  urgent;

  static TemplateTone fromString(String? v) {
    if (v == null) return TemplateTone.gentle;
    return TemplateTone.values.firstWhere(
      (e) => e.name == v,
      orElse: () => TemplateTone.gentle,
    );
  }
}

enum EventType {
  created,
  pinged,
  snoozed,
  replied,
  closed,
  copied_message,
  edited,
  note;

  static EventType fromString(String v) {
    return EventType.values.firstWhere(
      (e) => e.name == v,
      orElse: () => EventType.note,
    );
  }
}
