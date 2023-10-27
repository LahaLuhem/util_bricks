import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gamestore/features/core/widgets/gs_app_bar.dart';

import '../../widgets/state/view_model_builder.dart';
import 'home_view_model.dart';

/// Home view with the tabs
class HomeView extends StatelessWidget {
  /// Constructor
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>(
      disposableBuildContext: context,
      viewModelBuilder: () => HomeViewModel.locate,
      builder: (context, model) => PlatformScaffold(
        appBar: GsAppBar(),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'You have pushed the button this many times:',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
