import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final localeProvider = StateProvider<Locale>((ref) {
  final code = Hive.box('language').get('lang', defaultValue: 'en') as String;
  return Locale(code);
});

Future<void> setAppLocale(Ref ref, String languageCode) async {
  await Hive.box('language').put('lang', languageCode);
  ref.read(localeProvider.notifier).state = Locale(languageCode);
}
