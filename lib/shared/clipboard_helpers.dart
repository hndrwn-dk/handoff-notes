import 'package:flutter/services.dart';

/// Copies [text] to clipboard. Returns true on success.
Future<bool> copyToClipboard(String text) async {
  if (text.isEmpty) return false;
  try {
    await Clipboard.setData(ClipboardData(text: text));
    return true;
  } catch (_) {
    return false;
  }
}
