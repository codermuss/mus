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

  String _createTableRow(
      String label, String value, AnsiPen labelPen, AnsiPen valuePen) {
    final maxWidth = 80;
    final labelWidth = 15;
    final valueWidth = maxWidth - labelWidth - 4; // 4 for padding and borders

    final formattedLabel = label.padRight(labelWidth);
    final formattedValue = value.length > valueWidth
        ? '${value.substring(0, valueWidth - 3)}...'
        : value.padRight(valueWidth);

    return '│ ${labelPen(formattedLabel)} │ ${valuePen(formattedValue)} │';
  }

  Future<bool> runCommand(String executable, List<String> command) async {
    final commandPen = AnsiPen()..cyan();
    final successPen = AnsiPen()..green();
    final errorPen = AnsiPen()..red();
    final infoPen = AnsiPen()..yellow();
    final borderPen = AnsiPen()..blue();

    final commandStr = '$executable ${command.join(' ')}';
    final maxWidth = 80;
    final horizontalBorder = '─'.padRight(maxWidth, '─');

    print('\n${borderPen('┌$horizontalBorder┐')}');
    print(_createTableRow('🚀 Command', commandStr, commandPen, commandPen));
    print(borderPen('├$horizontalBorder┤'));

    final result = await Process.run(
      executable,
      command,
      runInShell: true,
    );

    if (result.exitCode != 0) {
      print(_createTableRow('❌ Status', 'Failed', errorPen, errorPen));
      print(_createTableRow(
          '📊 Exit Code', result.exitCode.toString(), infoPen, errorPen));

      if (result.stdout.toString().isNotEmpty) {
        print(_createTableRow(
            '📝 Output', result.stdout.toString().trim(), infoPen, infoPen));
      }
      if (result.stderr.toString().isNotEmpty) {
        print(_createTableRow(
            '⚠️ Error', result.stderr.toString().trim(), infoPen, errorPen));
      }
    } else {
      print(_createTableRow('✅ Status', 'Success', successPen, successPen));
      if (result.stdout.toString().isNotEmpty) {
        print(_createTableRow(
            '📝 Output', result.stdout.toString().trim(), infoPen, infoPen));
      }
    }

    print('${borderPen('└$horizontalBorder┘')}\n');
    return result.exitCode == 0;
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
