import 'package:flutter/widgets.dart';

import '/features/auth/services/auth_service.dart';
import '/features/core/abstracts/base_view_model.dart';
import '/locator.dart';
import '../../services/navigation/navigation_service.dart';

/// Home VM
class HomeViewModel extends BaseViewModel {
  /// Constructor
  HomeViewModel({
    required AuthService authService,
    required NavigationService navigationService,
  })  : _authService = authService,
        _navigationService = navigationService;

  @override
  Future<void> initialise(
    BuildContext disposableBuildContext,
    bool Function() mounted, [
    Object? arguments,
  ]) async {
    super.initialise(disposableBuildContext, mounted, arguments);
  }

  final AuthService _authService;
  final NavigationService _navigationService;

  /// On press of the logout button
  Future<void> onLogoutPressed(BuildContext context) async {
    await _authService.logout();
    _navigationService.home.popUntilLogin(context);
  }

  /// Locator DI
  static HomeViewModel get locate => Locator.locate();
}
