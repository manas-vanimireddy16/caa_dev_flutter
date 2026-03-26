import 'dart:ui';
import 'package:auto_route/annotations.dart';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/modules/router/app_router.dart';
import 'package:code_setup/presentation/app.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:msal_auth/msal_auth.dart';
import 'environment/environment.dart';
import '../utils/localization_provider/localization_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KAppX.connectivity.onBootUp();
  await Hive.initFlutter();
  await Hive.openBox('Bookmarks');
  await Hive.openBox('language');
  await Hive.openBox('loginToken');
  await Hive.openBox('userDetails');

  final selectedLang = Hive.box('language');
  String language = selectedLang.get('lang', defaultValue: 'en');

  runApp(
    UncontrolledProviderScope(
      container: KAppX.globalProvider,
      child: ProviderScope(
        overrides: [localeProvider.overrideWith((ref) => Locale(language))],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late SingleAccountPca msal;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);
    final appRouter = AppRouter.instance;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      locale: locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter.config(),
    );
  }
}
