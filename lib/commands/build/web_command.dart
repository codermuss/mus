import '../../config/app_config.dart';
import 'build_command.dart';

class BuildWebCommand extends BuildCommand {
  BuildWebCommand()
      : super(
          name: 'web',
          description: 'Build Web',
          shortFlag: 'w',
        );

  @override
  Future<void> execute() async {
    await cleanBuild();
    await runCommand(AppConfig.flutter, AppConfig.webBuildCommand);
  }
}
