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

  // Terminal output utilities
  static final _commandPen = AnsiPen()..cyan();
  static final _successPen = AnsiPen()..green();
  static final _errorPen = AnsiPen()..red();
  static final _infoPen = AnsiPen()..yellow();
  static final _borderPen = AnsiPen()..blue();

  static const _maxWidth = 80;
  static const _labelWidth = 15;
  static const _valueWidth =
      _maxWidth - _labelWidth - 4; // 4 for padding and borders

  List<String> _wrapText(String text, int width) {
    if (text.length <= width) return [text];

    final words = text.split(' ');
    final lines = <String>[];
    var currentLine = '';

    for (var word in words) {
      if (('$currentLine $word').length <= width) {
        currentLine += (currentLine.isEmpty ? '' : ' ') + word;
      } else {
        if (currentLine.isNotEmpty) lines.add(currentLine);
        currentLine = word;
      }
    }
    if (currentLine.isNotEmpty) lines.add(currentLine);

    return lines;
  }

  String _createTableRow(
      String label, String value, AnsiPen labelPen, AnsiPen valuePen) {
    final formattedLabel = label.padRight(_labelWidth);
    final wrappedValue = _wrapText(value, _valueWidth);

    final rows = <String>[];
    for (var i = 0; i < wrappedValue.length; i++) {
      final value = wrappedValue[i].padRight(_valueWidth);
      if (i == 0) {
        rows.add('│ ${labelPen(formattedLabel)} │ ${valuePen(value)} │');
      } else {
        rows.add('│ ${' '.padRight(_labelWidth)} │ ${valuePen(value)} │');
      }
    }

    return rows.join('\n');
  }

  Future<bool> runCommand(String executable, List<String> command) async {
    final commandStr = '$executable ${command.join(' ')}';
    final horizontalBorder = '─'.padRight(_maxWidth, '─');

    print('\n${_borderPen('┌$horizontalBorder┐')}');
    print(_createTableRow('🚀 Command', commandStr, _commandPen, _commandPen));
    print(_borderPen('├$horizontalBorder┤'));

    final result = await Process.run(
      executable,
      command,
      runInShell: true,
    );

    if (result.exitCode != 0) {
      print(_createTableRow('❌ Status', 'Failed', _errorPen, _errorPen));
      print(_createTableRow(
          '📊 Exit Code', result.exitCode.toString(), _infoPen, _errorPen));

      if (result.stdout.toString().isNotEmpty) {
        print(_createTableRow(
            '📝 Output', result.stdout.toString().trim(), _infoPen, _infoPen));
      }
      if (result.stderr.toString().isNotEmpty) {
        print(_createTableRow(
            '⚠️ Error', result.stderr.toString().trim(), _infoPen, _errorPen));
      }
    } else {
      print(_createTableRow('✅ Status', 'Success', _successPen, _successPen));
      if (result.stdout.toString().isNotEmpty) {
        print(_createTableRow(
            '📝 Output', result.stdout.toString().trim(), _infoPen, _infoPen));
      }
    }

    print('${_borderPen('└$horizontalBorder┘')}\n');
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
