part of 'navigation_service.dart';

/// Use for programmatically changing navigation tabs.
class _HomeRouter extends Navigation {
  void popUntilLogin(BuildContext context) => context.goNamed(AppRoute.onboarding.name);
}
