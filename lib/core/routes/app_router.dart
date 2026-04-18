import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nurturely/core/routes/routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class RouteManager {
  static final GoRouter mainRouter = _router;

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.splash.path,
    navigatorKey: rootNavigatorKey,
    routes: [
      // splashRoute,
    ],
  );
}

// final splashRoute = GoRoute(
//   path: Routes.splash.path,
//   builder: (context, state) => const SplashView(),
//   redirect: (context, state) async {
//     final isUserSignedIn = await UserDataFunctions().isUserSignedIn();
//     final hasOnboarded = await AppHiveData.instance.getData(key: HiveDataPathKey.hasOnboarded.name) as bool?;
//     if (hasOnboarded == false) return Routes.welcome.path;
//     if (isUserSignedIn) return Routes.home.path;
//     return Routes.auth.path;
//   },
// );

dynamic defaultTransition(
  pageKey, {
  required Widget child,
  TransitionType defaultIncoming = TransitionType.rightToLeft,
  TransitionType? outgoing,
}) {
  return PageAnimation.buildCustomTransitionPage(
    pageKey,
    type: TransitionType.paired(
      incoming: defaultIncoming,
      outgoing: outgoing ?? TransitionType.slide(begin: const Offset(0, 0), end: const Offset(-0.4, 0)),
      outgoingDuration: Durations.medium4,
      reverseDuration: Durations.medium2,
      curve: CustomCurves.defaultIosSpring,
      reverseCurve: CustomCurves.defaultIosSpring,
    ),
    duration: Durations.extralong2,
    reverseDuration: Durations.medium2,

    child: child,
  );
}
