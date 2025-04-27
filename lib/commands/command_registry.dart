import 'package:ansicolor/ansicolor.dart';
import 'package:args/args.dart';

import '../config/version.dart';
import 'base_command.dart';

class CommandRegistry {
  final Map<String, BaseCommand> _commands = {};
  final ArgParser _parser = ArgParser()
    ..addFlag('help',
        abbr: 'h', help: 'Show this help message', negatable: false)
    ..addFlag('version',
        abbr: 'v', help: 'Show version information', negatable: false);

  void registerCommand(BaseCommand command) {
    _commands[command.name] = command;
    _parser.addFlag(
      command.name,
      abbr: command.shortFlag,
      help: command.description,
    );
  }

  ArgParser get parser => _parser;

  BaseCommand? getCommand(String name) => _commands[name];

  void printUsage() {
    final title = AnsiPen()..blue(bold: true);
    final subtitle = AnsiPen()..cyan();
    final command = AnsiPen()..green();
    final option = AnsiPen()..yellow();
    final description = AnsiPen()..white();
    final version = AnsiPen()..magenta();
    final build = AnsiPen()..cyan();
    final border = AnsiPen()..blue();

    // Title box
    print(title(
        '╔════════════════════════════════════════════════════════════════════════════╗'));
    print(title(
        '║                          Mus - Flutter Build CLI Tool                      ║'));
    print(title(
        '╚════════════════════════════════════════════════════════════════════════════╝'));

    // Version info
    print(
        '\n${version('Version:')} ${version(Version.version)} ${build('(Build ${Version.buildNumber})')}');

    // Usage section
    print('\n${subtitle('Usage:')}');
    print('  ${command('mus')} <command> [options]');

    // Commands table
    print('\n${subtitle('Available Commands:')}');
    print(border(
        '┌────────────┬────────────┬────────────────────────────────────────────┐'));
    print(border(
        '│ Command    │ Short Flag │ Description                                │'));
    print(border(
        '├────────────┼────────────┼────────────────────────────────────────────┤'));
    _commands.forEach((name, cmd) {
      final paddedName = name.padRight(10);
      final paddedFlag = '-${cmd.shortFlag}'.padRight(10);
      final paddedDesc = cmd.description.padRight(52);
      print(border(
          '│ ${command(paddedName)} │ ${option(paddedFlag)} │ ${description(paddedDesc)} │'));
    });
    print(border(
        '└────────────┴────────────┴────────────────────────────────────────────┘'));

    // Global options table
    print('\n${subtitle('Global Options:')}');
    print(border(
        '┌────────────┬────────────────────────────────────────────────────────┐'));
    print(border(
        '│ Option     │ Description                                            │'));
    print(border(
        '├────────────┼────────────────────────────────────────────────────────┤'));
    for (var entry in _parser.options.entries) {
      final paddedName = '--${entry.key}'.padRight(10);
      final paddedDesc = (entry.value.help ?? '').padRight(52);
      print(border('│ ${option(paddedName)} │ ${description(paddedDesc)} │'));
    }
    print(border(
        '└────────────┴────────────────────────────────────────────────────────┘'));

    // Examples section
    print('\n${subtitle('Examples:')}');
    print('  ${command('mus')} ${option('apk')}     # Build Android APK');
    print('  ${command('mus')} ${option('ipa')}     # Build iOS IPA');
    print('  ${command('mus')} ${option('web')}     # Build Web');
  }

  void printVersion() {
    final version = AnsiPen()..magenta();
    final build = AnsiPen()..cyan();

    print(version('Mus CLI v${Version.version}'));
    print(build('Build: ${Version.buildNumber}'));
  }
}
