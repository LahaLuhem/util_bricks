import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:veto/veto.dart';

import 'home_view_model.dart';

/// Home view with the tabs
class HomeView extends StatelessWidget {
  final HomeViewArgs homeViewArgs;

  const HomeView({required this.homeViewArgs, super.key});

  @override
  Widget build(BuildContext context) => ViewModelBuilder(
    viewModelBuilder: () => HomeViewModel.locate,
    argumentBuilder: () => homeViewArgs,
    builder:
        (context, model, isInitialised, _) => PlatformTabScaffold(
          tabController: model.tabController,
          bodyBuilder: (_, _) => homeViewArgs.navigationShell,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.adb)),
            BottomNavigationBarItem(icon: Icon(Icons.accessibility)),
          ],
        ),
  );
}

final class HomeViewArgs {
  final StatefulNavigationShell navigationShell;

  const HomeViewArgs({required this.navigationShell});
}
