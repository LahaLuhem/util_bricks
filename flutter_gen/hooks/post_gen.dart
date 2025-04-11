import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final depsProgress =
      context.logger.progress('Installing flutter_svg dependency');

  final depsResult = await Process.run('dart', ['pub', 'add', 'flutter_svg']);
  context.logger.info(depsResult.stdout);
  if ((depsResult.stderr as String).isNotEmpty) {
    context.logger.err(depsResult.stderr);
    depsProgress.fail('Failed to install slang and slang_flutter dependencies');
    return;
  }

  depsProgress.complete('Installed flutter_svg dependency');

  final buildRunnerProgress = context.logger.progress('Generating assets');
  final buildRunneResult = await Process.run(
      'dart', ['run', 'build_runner', 'build', '--delete-conflicting-outputs']);
  context.logger.info(buildRunneResult.stdout);
  if ((buildRunneResult.stderr as String).isNotEmpty) {
    context.logger.err(buildRunneResult.stderr);
    buildRunnerProgress.fail('Failed to run build_runner generate command');
    return;
  }

  buildRunnerProgress.complete('Generated assets');
}
