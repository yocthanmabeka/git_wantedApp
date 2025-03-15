import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wanted/screens/screens.dart';
import 'package:wanted/models/model.dart';
import 'package:wanted/component/component.dart';

class AppRouter {
  final AppStateManager appStateManager;
  final ProfileManager profileManager;
  final EventManager eventManager;
  final WantedProvider wantedProvider;
  final EventLiveProvider eventLiveProvider;
  final MemorialProvider memorialProvider;
  final ActivityProvider activityProvider;

  AppRouter({
    required this.appStateManager,
    required this.profileManager,
    required this.eventManager,
    required this.wantedProvider,
    required this.eventLiveProvider,
    required this.memorialProvider,
    required this.activityProvider,
  });

  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: appStateManager,
    initialLocation: '/auth',
    routes: [
      GoRoute(
        name: 'auth',
        path: '/auth',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: 'signin',
        path: '/signin',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        name: 'onboarding',
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => WantedView(),
        routes: [
          GoRoute(
            name: 'tabs',
            path: 'tabs',
            builder: (context, state) => WantedTab(
              onNavigateToLive: () => GoRouter.of(context).go('/home/live'),
              onOpenDrawer: () => GoRouter.of(context).go('/home/menu'),
            ),
            routes: [
              GoRoute(
                name: 'event',
                path: 'event/:id',
                builder: (context, state) {
                  final eventId = state.pathParameters['id'];
                  final event = eventId != null ? eventManager.getEventById(eventId) : null;
                  return EventsScreen(
                    // event: event ?? EventModel.defaultEvent()
                  );
                },
              ),
              GoRoute(
                name: 'memorial',
                path: 'memorial/:id',
                builder: (context, state) {
                  final memorialId = state.pathParameters['id'];
                  final memorial = memorialId != null ? memorialProvider.getMemorialById(memorialId) : null;
                  return MemorialScreen(
                    // memorial: memorial
                  );
                },
              ),
              GoRoute(
                name: 'activity',
                path: 'activity',
                builder: (context, state) => const ActivityScreen(),
              ),
            ],
          ),
          GoRoute(
            name: 'homeLive',
            path: '/home/live',
            builder: (context, state) => LiveScreen(
              closePage: () => GoRouter.of(context).go('/home'),
            ),
          ),
          GoRoute(
            name: 'menu',
            path: 'menu',
            builder: (context, state) => NavigationEndDrawer(
              closePage: () => GoRouter.of(context).go('/home'),
            ),
          ),
        ],
      ),
      GoRoute(
        name: 'eventLive',
        path: '/live/:id',
        builder: (context, state) {
          final liveId = state.pathParameters['id'];
          final live = liveId != null ? eventLiveProvider.getLiveById(liveId) : null;

          if (live == null) {
            return const Scaffold(
              body: Center(child: Text("Live introuvable")),
            );
          }

          final event = eventManager.getEventById(live.eventId);
          final creator = profileManager.getUserById(live.hostId);

          return EventLive(
            closePage: () => GoRouter.of(context).go('/home'),
            event: event ?? EventModel.defaultEvent(),
            creator: creator ?? UserModel.defaultUser(),
            liveData: live,
          );
        },
      ),
      GoRoute(
        name: 'profile',
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        name: 'settings',
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: 'logout',
        path: '/logout',
        builder: (context, state) {
          appStateManager.logoutUser();
          return const SignInScreen();
        },
      ),
    ],
    redirect: (context, state) {
      final loggedIn = appStateManager.isLoggedIn;
      final loggingIn = state.matchedLocation == '/auth';

      if (!loggedIn) return loggingIn ? null : '/auth';

      final isOnboardingComplete = appStateManager.isOnboardingComplete;
      final onboarding = state.matchedLocation == '/onboarding';
      if (!isOnboardingComplete) {
        return onboarding ? null : '/onboarding';
      }

      if (loggingIn || onboarding) {
    Container(
      padding: const EdgeInsets.all(5),
      child: const Text('hello'),
    );
      }
      //return '/home';
      return null;
    },
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
    },
  );
}


// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:wanted/screens/screens.dart';
// import 'package:wanted/models/model.dart';
// import 'package:wanted/component/component.dart';

// class AppRouter {
//   final AppStateManager appStateManager;
//   final ProfileManager profileManager;
//   //final SettingsManager settingsManager;
//   final EventManager eventManager;
//   final WantedProvider wantedProvider;
//   final EventLiveProvider eventLiveProvider;
//   final MemorialProvider memorialProvider;
//   final ActivityProvider activityProvider;

//   AppRouter({
//     required this.appStateManager,
//     required this.profileManager,
//     //required this.settingsManager,
//     required this.eventManager,
//     required this.wantedProvider,
//     required this.eventLiveProvider,
//     required this.memorialProvider,
//     required this.activityProvider,
//   });

//   late final GoRouter router = GoRouter(
//     debugLogDiagnostics: true,
//     refreshListenable: appStateManager,
//     initialLocation: '/auth',
//     routes: [
//       // GoRoute(
//       //   path: '/',
//       //   builder: (context, state) => const SplashScreen(),
//       // ),
//       GoRoute(
//         name: 'auth',
//         path: '/auth',
//         builder: (context, state) => const SignUpScreen(),
//       ),
//       GoRoute(
//         name: 'signin',
//         path: '/signin',
//         builder: (context, state) => const SignInScreen(),
//       ),
//       GoRoute(
//         name: 'onboarding',
//         path: '/onboarding',
//         builder: (context, state) => const OnboardingScreen(),
//       ),
//       GoRoute(
//         name: 'home',
//         path: '/home',
//         builder: (context, state) => WantedView(),
//         routes: [
//           GoRoute(
//             path: 'tabs',
//             builder: (context, state) => WantedTab(
//               onNavigateToLive: () => GoRouter.of(context).go('/home/live'),
//               onOpenDrawer: () => GoRouter.of(context).go('/home/menu'),
//             ),
//             routes: [
//               // GoRoute(
//               //   path: 'event/:id',
//               //   builder: (context, state) {
//               //     final eventId = state.pathParameters['id'];
//               //     final event = eventId != null ? eventManager.getEventById(eventId) : null;
//               //     return EventsScreen(
//               //       // event: event ?? EventModel.defaultEvent()
//               //     );
//               //   },
//               // ),
//               // GoRoute(
//               //   name: 'memorial',
//               //   path: 'memorial/:id',
//               //   builder: (context, state) {
//               //     final memorialId = state.pathParameters['id'];
//               //     final memorial = memorialId != null ? memorialProvider.getMemorialById(memorialId) : null;
//               //     return MemorialScreen(
//               //       // memorial: memorial
//               //     );
//               //   },
//               // ),
//               // GoRoute(
//               //   name: 'activity',
//               //   path: 'activity',
//               //   builder: (context, state) => const ActivityScreen(),
//               // ),
//             ],
//           ),
//           GoRoute(
//             name: 'live',
//             path: 'live',
//             builder: (context, state) => LiveScreen(
//               closePage: () => GoRouter.of(context).go('/home'),
//             ),
//           ),
//           GoRoute(
//             name: 'menu',
//             path: 'menu',
//             builder: (context, state) => NavigationEndDrawer(
//               closePage: () => GoRouter.of(context).go('/home'),
//             ),
//           ),
//         ],
//       ),
//       GoRoute(
//         name: 'live',
//         path: '/live/:id',
//         builder: (context, state) {
//           final liveId = state.pathParameters['id'];
//           final live = liveId != null ? eventLiveProvider.getLiveById(liveId) : null;
//           final event = eventManager.getEventById(live?.eventId);
//           final creator = profileManager.getUserById(live!.hostId);
//           return EventLive(
//             closePage: () => GoRouter.of(context).go('/home'),
//             event: event ?? EventModel.defaultEvent(),
//             creator: creator ?? UserModel.defaultUser(),
//             liveData: live,
//           );
//         },
//       ),
//       GoRoute(
//         name: 'profile',
//         path: '/profile',
//         builder: (context, state) => const ProfileScreen(),
//       ),
//       GoRoute(
//         name: 'settings',
//         path: '/settings',
//         builder: (context, state) => const SettingsScreen(),
//       ),
//       GoRoute(
//         name: 'logout',
//         path: '/logout',
//         builder: (context, state) {
//           appStateManager.logoutUser();
//           return const SignInScreen();
//         },
//       ),
//     ],
//     redirect: (context, state) {
//       final loggedIn = appStateManager.isLoggedIn;
//       final loggingIn = state.matchedLocation == '/auth';
//       if (!loggedIn) return loggingIn ? null : '/auth';

//       final isOnboardingComplete = appStateManager.isOnboardingComplete;
//       final onboarding = state.matchedLocation =='/onboarding';
//       if (!isOnboardingComplete) {
//         return onboarding ? null : '/onboarding';
//       }

//       if (loggingIn || onboarding) return '/home';
//       return null;
//     },
//     errorPageBuilder: (context, state) {
//       return MaterialPage(
//         key: state.pageKey,
//         child: Scaffold(
//           body: Center(
//             child: Text(
//               state.error.toString(),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
