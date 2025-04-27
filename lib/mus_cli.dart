import 'commands/build_commands.dart';
import 'commands/command_registry.dart';

class MusCli {
  final CommandRegistry _registry;

  MusCli() : _registry = CommandRegistry() {
    _registerCommands();
  }

  void _registerCommands() {
    _registry
      ..registerCommand(BuildApkCommand())
      ..registerCommand(BuildAppBundleCommand())
      ..registerCommand(BuildIpaCommand())
      ..registerCommand(BuildWebCommand());
  }

  Future<void> run(List<String> arguments) async {
    if (arguments.isEmpty ||
        arguments.contains('-h') ||
        arguments.contains('--help')) {
      _registry.printUsage();
      return;
    }

    if (arguments.contains('-v') || arguments.contains('--version')) {
      _registry.printVersion();
      return;
    }

    try {
      final args = _registry.parser.parse(arguments);

      if (args['help']) {
        _registry.printUsage();
        return;
      }

      if (args['version']) {
        _registry.printVersion();
        return;
      }

      final commandName = args.options.first;
      final command = _registry.getCommand(commandName);

      if (command == null) {
        print('Unknown command: $commandName');
        _registry.printUsage();
        return;
      }

      await command.execute();
    } catch (e) {
      print('Error: $e');
      _registry.printUsage();
    }
  }
}
