import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:veto/veto.dart';

import '/features/auth/services/auth_service.dart';
import '/locator.dart';
import '../../services/logging_service.dart';
import '../../services/navigation/navigation_service.dart';
import 'home_view.dart' show HomeViewArgs;

/// Home VM
class HomeViewModel extends BaseViewModel<HomeViewArgs> with LoggingService {
  final AuthService _authService;
  final NavigationService _navigationService;

  HomeViewModel({
    required AuthService authService,
    required NavigationService navigationService,
  }) : _authService = authService,
       _navigationService = navigationService;

  final tabController = PlatformTabController();

  @override
  void initialise() {
    tabController.addListener(_withItemChanged);

    super.initialise();
    logVmInit(vmName: 'Home');
  }

  /// On press of the logout button
  Future<void> onLogoutPressed() async {
    await _authService.logout();
    _navigationService.home.popUntilLogin(context!);
  }

  void _withItemChanged() {
    final newIndex = tabController.index(context!);
    logNote('Navigating to branch-index: $newIndex}');
    arguments.navigationShell.goBranch(
      newIndex,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: newIndex == arguments.navigationShell.currentIndex,
    );
  }

  @override
  void dispose() {
    tabController
      ..removeListener(_withItemChanged)
      ..dispose();

    super.dispose();
    logVmDispose(vmName: 'Home');
  }

  static HomeViewModel get locate => Locator.locate();
}
