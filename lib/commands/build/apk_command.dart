import 'dart:io';

import 'package:path/path.dart' as path;

import '../../config/app_config.dart';
import 'build_command.dart';

class BuildApkCommand extends BuildCommand {
  BuildApkCommand()
      : super(
          name: 'apk',
          description: 'Build Android APK',
          shortFlag: 'a',
        );

  @override
  Future<void> execute() async {
    final environment = await getEnvironment();
    final projectName = getProjectName();
    final date = getDate();
    final outputName = '${projectName}_${environment}_$date.apk';

    await cleanBuild();
    final buildSuccess =
        await runCommand(AppConfig.flutter, AppConfig.apkBuildCommand);

    if (buildSuccess) {
      final outputDir =
          path.join(Directory.current.path, AppConfig.apkOutputPath);
      await runCommand('mv', [
        path.join(outputDir, 'app-armeabi-v7a-release.apk'),
        path.join(outputDir, outputName)
      ]);
      await runCommand(AppConfig.open, [outputDir]);
    }
  }
}
