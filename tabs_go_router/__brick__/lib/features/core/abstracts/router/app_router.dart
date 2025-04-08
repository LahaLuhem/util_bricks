import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '/features/{{feature_1_name}}/views/{{feature_1_name}}_view.dart';
import '/features/{{feature_2_name}}/views/{{feature_2_name}}_view.dart';
import '../../views/home/home_view.dart';
import 'app_route.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

/// App's router
class AppRouter {
  /// Main router object to persist.
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoute.feature1.routeAddress,
    routes: [
      GoRoute(
        path: AppRoute.onboarding.routeAddress,
        name: AppRoute.onboarding.name,
        builder: (_, _) => throw UnimplementedError(),
      ),
      // Stateful nested navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) =>
                HomeView(homeViewArgs: HomeViewArgs(navigationShell: navigationShell)),
        branches: [
          // first branch (A)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: AppRoute.{{feature_1_name}}.routeAddress,
                pageBuilder: (context, state) => const NoTransitionPage(child: {{feature_1_name.pascalCase()}}View()),
              ),
            ],
          ),
          // second branch (B)
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              // top route inside branch
              GoRoute(
                path: AppRoute.{{feature_2_name}}.routeAddress,
                pageBuilder: (context, state) => const NoTransitionPage(child: {{feature_2_name.pascalCase()}}View()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
