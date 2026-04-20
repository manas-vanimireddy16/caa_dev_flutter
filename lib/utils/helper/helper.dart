import 'dart:async';

import 'package:intl/intl.dart';

part 'debounce.dart';
part 'throttle.dart';

final RegExp hashtagRegExp = RegExp(r'\B#\w+\b');
final RegExp mentionRegExp = RegExp(r'\B@\w+\b');

String formatDate(String? raw) {
  if (raw == null) return "";
  try {
    final dt = DateTime.parse(raw).toLocal();
    return DateFormat("MMM dd, yyyy | hh:mm a").format(dt);
  } catch (_) {
    return raw;
  }
}

String formatDateForCreateRequest() {
  return DateFormat("yyyy-MM-dd").format(DateTime.now());
}
