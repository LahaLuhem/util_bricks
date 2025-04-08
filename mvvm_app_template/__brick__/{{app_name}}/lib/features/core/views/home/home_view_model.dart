import 'package:veto/veto.dart';

import '/features/auth/services/auth_service.dart';
import '/locator.dart';
import '../../services/logging_service.dart';
import '../../services/navigation/navigation_service.dart';

/// Home VM
class HomeViewModel extends BaseViewModel<void> with LoggingService {
  /// Constructor
  HomeViewModel({required AuthService authService, required NavigationService navigationService})
    : _authService = authService,
      _navigationService = navigationService;

  @override
  void initialise() {
    super.initialise();
    logVmInit(vmName: 'Home');
  }

  final AuthService _authService;
  final NavigationService _navigationService;

  /// On press of the logout button
  Future<void> onLogoutPressed() async {
    await _authService.logout();
    _navigationService.home.popUntilLogin(context!);
  }

  @override
  void dispose() {
    super.dispose();
    logVmDispose(vmName: 'Home');
  }

  static HomeViewModel get locate => Locator.locate();
}
