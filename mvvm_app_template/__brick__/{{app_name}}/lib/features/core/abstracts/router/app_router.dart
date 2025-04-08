import 'package:go_router/go_router.dart';

import '../../views/home/home_view.dart';
import 'app_route.dart';

// TODO(mehul): Use Shell navigation later
// final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// App's router
class AppRouter {
  /// Main router object to persist.
  static final router = GoRouter(
    initialLocation: AppRoute.home.routeAddress,
    routes: [
      GoRoute(
        path: AppRoute.onboarding.routeAddress,
        name: AppRoute.onboarding.name,
        builder: (_, _) => throw UnimplementedError(),
      ),
      GoRoute(
        path: AppRoute.home.routeAddress,
        name: AppRoute.home.name,
        builder: (_, _) => const HomeView(),
      ),
    ],
  );
}
