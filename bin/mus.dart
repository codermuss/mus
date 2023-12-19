import 'dart:io';

import 'package:args/args.dart';
import 'package:mus/mus.dart';

void main(List<String> arguments) {
  final ArgParser argParser = ArgParser()
    ..addFlag(AppCommands.clean,
        abbr: ShortHands.clean, help: HelpDescriptions.clean)
    ..addFlag(AppCommands.fixPods,
        abbr: ShortHands.fixPods, help: HelpDescriptions.fixPods)
    ..addFlag(AppCommands.ipa,
        abbr: ShortHands.buildIpa, help: HelpDescriptions.buildIpa)
    ..addFlag(AppCommands.appBundle,
        abbr: ShortHands.appBundle, help: HelpDescriptions.appBundle)
    ..addFlag(AppCommands.web, abbr: ShortHands.web, help: HelpDescriptions.web)
    ..addFlag(AppCommands.apk,
        abbr: ShortHands.releaseApk, help: HelpDescriptions.releaseApk);
  if (arguments.isEmpty) {
    printUsage(argParser);
    return;
  }
  try {
    final ArgResults args = argParser.parse(arguments);
    for (var element in arguments) {
      print(element);
    }
    switch (args.options.first) {
      case AppCommands.clean:
        clean();
        break;
      case AppCommands.apk:
        buildApk();
        break;
      case AppCommands.ipa:
        buildIpa();
        break;
      case AppCommands.fixPods:
        fixPods();
        break;
      case AppCommands.web:
        buildWeb();
        break;
      case AppCommands.appBundle:
        buildAppBundle();
        break;

      default:
    }
  } catch (e) {
    print('Error: $e');
    printUsage(argParser);
  }
}

void buildApk() {
  clean();
  runCommand(AppConstants.flutter, [
    AppConstants.build,
    AppConstants.apk,
    AppConstants.release,
    AppConstants.obfuscate,
    AppConstants.splitDebugInfo,
    AppConstants.spilitPerAbi,
    AppConstants.noShrink
  ]);
}

void buildAppBundle() {
  clean();
  runCommand(AppConstants.flutter, [
    AppConstants.build,
    AppConstants.appBundle,
    AppConstants.release,
    AppConstants.obfuscate,
    AppConstants.splitDebugInfo,
    AppConstants.noShrink
  ]);
}

void buildIpa() {
  fixPods();
  runCommand(AppConstants.flutter, [
    AppConstants.build,
    AppCommands.ipa,
    AppConstants.obfuscate,
    AppConstants.splitDebugInfo
  ]);
}

void buildWeb() {
  clean();
  runCommand(AppConstants.flutter, [
    AppConstants.build,
    AppConstants.web,
    AppConstants.release,
  ]);
}

void clean() {
  /// MARK:  Remove build folder
  runCommand(AppConstants.rm, [AppConstants.r, AppConstants.build]);

  /// MARK: Remove pubspec lock
  runCommand(AppConstants.rm, [AppConstants.r, AppConstants.pubspecLock]);

  /// MARK: Run flutter clean
  runCommand(AppConstants.flutter, [AppCommands.clean]);

  /// MARK: Run flutter pub get
  runCommand(AppConstants.flutter, [AppConstants.pub, AppConstants.getWord]);
}

void fixPods() {
  runCommand(AppConstants.rm, [AppConstants.r, AppConstants.iosPods]);
  runCommand(AppConstants.rm, [AppConstants.r, AppConstants.iosPodfileLock]);
  runCommand(AppConstants.rm, [AppConstants.r, AppConstants.symLinks]);
  clean();
  runCommand(AppConstants.cd, [AppConstants.ios]);
  runCommand(AppConstants.sudo, [
    AppConstants.arch,
    AppConstants.x8664,
    AppConstants.gem,
    AppConstants.install,
    AppConstants.ffi
  ]);
  runCommand(AppConstants.arch, [
    AppConstants.x8664,
    AppConstants.pod,
    AppConstants.install,
    AppConstants.repoUpdate
  ]);
  runCommand(AppConstants.cd, [AppConstants.dot]);
}

void printUsage(ArgParser argParser) {
  print('Usage: mus.dart [options]');
  print(argParser.usage);
}

void runCommand(String executable, List<String> command) {
  print('Command executing : $executable ${command.join(' ')}');
  final result = Process.runSync(
    executable,
    command,
    runInShell: true,
  );

  if (result.exitCode != 0) {
    print('Error running command: $executable ${command.join(' ')}');
    print('Exit code: ${result.exitCode}');
    print('Output:\n${result.stdout}');
    print('Error:\n${result.stderr}');
  } else {
    print('Command executed successfully: $executable ${command.join(' ')}');
  }
}
