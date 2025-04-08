/// Page-routes in the app
enum AppRoute {
  /// First
  home(_RoutesInfo(routeAddress: '/')),

  /// Signup/Sign-in
  onboarding(_RoutesInfo(routeAddress: '/onboarding')),
  {{feature_1_name}}(_RoutesInfo(routeAddress: '/{{feature_1_name}}')),
  {{feature_2_name}}(_RoutesInfo(routeAddress: '/{{feature_2_name}}'));

  final _RoutesInfo _routeInfo;

  /// Address of the route
  String get routeAddress => _routeInfo.routeAddress;

  const AppRoute(this._routeInfo);
}

class _RoutesInfo {
  final String routeAddress;

  const _RoutesInfo({required this.routeAddress});
}
