part of 'navigation_service.dart';

/// Use for programmatically changing navigation tabs.
class _HomeRouter extends GsNavigation {
  static const _tabs = <AppRoute>[];

  void popUntilLogin(BuildContext context) => context.goNamed(AppRoute.onboarding.name);

  static AppRoute get lastActiveRoute => _tabs[0];
}
