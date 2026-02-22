import 'package:drift/drift.dart';
import '../database/app_database.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

const defaultTemplates = [
  _TemplateRow('Gentle', 'gentle', 'Hi {name}, just checking on {topic}. Any update when you have a moment? Thanks.'),
  _TemplateRow('Firm', 'firm', 'Hi {name}, following up on {topic}. Could you share the status and ETA? Thank you.'),
  _TemplateRow('Urgent', 'urgent', 'Hi {name}, we need an update on {topic} today to avoid delay. Can you confirm next steps? Thanks.'),
];

class _TemplateRow {
  const _TemplateRow(this.name, this.tone, this.body);
  final String name, tone, body;
}

class TemplateRepository {
  TemplateRepository(this._db);

  final AppDatabase _db;

  Future<List<Template>> getAll() => _db.getAllTemplates();

  Future<Template?> getByTone(String tone) => _db.getTemplateByTone(tone);

  Future<void> ensureDefaults() async {
    final existing = await _db.getAllTemplates();
    if (existing.isNotEmpty) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    for (final t in defaultTemplates) {
      await _db.insertTemplate(TemplatesCompanion(
        id: Value(_uuid.v4()),
        name: Value(t.name),
        tone: Value(t.tone),
        body: Value(t.body),
        createdAt: Value(now),
        updatedAt: Value(now),
      ));
    }
  }

  Future<void> updateTemplate(String id, {String? name, String? tone, String? body}) async {
    final existing = await _db.getAllTemplates();
    final t = existing.where((e) => e.id == id).firstOrNull;
    if (t == null) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.updateTemplate(TemplatesCompanion(
      id: Value(id),
      name: name != null ? Value(name) : Value(t.name),
      tone: tone != null ? Value(tone) : Value(t.tone),
      body: body != null ? Value(body) : Value(t.body),
      updatedAt: Value(now),
    ));
  }
}

/// Replaces {name} and {topic} in template body.
String fillTemplate(String body, {String name = '', String topic = ''}) {
  return body.replaceAll('{name}', name).replaceAll('{topic}', topic);
}
