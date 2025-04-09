import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress =
      context.logger.progress('Running Slang to generate translation files');

  final result = await Process.run('dart', ['pub', 'run', 'slang']);
  if (result.stderr != null) {
    context.logger.err(result.stderr);
    progress.fail('Failed to generate translation files');
    return;
  }

  context.logger.info(result.stdout);
  progress.complete('Generated translation files');
}
