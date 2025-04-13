import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:veto/veto.dart';

import '/features/auth/services/auth_service.dart';
import '../../abstracts/router/app_route.dart';
import '../../services/logging_service.dart';

@injectable
class HomeViewModel extends BaseViewModel<void> with LoggingService {
  HomeViewModel({required AuthService authService}) : _authService = authService;

  @override
  void initialise() {
    super.initialise();
    logVmInit(vmName: 'Home');
  }

  final AuthService _authService;

  /// On press of the logout button
  Future<void> onLogoutPressed() async {
    await _authService.logout();
    context!.goNamed(AppRoute.onboarding.name);
  }

  @override
  void dispose() {
    super.dispose();
    logVmDispose(vmName: 'Home');
  }
}
