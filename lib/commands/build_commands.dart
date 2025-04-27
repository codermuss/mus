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
    final environment = await _getEnvironment();
    final projectName = _getProjectName();
    final date = DateTime.now().toString().split(' ')[0];
    final outputName = '${projectName}_${environment}_$date.apk';

    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.buildDir]);
    final buildSuccess = await runCommand(AppConfig.flutter, [
      AppConfig.build,
      AppConfig.apk,
      AppConfig.release,
      AppConfig.obfuscate,
      AppConfig.splitDebugInfo,
      AppConfig.splitPerAbi,
      AppConfig.noShrink
    ]);
    if (buildSuccess) {
      final outputDir =
          '${AppConfig.build}/${AppConfig.app}/${AppConfig.outputs}/${AppConfig.flutterApk}';
      await runCommand('mv', [
        path.join(outputDir, 'app-armeabi-v7a-release.apk'),
        path.join(outputDir, outputName)
      ]);
      await runCommand(AppConfig.open, [outputDir]);
    }
  }

  Future<String> _getEnvironment() async {
    print('Enter environment (e.g. dev, prod, staging):');
    final environment = stdin.readLineSync()?.toLowerCase() ?? 'dev';
    return environment;
  }

  String _getProjectName() {
    final pubspecFile = File('pubspec.yaml');
    if (pubspecFile.existsSync()) {
      final content = pubspecFile.readAsStringSync();
      final nameMatch = RegExp(r'name:\s*([^\n]+)').firstMatch(content);
      if (nameMatch != null) {
        return nameMatch.group(1)?.trim() ?? 'app';
      }
    }
    return 'app';
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
    final environment = await _getEnvironment();
    final projectName = _getProjectName();
    final date = DateTime.now().toString().split(' ')[0];
    final outputName = '${projectName}_${environment}_$date.aab';

    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.buildDir]);
    final buildSuccess = await runCommand(AppConfig.flutter, [
      AppConfig.build,
      AppConfig.appBundle,
      AppConfig.release,
      AppConfig.obfuscate,
      AppConfig.splitDebugInfo,
      AppConfig.noShrink
    ]);

    if (buildSuccess) {
      final outputDir =
          '${AppConfig.build}/${AppConfig.app}/${AppConfig.outputs}/${AppConfig.bundle}/${AppConfig.releaseFolder}';
      await runCommand('mv', [
        path.join(outputDir, 'app-release.aab'),
        path.join(outputDir, outputName)
      ]);
      await runCommand(AppConfig.open, [outputDir]);
    }
  }

  Future<String> _getEnvironment() async {
    print('Enter environment (e.g. dev, prod, staging):');
    final environment = stdin.readLineSync()?.toLowerCase() ?? 'dev';
    return environment;
  }

  String _getProjectName() {
    final pubspecFile = File('pubspec.yaml');
    if (pubspecFile.existsSync()) {
      final content = pubspecFile.readAsStringSync();
      final nameMatch = RegExp(r'name:\s*([^\n]+)').firstMatch(content);
      if (nameMatch != null) {
        return nameMatch.group(1)?.trim() ?? 'app';
      }
    }
    return 'app';
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
