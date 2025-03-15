import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted/models/model.dart';
import 'package:wanted/navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appStateManager = AppStateManager();
  await appStateManager.initializeApp();

  // Démarrer l'application
  runApp(WantedApp(appStateManager: appStateManager));
}

class WantedApp extends StatefulWidget {
  final AppStateManager appStateManager;

  const WantedApp({super.key, required this.appStateManager});

  @override
  State<WantedApp> createState() => _WantedAppState();
}

class _WantedAppState extends State<WantedApp> {
  late WantedProvider _wantedProvider;
  late EventManager _eventManager;
  late EventLiveProvider _eventLiveProvider;
  late MemorialProvider _memorialProvider;
  late ProfileManager _profileManager;
  late ActivityProvider _activityProvider;
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    
    // ✅ Initialisation des providers
    _wantedProvider = WantedProvider();
    _eventManager = EventManager();
    _eventLiveProvider = EventLiveProvider();
    _memorialProvider = MemorialProvider();
    _profileManager = ProfileManager();
    _activityProvider = ActivityProvider();

    // ✅ Passage correct des instances à AppRouter
    _appRouter = AppRouter(
      appStateManager: widget.appStateManager,
      profileManager: _profileManager,
      eventManager: _eventManager,
      wantedProvider: _wantedProvider,
      eventLiveProvider: _eventLiveProvider,
      memorialProvider: _memorialProvider,
      activityProvider: _activityProvider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => widget.appStateManager),
        ChangeNotifierProvider(create: (context) => _wantedProvider),
        ChangeNotifierProvider(create: (context) => _eventManager),
        ChangeNotifierProvider(create: (context) => _eventLiveProvider),
        ChangeNotifierProvider(create: (context) => _memorialProvider),
        ChangeNotifierProvider(create: (context) => _profileManager),
        ChangeNotifierProvider(create: (context) => _activityProvider),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          final router = _appRouter.router;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Wanted',
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wanted/models/model.dart';
// import 'package:wanted/navigation/app_router.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final appStateManager = AppStateManager();
//   await appStateManager.initializeApp();
//   // Starting point of the application
//   runApp(WantedApp(appStateManager: appStateManager));
// }

// class WantedApp extends StatefulWidget {
//   final AppStateManager appStateManager;

//   const WantedApp({super.key, required this.appStateManager});

//   @override
//   State<WantedApp> createState() => _WantedAppState();
// }

// class _WantedAppState extends State<WantedApp> {
//   late final WantedProvider _wantedProvider;
//   late final EventManager _eventManager;
//   late final EventLiveProvider _eventLiveProvider;
//   late final MemorialProvider _memorialProvider;
//   late final ProfileManager _profileManager;
//   late final ActivityProvider _activityProvider;
//   late final AppRouter _appRouter = AppRouter(
//       appStateManager: widget.appStateManager,
//       profileManager: ProfileManager(),
//       //settingsManager: SettingsManager(),
//       eventManager: _eventManager,
//       wantedProvider: _wantedProvider,
//       eventLiveProvider: _eventLiveProvider,
//       memorialProvider: _memorialProvider,
//       activityProvider: _activityProvider,
//     );

//   // @override
//   // void initState() {
//   //   super.initState();
   
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => widget.appStateManager),
//         ChangeNotifierProvider(create: (context) => _wantedProvider),
//         ChangeNotifierProvider(create: (context) => _eventManager),
//         ChangeNotifierProvider(create: (context) => _eventLiveProvider),
//         ChangeNotifierProvider(create: (context) => _memorialProvider),
//         ChangeNotifierProvider(create: (context) => _profileManager),
//         ChangeNotifierProvider(create: (context) => _activityProvider),
//       ],
//       child: Consumer<ProfileManager>(
//         builder: (context, profileManager, child) {
//           final router = _appRouter.router;
//           return MaterialApp.router(
//             debugShowCheckedModeBanner: false,
//             title: 'Wanted',
//             routerDelegate: router.routerDelegate,
//             routeInformationParser: router.routeInformationParser,
//             routeInformationProvider: router.routeInformationProvider,
//           );
//         },
//       ),
//     );
//   }
// }