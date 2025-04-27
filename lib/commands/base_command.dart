import 'dart:io';

import 'package:ansicolor/ansicolor.dart';

abstract class BaseCommand {
  final String name;
  final String description;
  final String shortFlag;

  BaseCommand({
    required this.name,
    required this.description,
    required this.shortFlag,
  });

  Future<void> execute();

  Future<bool> runCommand(String executable, List<String> command) async {
    final commandPen = AnsiPen()..cyan();
    final successPen = AnsiPen()..green();
    final errorPen = AnsiPen()..red();
    final infoPen = AnsiPen()..yellow();

    print(
        '\n${commandPen('🚀 Executing:')} ${commandPen('$executable ${command.join(' ')}')}');
    final result = await Process.run(
      executable,
      command,
      runInShell: true,
    );

    if (result.exitCode != 0) {
      print(
          '${errorPen('❌ Failed:')} ${errorPen('$executable ${command.join(' ')}')}');
      print(
          '${infoPen('📊 Exit code:')} ${errorPen(result.exitCode.toString())}');
      if (result.stdout.toString().isNotEmpty) {
        print('${infoPen('📝 Output:')}\n${result.stdout}');
      }
      if (result.stderr.toString().isNotEmpty) {
        print('${infoPen('⚠️ Error:')}\n${errorPen(result.stderr)}');
      }
      return false;
    }

    print(
        '${successPen('✅ Success:')} ${successPen('$executable ${command.join(' ')}')}');
    if (result.stdout.toString().isNotEmpty) {
      print('${infoPen('📝 Output:')}\n${result.stdout}');
    }
    return true;
  }
}

class CommandException implements Exception {
  final String message;
  final int exitCode;
  final String stdout;
  final String stderr;

  CommandException(this.message, this.exitCode, this.stdout, this.stderr);

  @override
  String toString() =>
      '$message\nExit code: $exitCode\nOutput:\n$stdout\nError:\n$stderr';
}
