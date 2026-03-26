import 'package:auto_route/auto_route.dart';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/screens/home_screen/approvals/view.dart';
import 'package:code_setup/presentation/screens/home_screen/dashboard/dashboard.dart';
import 'package:code_setup/presentation/screens/it_services/salalah/view.dart';
import 'package:code_setup/presentation/screens/home_screen/services/view.dart';
import 'package:code_setup/presentation/screens/it_services/vpn/view.dart';
import 'package:code_setup/presentation/screens/it_services/muscat/view.dart';
import 'package:code_setup/utils/localization_provider/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return AutoTabsRouter(
    //   routes: const [
    //     Dashboard(),
    //     MuscatDashboard(),
    //     VpnDashboard(),
    //     AnnouncementScreen(),
    //     ApprovalsList(),
    //     Services(),
    //   ],

    //   builder: (context, child, animation) {},

    // final currentIndex = ref.watch(bottomNavIndexProvider);

    // final languages = [
    //   KDropdownItem(value: "ar", child: const Text("Arabic")),
    //   KDropdownItem(value: "en", child: const Text("English")),
    // ];

    // return KScaffold(
    //   appBar: AppBar(
    //     title: Text(AppLocalizations.of(context)!.welcomeToHama),
    //     actions: [
    //       SizedBox(
    //         width: 200,
    //         height: 60,
    //         child: KDropdownField<String>(
    //           //fieldHeadingText: "Language *",
    //           items: languages,
    //           value: selectedLanguage,
    //           hintText: AppLocalizations.of(context)!.selectLanguage,
    //           onChanged: (val) {
    //             setState(() => selectedLanguage = val);
    //             if (val != null) {
    //               ref.read(localeProvider.notifier).state = Locale(val);
    //               final selectedLang = Hive.box('language');
    //               selectedLang.put('lang', val);
    //             }
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    //   body: _screens[currentIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: currentIndex,
    //     onTap: (index) {
    //       ref.read(bottomNavIndexProvider.notifier).state = index;
    //     },
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         // label: AppLocalizations.of(context)!.dashboard,
    //         label: AppLocalizations.of(context)!.salalah,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: const Icon(Icons.person),
    //         // label: AppLocalizations.of(context)!.requests,
    //         label: AppLocalizations.of(context)!.muscat,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.settings),
    //         // label: AppLocalizations.of(context)!.services,
    //         label: AppLocalizations.of(context)!.vpn,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.settings),
    //         // label: AppLocalizations.of(context)!.services,
    //         label: 'Dashboard',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.settings),
    //         // label: AppLocalizations.of(context)!.services,
    //         label: 'Request',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.settings),
    //         // label: AppLocalizations.of(context)!.services,
    //         label: 'Service',
    //       ),
    //     ],
    //   ),
    // );
  }
}
