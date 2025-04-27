import 'dart:io';

import 'package:path/path.dart' as path;

import '../../config/app_config.dart';
import 'build_command.dart';

class BuildAppBundleCommand extends BuildCommand {
  BuildAppBundleCommand()
      : super(
          name: 'appbundle',
          description: 'Build Android App Bundle',
          shortFlag: 'b',
        );

  @override
  Future<void> execute() async {
    final environment = await getEnvironment();
    final projectName = getProjectName();
    final date = getDate();
    final outputName = '${projectName}_${environment}_$date.aab';

    await cleanBuild();
    final buildSuccess =
        await runCommand(AppConfig.flutter, AppConfig.bundleBuildCommand);

    if (buildSuccess) {
      final outputDir =
          path.join(Directory.current.path, AppConfig.bundleOutputPath);
      await runCommand('mv', [
        path.join(outputDir, 'app-release.aab'),
        path.join(outputDir, outputName)
      ]);
      await runCommand(AppConfig.open, [outputDir]);
    }
  }
}
