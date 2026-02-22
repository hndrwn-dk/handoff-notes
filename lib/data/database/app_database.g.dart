// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FollowUpsTable extends FollowUps
    with TableInfo<$FollowUpsTable, FollowUp> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FollowUpsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _waitingOnNameMeta =
      const VerificationMeta('waitingOnName');
  @override
  late final GeneratedColumn<String> waitingOnName = GeneratedColumn<String>(
      'waiting_on_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _waitingOnOrgMeta =
      const VerificationMeta('waitingOnOrg');
  @override
  late final GeneratedColumn<String> waitingOnOrg = GeneratedColumn<String>(
      'waiting_on_org', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _channelMeta =
      const VerificationMeta('channel');
  @override
  late final GeneratedColumn<String> channel = GeneratedColumn<String>(
      'channel', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastPingAtMeta =
      const VerificationMeta('lastPingAt');
  @override
  late final GeneratedColumn<int> lastPingAt = GeneratedColumn<int>(
      'last_ping_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nextPingAtMeta =
      const VerificationMeta('nextPingAt');
  @override
  late final GeneratedColumn<int> nextPingAt = GeneratedColumn<int>(
      'next_ping_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _pingCountMeta =
      const VerificationMeta('pingCount');
  @override
  late final GeneratedColumn<int> pingCount = GeneratedColumn<int>(
      'ping_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        waitingOnName,
        waitingOnOrg,
        channel,
        priority,
        status,
        notes,
        createdAt,
        updatedAt,
        lastPingAt,
        nextPingAt,
        pingCount,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'follow_ups';
  @override
  VerificationContext validateIntegrity(Insertable<FollowUp> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('waiting_on_name')) {
      context.handle(
          _waitingOnNameMeta,
          waitingOnName.isAcceptableOrUnknown(
              data['waiting_on_name']!, _waitingOnNameMeta));
    } else if (isInserting) {
      context.missing(_waitingOnNameMeta);
    }
    if (data.containsKey('waiting_on_org')) {
      context.handle(
          _waitingOnOrgMeta,
          waitingOnOrg.isAcceptableOrUnknown(
              data['waiting_on_org']!, _waitingOnOrgMeta));
    }
    if (data.containsKey('channel')) {
      context.handle(_channelMeta,
          channel.isAcceptableOrUnknown(data['channel']!, _channelMeta));
    } else if (isInserting) {
      context.missing(_channelMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('last_ping_at')) {
      context.handle(
          _lastPingAtMeta,
          lastPingAt.isAcceptableOrUnknown(
              data['last_ping_at']!, _lastPingAtMeta));
    }
    if (data.containsKey('next_ping_at')) {
      context.handle(
          _nextPingAtMeta,
          nextPingAt.isAcceptableOrUnknown(
              data['next_ping_at']!, _nextPingAtMeta));
    }
    if (data.containsKey('ping_count')) {
      context.handle(_pingCountMeta,
          pingCount.isAcceptableOrUnknown(data['ping_count']!, _pingCountMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FollowUp map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FollowUp(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      waitingOnName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}waiting_on_name'])!,
      waitingOnOrg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}waiting_on_org']),
      channel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}channel'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      lastPingAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_ping_at']),
      nextPingAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}next_ping_at']),
      pingCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ping_count'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $FollowUpsTable createAlias(String alias) {
    return $FollowUpsTable(attachedDatabase, alias);
  }
}

class FollowUp extends DataClass implements Insertable<FollowUp> {
  final String id;
  final String title;
  final String waitingOnName;
  final String? waitingOnOrg;
  final String channel;
  final String priority;
  final String status;
  final String? notes;
  final int createdAt;
  final int updatedAt;
  final int? lastPingAt;
  final int? nextPingAt;
  final int pingCount;
  final int? deletedAt;
  const FollowUp(
      {required this.id,
      required this.title,
      required this.waitingOnName,
      this.waitingOnOrg,
      required this.channel,
      required this.priority,
      required this.status,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.lastPingAt,
      this.nextPingAt,
      required this.pingCount,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['waiting_on_name'] = Variable<String>(waitingOnName);
    if (!nullToAbsent || waitingOnOrg != null) {
      map['waiting_on_org'] = Variable<String>(waitingOnOrg);
    }
    map['channel'] = Variable<String>(channel);
    map['priority'] = Variable<String>(priority);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || lastPingAt != null) {
      map['last_ping_at'] = Variable<int>(lastPingAt);
    }
    if (!nullToAbsent || nextPingAt != null) {
      map['next_ping_at'] = Variable<int>(nextPingAt);
    }
    map['ping_count'] = Variable<int>(pingCount);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  FollowUpsCompanion toCompanion(bool nullToAbsent) {
    return FollowUpsCompanion(
      id: Value(id),
      title: Value(title),
      waitingOnName: Value(waitingOnName),
      waitingOnOrg: waitingOnOrg == null && nullToAbsent
          ? const Value.absent()
          : Value(waitingOnOrg),
      channel: Value(channel),
      priority: Value(priority),
      status: Value(status),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastPingAt: lastPingAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPingAt),
      nextPingAt: nextPingAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextPingAt),
      pingCount: Value(pingCount),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory FollowUp.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FollowUp(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      waitingOnName: serializer.fromJson<String>(json['waitingOnName']),
      waitingOnOrg: serializer.fromJson<String?>(json['waitingOnOrg']),
      channel: serializer.fromJson<String>(json['channel']),
      priority: serializer.fromJson<String>(json['priority']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      lastPingAt: serializer.fromJson<int?>(json['lastPingAt']),
      nextPingAt: serializer.fromJson<int?>(json['nextPingAt']),
      pingCount: serializer.fromJson<int>(json['pingCount']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'waitingOnName': serializer.toJson<String>(waitingOnName),
      'waitingOnOrg': serializer.toJson<String?>(waitingOnOrg),
      'channel': serializer.toJson<String>(channel),
      'priority': serializer.toJson<String>(priority),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'lastPingAt': serializer.toJson<int?>(lastPingAt),
      'nextPingAt': serializer.toJson<int?>(nextPingAt),
      'pingCount': serializer.toJson<int>(pingCount),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  FollowUp copyWith(
          {String? id,
          String? title,
          String? waitingOnName,
          Value<String?> waitingOnOrg = const Value.absent(),
          String? channel,
          String? priority,
          String? status,
          Value<String?> notes = const Value.absent(),
          int? createdAt,
          int? updatedAt,
          Value<int?> lastPingAt = const Value.absent(),
          Value<int?> nextPingAt = const Value.absent(),
          int? pingCount,
          Value<int?> deletedAt = const Value.absent()}) =>
      FollowUp(
        id: id ?? this.id,
        title: title ?? this.title,
        waitingOnName: waitingOnName ?? this.waitingOnName,
        waitingOnOrg:
            waitingOnOrg.present ? waitingOnOrg.value : this.waitingOnOrg,
        channel: channel ?? this.channel,
        priority: priority ?? this.priority,
        status: status ?? this.status,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastPingAt: lastPingAt.present ? lastPingAt.value : this.lastPingAt,
        nextPingAt: nextPingAt.present ? nextPingAt.value : this.nextPingAt,
        pingCount: pingCount ?? this.pingCount,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  FollowUp copyWithCompanion(FollowUpsCompanion data) {
    return FollowUp(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      waitingOnName: data.waitingOnName.present
          ? data.waitingOnName.value
          : this.waitingOnName,
      waitingOnOrg: data.waitingOnOrg.present
          ? data.waitingOnOrg.value
          : this.waitingOnOrg,
      channel: data.channel.present ? data.channel.value : this.channel,
      priority: data.priority.present ? data.priority.value : this.priority,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastPingAt:
          data.lastPingAt.present ? data.lastPingAt.value : this.lastPingAt,
      nextPingAt:
          data.nextPingAt.present ? data.nextPingAt.value : this.nextPingAt,
      pingCount: data.pingCount.present ? data.pingCount.value : this.pingCount,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FollowUp(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('waitingOnName: $waitingOnName, ')
          ..write('waitingOnOrg: $waitingOnOrg, ')
          ..write('channel: $channel, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastPingAt: $lastPingAt, ')
          ..write('nextPingAt: $nextPingAt, ')
          ..write('pingCount: $pingCount, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      waitingOnName,
      waitingOnOrg,
      channel,
      priority,
      status,
      notes,
      createdAt,
      updatedAt,
      lastPingAt,
      nextPingAt,
      pingCount,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FollowUp &&
          other.id == this.id &&
          other.title == this.title &&
          other.waitingOnName == this.waitingOnName &&
          other.waitingOnOrg == this.waitingOnOrg &&
          other.channel == this.channel &&
          other.priority == this.priority &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastPingAt == this.lastPingAt &&
          other.nextPingAt == this.nextPingAt &&
          other.pingCount == this.pingCount &&
          other.deletedAt == this.deletedAt);
}

class FollowUpsCompanion extends UpdateCompanion<FollowUp> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> waitingOnName;
  final Value<String?> waitingOnOrg;
  final Value<String> channel;
  final Value<String> priority;
  final Value<String> status;
  final Value<String?> notes;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> lastPingAt;
  final Value<int?> nextPingAt;
  final Value<int> pingCount;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const FollowUpsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.waitingOnName = const Value.absent(),
    this.waitingOnOrg = const Value.absent(),
    this.channel = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastPingAt = const Value.absent(),
    this.nextPingAt = const Value.absent(),
    this.pingCount = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FollowUpsCompanion.insert({
    required String id,
    required String title,
    required String waitingOnName,
    this.waitingOnOrg = const Value.absent(),
    required String channel,
    required String priority,
    required String status,
    this.notes = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.lastPingAt = const Value.absent(),
    this.nextPingAt = const Value.absent(),
    this.pingCount = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        waitingOnName = Value(waitingOnName),
        channel = Value(channel),
        priority = Value(priority),
        status = Value(status),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<FollowUp> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? waitingOnName,
    Expression<String>? waitingOnOrg,
    Expression<String>? channel,
    Expression<String>? priority,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? lastPingAt,
    Expression<int>? nextPingAt,
    Expression<int>? pingCount,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (waitingOnName != null) 'waiting_on_name': waitingOnName,
      if (waitingOnOrg != null) 'waiting_on_org': waitingOnOrg,
      if (channel != null) 'channel': channel,
      if (priority != null) 'priority': priority,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastPingAt != null) 'last_ping_at': lastPingAt,
      if (nextPingAt != null) 'next_ping_at': nextPingAt,
      if (pingCount != null) 'ping_count': pingCount,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FollowUpsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? waitingOnName,
      Value<String?>? waitingOnOrg,
      Value<String>? channel,
      Value<String>? priority,
      Value<String>? status,
      Value<String?>? notes,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<int?>? lastPingAt,
      Value<int?>? nextPingAt,
      Value<int>? pingCount,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return FollowUpsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      waitingOnName: waitingOnName ?? this.waitingOnName,
      waitingOnOrg: waitingOnOrg ?? this.waitingOnOrg,
      channel: channel ?? this.channel,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastPingAt: lastPingAt ?? this.lastPingAt,
      nextPingAt: nextPingAt ?? this.nextPingAt,
      pingCount: pingCount ?? this.pingCount,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (waitingOnName.present) {
      map['waiting_on_name'] = Variable<String>(waitingOnName.value);
    }
    if (waitingOnOrg.present) {
      map['waiting_on_org'] = Variable<String>(waitingOnOrg.value);
    }
    if (channel.present) {
      map['channel'] = Variable<String>(channel.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (lastPingAt.present) {
      map['last_ping_at'] = Variable<int>(lastPingAt.value);
    }
    if (nextPingAt.present) {
      map['next_ping_at'] = Variable<int>(nextPingAt.value);
    }
    if (pingCount.present) {
      map['ping_count'] = Variable<int>(pingCount.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FollowUpsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('waitingOnName: $waitingOnName, ')
          ..write('waitingOnOrg: $waitingOnOrg, ')
          ..write('channel: $channel, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastPingAt: $lastPingAt, ')
          ..write('nextPingAt: $nextPingAt, ')
          ..write('pingCount: $pingCount, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _followupIdMeta =
      const VerificationMeta('followupId');
  @override
  late final GeneratedColumn<String> followupId = GeneratedColumn<String>(
      'followup_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _atMeta = const VerificationMeta('at');
  @override
  late final GeneratedColumn<int> at = GeneratedColumn<int>(
      'at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _metaJsonMeta =
      const VerificationMeta('metaJson');
  @override
  late final GeneratedColumn<String> metaJson = GeneratedColumn<String>(
      'meta_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, followupId, type, at, metaJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('followup_id')) {
      context.handle(
          _followupIdMeta,
          followupId.isAcceptableOrUnknown(
              data['followup_id']!, _followupIdMeta));
    } else if (isInserting) {
      context.missing(_followupIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('at')) {
      context.handle(_atMeta, at.isAcceptableOrUnknown(data['at']!, _atMeta));
    } else if (isInserting) {
      context.missing(_atMeta);
    }
    if (data.containsKey('meta_json')) {
      context.handle(_metaJsonMeta,
          metaJson.isAcceptableOrUnknown(data['meta_json']!, _metaJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      followupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}followup_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      at: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}at'])!,
      metaJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meta_json']),
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final String id;
  final String followupId;
  final String type;
  final int at;
  final String? metaJson;
  const Event(
      {required this.id,
      required this.followupId,
      required this.type,
      required this.at,
      this.metaJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['followup_id'] = Variable<String>(followupId);
    map['type'] = Variable<String>(type);
    map['at'] = Variable<int>(at);
    if (!nullToAbsent || metaJson != null) {
      map['meta_json'] = Variable<String>(metaJson);
    }
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      followupId: Value(followupId),
      type: Value(type),
      at: Value(at),
      metaJson: metaJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metaJson),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<String>(json['id']),
      followupId: serializer.fromJson<String>(json['followupId']),
      type: serializer.fromJson<String>(json['type']),
      at: serializer.fromJson<int>(json['at']),
      metaJson: serializer.fromJson<String?>(json['metaJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'followupId': serializer.toJson<String>(followupId),
      'type': serializer.toJson<String>(type),
      'at': serializer.toJson<int>(at),
      'metaJson': serializer.toJson<String?>(metaJson),
    };
  }

  Event copyWith(
          {String? id,
          String? followupId,
          String? type,
          int? at,
          Value<String?> metaJson = const Value.absent()}) =>
      Event(
        id: id ?? this.id,
        followupId: followupId ?? this.followupId,
        type: type ?? this.type,
        at: at ?? this.at,
        metaJson: metaJson.present ? metaJson.value : this.metaJson,
      );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      followupId:
          data.followupId.present ? data.followupId.value : this.followupId,
      type: data.type.present ? data.type.value : this.type,
      at: data.at.present ? data.at.value : this.at,
      metaJson: data.metaJson.present ? data.metaJson.value : this.metaJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('followupId: $followupId, ')
          ..write('type: $type, ')
          ..write('at: $at, ')
          ..write('metaJson: $metaJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, followupId, type, at, metaJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.followupId == this.followupId &&
          other.type == this.type &&
          other.at == this.at &&
          other.metaJson == this.metaJson);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<String> id;
  final Value<String> followupId;
  final Value<String> type;
  final Value<int> at;
  final Value<String?> metaJson;
  final Value<int> rowid;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.followupId = const Value.absent(),
    this.type = const Value.absent(),
    this.at = const Value.absent(),
    this.metaJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    required String id,
    required String followupId,
    required String type,
    required int at,
    this.metaJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        followupId = Value(followupId),
        type = Value(type),
        at = Value(at);
  static Insertable<Event> custom({
    Expression<String>? id,
    Expression<String>? followupId,
    Expression<String>? type,
    Expression<int>? at,
    Expression<String>? metaJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (followupId != null) 'followup_id': followupId,
      if (type != null) 'type': type,
      if (at != null) 'at': at,
      if (metaJson != null) 'meta_json': metaJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? followupId,
      Value<String>? type,
      Value<int>? at,
      Value<String?>? metaJson,
      Value<int>? rowid}) {
    return EventsCompanion(
      id: id ?? this.id,
      followupId: followupId ?? this.followupId,
      type: type ?? this.type,
      at: at ?? this.at,
      metaJson: metaJson ?? this.metaJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (followupId.present) {
      map['followup_id'] = Variable<String>(followupId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (at.present) {
      map['at'] = Variable<int>(at.value);
    }
    if (metaJson.present) {
      map['meta_json'] = Variable<String>(metaJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('followupId: $followupId, ')
          ..write('type: $type, ')
          ..write('at: $at, ')
          ..write('metaJson: $metaJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StandupEntriesTable extends StandupEntries
    with TableInfo<$StandupEntriesTable, StandupEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StandupEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _doneTextMeta =
      const VerificationMeta('doneText');
  @override
  late final GeneratedColumn<String> doneText = GeneratedColumn<String>(
      'done_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _doingTextMeta =
      const VerificationMeta('doingText');
  @override
  late final GeneratedColumn<String> doingText = GeneratedColumn<String>(
      'doing_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _blockersTextMeta =
      const VerificationMeta('blockersText');
  @override
  late final GeneratedColumn<String> blockersText = GeneratedColumn<String>(
      'blockers_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagsJsonMeta =
      const VerificationMeta('tagsJson');
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
      'tags_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<int> deletedAt = GeneratedColumn<int>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        doneText,
        doingText,
        blockersText,
        tagsJson,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'standup_entries';
  @override
  VerificationContext validateIntegrity(Insertable<StandupEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('done_text')) {
      context.handle(_doneTextMeta,
          doneText.isAcceptableOrUnknown(data['done_text']!, _doneTextMeta));
    } else if (isInserting) {
      context.missing(_doneTextMeta);
    }
    if (data.containsKey('doing_text')) {
      context.handle(_doingTextMeta,
          doingText.isAcceptableOrUnknown(data['doing_text']!, _doingTextMeta));
    } else if (isInserting) {
      context.missing(_doingTextMeta);
    }
    if (data.containsKey('blockers_text')) {
      context.handle(
          _blockersTextMeta,
          blockersText.isAcceptableOrUnknown(
              data['blockers_text']!, _blockersTextMeta));
    } else if (isInserting) {
      context.missing(_blockersTextMeta);
    }
    if (data.containsKey('tags_json')) {
      context.handle(_tagsJsonMeta,
          tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StandupEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StandupEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      doneText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}done_text'])!,
      doingText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}doing_text'])!,
      blockersText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blockers_text'])!,
      tagsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $StandupEntriesTable createAlias(String alias) {
    return $StandupEntriesTable(attachedDatabase, alias);
  }
}

class StandupEntry extends DataClass implements Insertable<StandupEntry> {
  final String id;
  final String date;
  final String doneText;
  final String doingText;
  final String blockersText;
  final String? tagsJson;
  final int createdAt;
  final int updatedAt;
  final int? deletedAt;
  const StandupEntry(
      {required this.id,
      required this.date,
      required this.doneText,
      required this.doingText,
      required this.blockersText,
      this.tagsJson,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['done_text'] = Variable<String>(doneText);
    map['doing_text'] = Variable<String>(doingText);
    map['blockers_text'] = Variable<String>(blockersText);
    if (!nullToAbsent || tagsJson != null) {
      map['tags_json'] = Variable<String>(tagsJson);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<int>(deletedAt);
    }
    return map;
  }

  StandupEntriesCompanion toCompanion(bool nullToAbsent) {
    return StandupEntriesCompanion(
      id: Value(id),
      date: Value(date),
      doneText: Value(doneText),
      doingText: Value(doingText),
      blockersText: Value(blockersText),
      tagsJson: tagsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(tagsJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory StandupEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StandupEntry(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      doneText: serializer.fromJson<String>(json['doneText']),
      doingText: serializer.fromJson<String>(json['doingText']),
      blockersText: serializer.fromJson<String>(json['blockersText']),
      tagsJson: serializer.fromJson<String?>(json['tagsJson']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      deletedAt: serializer.fromJson<int?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'doneText': serializer.toJson<String>(doneText),
      'doingText': serializer.toJson<String>(doingText),
      'blockersText': serializer.toJson<String>(blockersText),
      'tagsJson': serializer.toJson<String?>(tagsJson),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'deletedAt': serializer.toJson<int?>(deletedAt),
    };
  }

  StandupEntry copyWith(
          {String? id,
          String? date,
          String? doneText,
          String? doingText,
          String? blockersText,
          Value<String?> tagsJson = const Value.absent(),
          int? createdAt,
          int? updatedAt,
          Value<int?> deletedAt = const Value.absent()}) =>
      StandupEntry(
        id: id ?? this.id,
        date: date ?? this.date,
        doneText: doneText ?? this.doneText,
        doingText: doingText ?? this.doingText,
        blockersText: blockersText ?? this.blockersText,
        tagsJson: tagsJson.present ? tagsJson.value : this.tagsJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  StandupEntry copyWithCompanion(StandupEntriesCompanion data) {
    return StandupEntry(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      doneText: data.doneText.present ? data.doneText.value : this.doneText,
      doingText: data.doingText.present ? data.doingText.value : this.doingText,
      blockersText: data.blockersText.present
          ? data.blockersText.value
          : this.blockersText,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StandupEntry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('doneText: $doneText, ')
          ..write('doingText: $doingText, ')
          ..write('blockersText: $blockersText, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, doneText, doingText, blockersText,
      tagsJson, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StandupEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.doneText == this.doneText &&
          other.doingText == this.doingText &&
          other.blockersText == this.blockersText &&
          other.tagsJson == this.tagsJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class StandupEntriesCompanion extends UpdateCompanion<StandupEntry> {
  final Value<String> id;
  final Value<String> date;
  final Value<String> doneText;
  final Value<String> doingText;
  final Value<String> blockersText;
  final Value<String?> tagsJson;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int?> deletedAt;
  final Value<int> rowid;
  const StandupEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.doneText = const Value.absent(),
    this.doingText = const Value.absent(),
    this.blockersText = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StandupEntriesCompanion.insert({
    required String id,
    required String date,
    required String doneText,
    required String doingText,
    required String blockersText,
    this.tagsJson = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        doneText = Value(doneText),
        doingText = Value(doingText),
        blockersText = Value(blockersText),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<StandupEntry> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? doneText,
    Expression<String>? doingText,
    Expression<String>? blockersText,
    Expression<String>? tagsJson,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (doneText != null) 'done_text': doneText,
      if (doingText != null) 'doing_text': doingText,
      if (blockersText != null) 'blockers_text': blockersText,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StandupEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<String>? doneText,
      Value<String>? doingText,
      Value<String>? blockersText,
      Value<String?>? tagsJson,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<int?>? deletedAt,
      Value<int>? rowid}) {
    return StandupEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      doneText: doneText ?? this.doneText,
      doingText: doingText ?? this.doingText,
      blockersText: blockersText ?? this.blockersText,
      tagsJson: tagsJson ?? this.tagsJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (doneText.present) {
      map['done_text'] = Variable<String>(doneText.value);
    }
    if (doingText.present) {
      map['doing_text'] = Variable<String>(doingText.value);
    }
    if (blockersText.present) {
      map['blockers_text'] = Variable<String>(blockersText.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<int>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StandupEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('doneText: $doneText, ')
          ..write('doingText: $doingText, ')
          ..write('blockersText: $blockersText, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TemplatesTable extends Templates
    with TableInfo<$TemplatesTable, Template> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _toneMeta = const VerificationMeta('tone');
  @override
  late final GeneratedColumn<String> tone = GeneratedColumn<String>(
      'tone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, tone, body, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'templates';
  @override
  VerificationContext validateIntegrity(Insertable<Template> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('tone')) {
      context.handle(
          _toneMeta, tone.isAcceptableOrUnknown(data['tone']!, _toneMeta));
    } else if (isInserting) {
      context.missing(_toneMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Template map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Template(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      tone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tone'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TemplatesTable createAlias(String alias) {
    return $TemplatesTable(attachedDatabase, alias);
  }
}

class Template extends DataClass implements Insertable<Template> {
  final String id;
  final String name;
  final String tone;
  final String body;
  final int createdAt;
  final int updatedAt;
  const Template(
      {required this.id,
      required this.name,
      required this.tone,
      required this.body,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['tone'] = Variable<String>(tone);
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  TemplatesCompanion toCompanion(bool nullToAbsent) {
    return TemplatesCompanion(
      id: Value(id),
      name: Value(name),
      tone: Value(tone),
      body: Value(body),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Template.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Template(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      tone: serializer.fromJson<String>(json['tone']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'tone': serializer.toJson<String>(tone),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  Template copyWith(
          {String? id,
          String? name,
          String? tone,
          String? body,
          int? createdAt,
          int? updatedAt}) =>
      Template(
        id: id ?? this.id,
        name: name ?? this.name,
        tone: tone ?? this.tone,
        body: body ?? this.body,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Template copyWithCompanion(TemplatesCompanion data) {
    return Template(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      tone: data.tone.present ? data.tone.value : this.tone,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Template(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tone: $tone, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, tone, body, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Template &&
          other.id == this.id &&
          other.name == this.name &&
          other.tone == this.tone &&
          other.body == this.body &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TemplatesCompanion extends UpdateCompanion<Template> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> tone;
  final Value<String> body;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const TemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.tone = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TemplatesCompanion.insert({
    required String id,
    required String name,
    required String tone,
    required String body,
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        tone = Value(tone),
        body = Value(body),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Template> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? tone,
    Expression<String>? body,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (tone != null) 'tone': tone,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TemplatesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? tone,
      Value<String>? body,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return TemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      tone: tone ?? this.tone,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (tone.present) {
      map['tone'] = Variable<String>(tone.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tone: $tone, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FollowUpsTable followUps = $FollowUpsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $StandupEntriesTable standupEntries = $StandupEntriesTable(this);
  late final $TemplatesTable templates = $TemplatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [followUps, events, standupEntries, templates];
}

typedef $$FollowUpsTableCreateCompanionBuilder = FollowUpsCompanion Function({
  required String id,
  required String title,
  required String waitingOnName,
  Value<String?> waitingOnOrg,
  required String channel,
  required String priority,
  required String status,
  Value<String?> notes,
  required int createdAt,
  required int updatedAt,
  Value<int?> lastPingAt,
  Value<int?> nextPingAt,
  Value<int> pingCount,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$FollowUpsTableUpdateCompanionBuilder = FollowUpsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> waitingOnName,
  Value<String?> waitingOnOrg,
  Value<String> channel,
  Value<String> priority,
  Value<String> status,
  Value<String?> notes,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int?> lastPingAt,
  Value<int?> nextPingAt,
  Value<int> pingCount,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$FollowUpsTableFilterComposer
    extends Composer<_$AppDatabase, $FollowUpsTable> {
  $$FollowUpsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get waitingOnName => $composableBuilder(
      column: $table.waitingOnName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get waitingOnOrg => $composableBuilder(
      column: $table.waitingOnOrg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get channel => $composableBuilder(
      column: $table.channel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastPingAt => $composableBuilder(
      column: $table.lastPingAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nextPingAt => $composableBuilder(
      column: $table.nextPingAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pingCount => $composableBuilder(
      column: $table.pingCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$FollowUpsTableOrderingComposer
    extends Composer<_$AppDatabase, $FollowUpsTable> {
  $$FollowUpsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get waitingOnName => $composableBuilder(
      column: $table.waitingOnName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get waitingOnOrg => $composableBuilder(
      column: $table.waitingOnOrg,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get channel => $composableBuilder(
      column: $table.channel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastPingAt => $composableBuilder(
      column: $table.lastPingAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nextPingAt => $composableBuilder(
      column: $table.nextPingAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pingCount => $composableBuilder(
      column: $table.pingCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$FollowUpsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FollowUpsTable> {
  $$FollowUpsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get waitingOnName => $composableBuilder(
      column: $table.waitingOnName, builder: (column) => column);

  GeneratedColumn<String> get waitingOnOrg => $composableBuilder(
      column: $table.waitingOnOrg, builder: (column) => column);

  GeneratedColumn<String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get lastPingAt => $composableBuilder(
      column: $table.lastPingAt, builder: (column) => column);

  GeneratedColumn<int> get nextPingAt => $composableBuilder(
      column: $table.nextPingAt, builder: (column) => column);

  GeneratedColumn<int> get pingCount =>
      $composableBuilder(column: $table.pingCount, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$FollowUpsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FollowUpsTable,
    FollowUp,
    $$FollowUpsTableFilterComposer,
    $$FollowUpsTableOrderingComposer,
    $$FollowUpsTableAnnotationComposer,
    $$FollowUpsTableCreateCompanionBuilder,
    $$FollowUpsTableUpdateCompanionBuilder,
    (FollowUp, BaseReferences<_$AppDatabase, $FollowUpsTable, FollowUp>),
    FollowUp,
    PrefetchHooks Function()> {
  $$FollowUpsTableTableManager(_$AppDatabase db, $FollowUpsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FollowUpsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FollowUpsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FollowUpsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> waitingOnName = const Value.absent(),
            Value<String?> waitingOnOrg = const Value.absent(),
            Value<String> channel = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int?> lastPingAt = const Value.absent(),
            Value<int?> nextPingAt = const Value.absent(),
            Value<int> pingCount = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FollowUpsCompanion(
            id: id,
            title: title,
            waitingOnName: waitingOnName,
            waitingOnOrg: waitingOnOrg,
            channel: channel,
            priority: priority,
            status: status,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastPingAt: lastPingAt,
            nextPingAt: nextPingAt,
            pingCount: pingCount,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String waitingOnName,
            Value<String?> waitingOnOrg = const Value.absent(),
            required String channel,
            required String priority,
            required String status,
            Value<String?> notes = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<int?> lastPingAt = const Value.absent(),
            Value<int?> nextPingAt = const Value.absent(),
            Value<int> pingCount = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FollowUpsCompanion.insert(
            id: id,
            title: title,
            waitingOnName: waitingOnName,
            waitingOnOrg: waitingOnOrg,
            channel: channel,
            priority: priority,
            status: status,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastPingAt: lastPingAt,
            nextPingAt: nextPingAt,
            pingCount: pingCount,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FollowUpsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FollowUpsTable,
    FollowUp,
    $$FollowUpsTableFilterComposer,
    $$FollowUpsTableOrderingComposer,
    $$FollowUpsTableAnnotationComposer,
    $$FollowUpsTableCreateCompanionBuilder,
    $$FollowUpsTableUpdateCompanionBuilder,
    (FollowUp, BaseReferences<_$AppDatabase, $FollowUpsTable, FollowUp>),
    FollowUp,
    PrefetchHooks Function()>;
typedef $$EventsTableCreateCompanionBuilder = EventsCompanion Function({
  required String id,
  required String followupId,
  required String type,
  required int at,
  Value<String?> metaJson,
  Value<int> rowid,
});
typedef $$EventsTableUpdateCompanionBuilder = EventsCompanion Function({
  Value<String> id,
  Value<String> followupId,
  Value<String> type,
  Value<int> at,
  Value<String?> metaJson,
  Value<int> rowid,
});

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get followupId => $composableBuilder(
      column: $table.followupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get at => $composableBuilder(
      column: $table.at, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metaJson => $composableBuilder(
      column: $table.metaJson, builder: (column) => ColumnFilters(column));
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get followupId => $composableBuilder(
      column: $table.followupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get at => $composableBuilder(
      column: $table.at, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metaJson => $composableBuilder(
      column: $table.metaJson, builder: (column) => ColumnOrderings(column));
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get followupId => $composableBuilder(
      column: $table.followupId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get at =>
      $composableBuilder(column: $table.at, builder: (column) => column);

  GeneratedColumn<String> get metaJson =>
      $composableBuilder(column: $table.metaJson, builder: (column) => column);
}

class $$EventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, BaseReferences<_$AppDatabase, $EventsTable, Event>),
    Event,
    PrefetchHooks Function()> {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> followupId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> at = const Value.absent(),
            Value<String?> metaJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EventsCompanion(
            id: id,
            followupId: followupId,
            type: type,
            at: at,
            metaJson: metaJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String followupId,
            required String type,
            required int at,
            Value<String?> metaJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EventsCompanion.insert(
            id: id,
            followupId: followupId,
            type: type,
            at: at,
            metaJson: metaJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, BaseReferences<_$AppDatabase, $EventsTable, Event>),
    Event,
    PrefetchHooks Function()>;
typedef $$StandupEntriesTableCreateCompanionBuilder = StandupEntriesCompanion
    Function({
  required String id,
  required String date,
  required String doneText,
  required String doingText,
  required String blockersText,
  Value<String?> tagsJson,
  required int createdAt,
  required int updatedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});
typedef $$StandupEntriesTableUpdateCompanionBuilder = StandupEntriesCompanion
    Function({
  Value<String> id,
  Value<String> date,
  Value<String> doneText,
  Value<String> doingText,
  Value<String> blockersText,
  Value<String?> tagsJson,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int?> deletedAt,
  Value<int> rowid,
});

class $$StandupEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $StandupEntriesTable> {
  $$StandupEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get doneText => $composableBuilder(
      column: $table.doneText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get doingText => $composableBuilder(
      column: $table.doingText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get blockersText => $composableBuilder(
      column: $table.blockersText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));
}

class $$StandupEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $StandupEntriesTable> {
  $$StandupEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get doneText => $composableBuilder(
      column: $table.doneText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get doingText => $composableBuilder(
      column: $table.doingText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get blockersText => $composableBuilder(
      column: $table.blockersText,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$StandupEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StandupEntriesTable> {
  $$StandupEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get doneText =>
      $composableBuilder(column: $table.doneText, builder: (column) => column);

  GeneratedColumn<String> get doingText =>
      $composableBuilder(column: $table.doingText, builder: (column) => column);

  GeneratedColumn<String> get blockersText => $composableBuilder(
      column: $table.blockersText, builder: (column) => column);

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$StandupEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StandupEntriesTable,
    StandupEntry,
    $$StandupEntriesTableFilterComposer,
    $$StandupEntriesTableOrderingComposer,
    $$StandupEntriesTableAnnotationComposer,
    $$StandupEntriesTableCreateCompanionBuilder,
    $$StandupEntriesTableUpdateCompanionBuilder,
    (
      StandupEntry,
      BaseReferences<_$AppDatabase, $StandupEntriesTable, StandupEntry>
    ),
    StandupEntry,
    PrefetchHooks Function()> {
  $$StandupEntriesTableTableManager(
      _$AppDatabase db, $StandupEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StandupEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StandupEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StandupEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> doneText = const Value.absent(),
            Value<String> doingText = const Value.absent(),
            Value<String> blockersText = const Value.absent(),
            Value<String?> tagsJson = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StandupEntriesCompanion(
            id: id,
            date: date,
            doneText: doneText,
            doingText: doingText,
            blockersText: blockersText,
            tagsJson: tagsJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String date,
            required String doneText,
            required String doingText,
            required String blockersText,
            Value<String?> tagsJson = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<int?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StandupEntriesCompanion.insert(
            id: id,
            date: date,
            doneText: doneText,
            doingText: doingText,
            blockersText: blockersText,
            tagsJson: tagsJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StandupEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StandupEntriesTable,
    StandupEntry,
    $$StandupEntriesTableFilterComposer,
    $$StandupEntriesTableOrderingComposer,
    $$StandupEntriesTableAnnotationComposer,
    $$StandupEntriesTableCreateCompanionBuilder,
    $$StandupEntriesTableUpdateCompanionBuilder,
    (
      StandupEntry,
      BaseReferences<_$AppDatabase, $StandupEntriesTable, StandupEntry>
    ),
    StandupEntry,
    PrefetchHooks Function()>;
typedef $$TemplatesTableCreateCompanionBuilder = TemplatesCompanion Function({
  required String id,
  required String name,
  required String tone,
  required String body,
  required int createdAt,
  required int updatedAt,
  Value<int> rowid,
});
typedef $$TemplatesTableUpdateCompanionBuilder = TemplatesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> tone,
  Value<String> body,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int> rowid,
});

class $$TemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tone => $composableBuilder(
      column: $table.tone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tone => $composableBuilder(
      column: $table.tone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get tone =>
      $composableBuilder(column: $table.tone, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TemplatesTable,
    Template,
    $$TemplatesTableFilterComposer,
    $$TemplatesTableOrderingComposer,
    $$TemplatesTableAnnotationComposer,
    $$TemplatesTableCreateCompanionBuilder,
    $$TemplatesTableUpdateCompanionBuilder,
    (Template, BaseReferences<_$AppDatabase, $TemplatesTable, Template>),
    Template,
    PrefetchHooks Function()> {
  $$TemplatesTableTableManager(_$AppDatabase db, $TemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> tone = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TemplatesCompanion(
            id: id,
            name: name,
            tone: tone,
            body: body,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String tone,
            required String body,
            required int createdAt,
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TemplatesCompanion.insert(
            id: id,
            name: name,
            tone: tone,
            body: body,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TemplatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TemplatesTable,
    Template,
    $$TemplatesTableFilterComposer,
    $$TemplatesTableOrderingComposer,
    $$TemplatesTableAnnotationComposer,
    $$TemplatesTableCreateCompanionBuilder,
    $$TemplatesTableUpdateCompanionBuilder,
    (Template, BaseReferences<_$AppDatabase, $TemplatesTable, Template>),
    Template,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FollowUpsTableTableManager get followUps =>
      $$FollowUpsTableTableManager(_db, _db.followUps);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$StandupEntriesTableTableManager get standupEntries =>
      $$StandupEntriesTableTableManager(_db, _db.standupEntries);
  $$TemplatesTableTableManager get templates =>
      $$TemplatesTableTableManager(_db, _db.templates);
}
