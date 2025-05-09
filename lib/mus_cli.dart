import 'package:mus/commands/build/apk_command.dart';
import 'package:mus/commands/build/appbundle_command.dart';
import 'package:mus/commands/build/ipa_command.dart';
import 'package:mus/commands/build/web_command.dart';
import 'package:mus/commands/clean_command.dart';
import 'package:mus/commands/fix_pods_command.dart';

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
      ..registerCommand(BuildWebCommand())
      ..registerCommand(CleanCommand())
      ..registerCommand(FixPodsCommand());
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
