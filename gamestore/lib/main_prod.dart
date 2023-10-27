import 'app.dart';
import 'features/core/data/enums/environment_type.dart';

Future<void> main() async {
  EnvironmentType.dev.override();
  await mainRoot();
}
