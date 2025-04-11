import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing flutter_svg dependency');

  final result = await Process.run('dart', ['pub', 'add', 'flutter_svg']);
  context.logger.info(result.stdout);
  if ((result.stderr as String).isNotEmpty) {
    context.logger.err(result.stderr);
    progress.fail('Failed to install slang and slang_flutter dependencies');
    return;
  }

  progress.complete('Installed flutter_svg dependency');
}
