import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress =
      context.logger.progress('Running Slang to generate translation files');

  final result = await Process.run('dart', ['pub', 'run', 'slang']);
  context.logger.info(result.stdout);
  if ((result.stderr as String).isNotEmpty) {
    context.logger.err(result.stderr);
    progress.fail('Failed to generate translation files');
    return;
  }

  progress.complete('Generated translation files');
}
