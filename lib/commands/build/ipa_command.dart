import '../../config/app_config.dart';
import 'build_command.dart';

class BuildIpaCommand extends BuildCommand {
  BuildIpaCommand()
      : super(
          name: 'ipa',
          description: 'Build iOS IPA',
          shortFlag: 'i',
        );

  @override
  Future<void> execute() async {
    await _fixPods();
    await runCommand(AppConfig.flutter, AppConfig.ipaBuildCommand);
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
