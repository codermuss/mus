import 'package:args/args.dart';

import 'base_command.dart';

class CommandRegistry {
  final Map<String, BaseCommand> _commands = {};
  final ArgParser _parser = ArgParser()
    ..addFlag('help',
        abbr: 'h', help: 'Show this help message', negatable: false);

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
    print('Mus - Flutter Build CLI Tool');
    print('\nUsage: mus <command> [options]');
    print('\nAvailable commands:');
    _commands.forEach((name, command) {
      print('  ${command.shortFlag}, --$name\t${command.description}');
    });
    print('\nOptions:');
    print(_parser.usage);
  }
}
