import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:veto/veto.dart';

import '/features/core/widgets/core_widgets.dart';
import '/locator.dart';
import 'home_view_model.dart';

/// Home view with the tabs
class HomeView extends StatelessWidget {
  /// Constructor
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => ViewModelBuilder(
    viewModelBuilder: () => Locator.locate<HomeViewModel>(),
    builder:
        (context, model, isInitialised, _) => PlatformScaffold(
          appBar: GsAppBar(),
          body: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Center(child: Text('You have pushed the button this many times:'))],
          ),
        ),
  );
}
