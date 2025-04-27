import 'dart:io';

import '../../config/app_config.dart';
import '../base_command.dart';

abstract class BuildCommand extends BaseCommand {
  BuildCommand({
    required String name,
    required String description,
    required String shortFlag,
  }) : super(name: name, description: description, shortFlag: shortFlag);

  Future<String> getEnvironment() async {
    print('Enter environment (e.g. dev, prod, staging):');
    final environment = stdin.readLineSync()?.toLowerCase() ?? 'dev';
    return environment;
  }

  String getProjectName() {
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

  String getDate() => DateTime.now().toString().split(' ')[0];

  Future<void> cleanBuild() async {
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.buildDir]);
  }
}
