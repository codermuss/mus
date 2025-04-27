import '../../config/app_config.dart';
import 'base_command.dart';

class CleanCommand extends BaseCommand {
  CleanCommand()
      : super(
          name: 'clean',
          description: 'Clean the project',
          shortFlag: 'c',
        );

  @override
  Future<void> execute() async {
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.buildDir]);
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.pubspecLock]);
    await runCommand(AppConfig.flutter, [AppConfig.clean]);
    await runCommand(AppConfig.flutter, [AppConfig.pub, AppConfig.get]);
  }
}
