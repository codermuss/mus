import 'package:args/args.dart';

import 'base_command.dart';

class CommandRegistry {
  final Map<String, BaseCommand> _commands = {};
  final ArgParser _parser = ArgParser();

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
    print('Usage: mus.dart [options]');
    print(_parser.usage);
  }
}
