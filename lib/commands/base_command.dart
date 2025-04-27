import 'dart:io';

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
    print('Command executing : $executable ${command.join(' ')}');
    final result = await Process.run(
      executable,
      command,
      runInShell: true,
    );

    if (result.exitCode != 0) {
      print('Command failed: $executable ${command.join(' ')}');
      print('Exit code: ${result.exitCode}');
      print('Output: ${result.stdout}');
      print('Error: ${result.stderr}');
      return false;
    }

    print('Command executed successfully: $executable ${command.join(' ')}');
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
