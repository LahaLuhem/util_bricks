import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locator.config.dart';

@InjectableInit(initializerName: 'init', preferRelativeImports: true, asExtension: true)
Future<void> configureDependencies() async => GetIt.instance.init();

abstract class Locator {
  static T locate<T extends Object>() => GetIt.instance.get<T>();
}
