import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger
      .progress('Installing slang and slang_flutter dependencies');

  final result =
      await Process.run('dart', ['pub', 'add', 'slang', 'slang_flutter']);
  if (result.stderr != null) {
    context.logger.err(result.stderr);
    progress.fail('Failed to install slang and slang_flutter dependencies');
    return;
  }

  context.logger.info(result.stdout);
  progress.complete('Installed slang and slang_flutter dependencies');
}
