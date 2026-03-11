// // import 'dart:developer';

// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
// // import '../modules/network_service.dart';
// // import '../modules/router/app_router.dart';
// // import '../modules/router/observer/print_route_observer.dart';
// // import '../utils/app_extensions/app_extension.dart';

// // class MyApp extends StatefulWidget {
// //   const MyApp({super.key});

// //   @override
// //   _MyAppState createState() => _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       NetworkService().startMonitoring();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     NetworkService().stopMonitoring();
// //     super.dispose();
// //   }

// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     super.didChangeAppLifecycleState(state);

// //     if (state == AppLifecycleState.resumed) {
// //       log('[AppState] App resumed');
// //     } else if (state == AppLifecycleState.paused ||
// //         state == AppLifecycleState.detached) {
// //       log('[AppState] App in background');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final appRouter = AppRouter();
// //     final currentTheme = KAppX.globalProvider.read(KAppX.theme.current);

// //     SystemChrome.setSystemUIOverlayStyle(
// //       SystemUiOverlayStyle(
// //         statusBarColor:
// //             currentTheme.themeBox.colors.primary, // Transparent status bar
// //         statusBarIconBrightness: Brightness.dark, // Icons in dark mode
// //         systemNavigationBarColor: Colors.white, // Navigation bar color
// //         systemNavigationBarIconBrightness:
// //             Brightness.dark, // Icons in dark mode
// //       ),
// //     );

// //     return Consumer(
// //       builder: (context, ref, child) {
// //         // final _ = ref.watch(appBooterProvider);
// //         final currentTheme = ref.watch(KAppX.theme.current);

// //         return GestureDetector(
// //           onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
// //           child: MaterialApp.router(
// //             debugShowCheckedModeBanner: false,
// //             title: 'Patient Portal',
// //             color: currentTheme.themeBox.colors.primary,
// //             theme: ThemeData(
// //               primaryColor: currentTheme.themeBox.colors.primary,
// //               useMaterial3: true,
// //               // brightness: currentTheme.type == KThemeType.dark
// //               //     ? Brightness.dark
// //               //     : Brightness.light,
// //               brightness: Brightness.light,
// //               iconTheme: Theme.of(context).iconTheme.copyWith(
// //                 color: currentTheme.themeBox.colors.secondary.shade60,
// //                 size: 24.toAutoScaledHeight,
// //               ),
// //               appBarTheme: Theme.of(context).appBarTheme.copyWith(
// //                 backgroundColor: currentTheme.themeBox.colors.primary,
// //                 iconTheme: Theme.of(context).iconTheme.copyWith(
// //                   color: currentTheme.themeBox.colors.secondary.shade60,
// //                   size: 24.toAutoScaledHeight,
// //                 ),
// //               ),
// //               // fontFamily: 'Circular Std',
// //               shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
// //               // textTheme: TextTheme(
// //               //   headline1: _buildTextStyle(),
// //               //   headline2: _buildTextStyle(),
// //               //   headline3: _buildTextStyle(),
// //               //   headline4: _buildTextStyle(),
// //               //   headline5: _buildTextStyle(),
// //               //   headline6: _buildTextStyle(),
// //               //   subtitle1: _buildTextStyle(),
// //               //   subtitle2: _buildTextStyle(),
// //               //   bodyText1: _buildTextStyle(),
// //               //   bodyText2: _buildTextStyle(),
// //               //   caption: _buildTextStyle(),
// //               //   button: _buildTextStyle(),
// //               //   overline: _buildTextStyle(),
// //               // ),
// //             ),
// //             routerConfig: appRouter.config(
// //               navigatorObservers: () => [PrintRouteObserver()],
// //             ),
// //             scrollBehavior: CupertinoScrollBehavior(),
// //             builder: (context, child) {
// //               // Can add wrapper over app here
// //               return child!;
// //             },
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   // TextStyle _buildTextStyle() {
// //   //   return TextStyle(
// //   //     fontFamily: 'Circular Std',
// //   //     letterSpacing: 0.2,
// //   //   );
// //   // }
// // }

// import 'package:code_setup/presentation/dashboard/models/announcementsModels.dart';
// import 'package:code_setup/presentation/dashboard/widgets/announcement/announcement.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:code_setup/presentation/common_widgets/header.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Announcements Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.deepOrange,
//         fontFamily: 'Cairo', // global font
//       ),
//       home: const AnnouncementScreen(),
//     );
//   }
// }

// class AnnouncementScreen extends ConsumerWidget {
//   const AnnouncementScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final announcements = [
//       AnnouncementModel(
//         imageUrl: 'https://picsum.photos/400/200?random=1',
//         title: 'Liamn volutpat',
//         subtitle:
//             'Proin volutpat, sapien ut facilisis ultricies, eros purus blandit velit...',
//         date: '12th Aug, 2023',
//       ),
//       AnnouncementModel(
//         imageUrl: 'https://picsum.photos/400/200?random=2',
//         title: 'New Update Released',
//         subtitle:
//             'We have launched new features for better performance and UI...',
//         date: '20th Aug, 2023',
//       ),
//       AnnouncementModel(
//         imageUrl: 'https://picsum.photos/400/200?random=3',
//         title: 'Maintenance Notice',
//         subtitle:
//             'Scheduled maintenance will take place on 25th Aug from 2 AM to 5 AM...',
//         date: '22nd Aug, 2023',
//       ),
//     ];
//     return KScaffold(
//       appBar: AppBar(
//         title: const Text('Announcements'),
//         backgroundColor: const Color(0xFF8D2814),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: AnnouncementWidget(
//               announcements: announcements,
//               title: 'Announcements',
//               subtitle: 'Stay updated with the latest news',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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

  // final List<Widget> _screens = [
  //   AnnouncementScreen(),
  //   ApprovalsList(),
  //   Services(),
  // ];

  // final List<Widget> _screens = [
  //   SalalahDashboard(),
  //   MuscatDashboard(),
  //   VpnDashboard(),
  //   AnnouncementScreen(),
  //   ApprovalsList(),
  //   ServicesRoute(),
  // ];

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
