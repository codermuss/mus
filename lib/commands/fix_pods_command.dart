import '../../config/app_config.dart';
import 'base_command.dart';

class FixPodsCommand extends BaseCommand {
  FixPodsCommand()
      : super(
          name: 'fixPods',
          description: 'Fix iOS pods',
          shortFlag: 'p',
        );

  @override
  Future<void> execute() async {
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.iosPods]);
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.iosPodfileLock]);
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.symLinks]);
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.buildDir]);
    await runCommand(AppConfig.rm, [AppConfig.r, AppConfig.pubspecLock]);
    await runCommand(AppConfig.flutter, [AppConfig.clean]);
    await runCommand(AppConfig.flutter, [AppConfig.pub, AppConfig.get]);

    // Change to ios directory first
    await runCommand(AppConfig.cd, [AppConfig.ios]);

    // Install ffi gem
    await runCommand(AppConfig.sudo, [
      AppConfig.arch,
      AppConfig.x8664,
      AppConfig.gem,
      AppConfig.install,
      AppConfig.ffi
    ]);

    // Install pods
    await runCommand(AppConfig.arch, [
      AppConfig.x8664,
      AppConfig.pod,
      AppConfig.install,
      AppConfig.repoUpdate
    ]);

    // Go back to root directory
    await runCommand(AppConfig.cd, [AppConfig.dot]);
  }
}
