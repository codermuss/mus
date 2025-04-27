import 'dart:io';

import 'package:path/path.dart' as path;

import '../config/app_config.dart';
import 'base_command.dart';

class BuildApkCommand extends BaseCommand {
  BuildApkCommand()
      : super(
          name: 'apk',
          description: 'Build Android APK',
          shortFlag: 'a',
        );

  @override
  Future<void> execute() async {
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.buildDir]);
    await runCommand(AppConfig.flutter, [
      AppConfig.build,
      AppConfig.apk,
      AppConfig.release,
      AppConfig.obfuscate,
      AppConfig.splitDebugInfo,
      AppConfig.splitPerAbi,
      AppConfig.noShrink
    ]);
    await runCommand(AppConfig.open, [
      AppConfig.build,
      AppConfig.app,
      AppConfig.outputs,
      AppConfig.flutterApk
    ]);
  }
}

class BuildAppBundleCommand extends BaseCommand {
  BuildAppBundleCommand()
      : super(
          name: 'appbundle',
          description: 'Build Android App Bundle',
          shortFlag: 'b',
        );

  @override
  Future<void> execute() async {
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.buildDir]);
    await runCommand(AppConfig.flutter, [
      AppConfig.build,
      AppConfig.appBundle,
      AppConfig.release,
      AppConfig.obfuscate,
      AppConfig.splitDebugInfo,
      AppConfig.noShrink
    ]);

    final bundlePath = path.join(Directory.current.path, 'build', 'app',
        'outputs', 'bundle', 'release', 'app-release.aab');

    if (!File(bundlePath).existsSync()) {
      throw Exception('App Bundle file not found at: $bundlePath');
    }

    await runCommand(AppConfig.open, [bundlePath]);
  }
}

class BuildIpaCommand extends BaseCommand {
  BuildIpaCommand()
      : super(
          name: 'ipa',
          description: 'Build iOS IPA',
          shortFlag: 'i',
        );

  @override
  Future<void> execute() async {
    await _fixPods();
    await runCommand(AppConfig.flutter, [
      AppConfig.build,
      AppConfig.ipa,
      AppConfig.obfuscate,
      AppConfig.splitDebugInfo
    ]);
  }

  Future<void> _fixPods() async {
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.iosPods]);
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.iosPodfileLock]);
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.symLinks]);
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.buildDir]);
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.pubspecLock]);
    await runCommand(AppConfig.flutter, [AppConfig.clean]);
    await runCommand(AppConfig.flutter, [AppConfig.pub, AppConfig.get]);
    await runCommand(AppConfig.cd, [AppConfig.ios]);
    await runCommand(AppConfig.sudo, [
      AppConfig.arch,
      AppConfig.x8664,
      AppConfig.gem,
      AppConfig.install,
      AppConfig.ffi
    ]);
    await runCommand(AppConfig.arch, [
      AppConfig.x8664,
      AppConfig.pod,
      AppConfig.install,
      AppConfig.repoUpdate
    ]);
    await runCommand(AppConfig.cd, [AppConfig.dot]);
  }
}

class BuildWebCommand extends BaseCommand {
  BuildWebCommand()
      : super(
          name: 'web',
          description: 'Build Web',
          shortFlag: 'w',
        );

  @override
  Future<void> execute() async {
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.buildDir]);
    await runCommand(AppConfig.flutter, [
      AppConfig.build,
      AppConfig.web,
      AppConfig.release,
    ]);
  }
}
