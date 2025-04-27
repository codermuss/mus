class AppConfig {
  // Flutter commands
  static const String flutter = 'flutter';
  static const String build = 'build';
  static const String clean = 'clean';
  static const String pub = 'pub';
  static const String get = 'get';

  // Build options
  static const String release = '--release';
  static const String obfuscate = '--obfuscate';
  static const String splitDebugInfo =
      '--split-debug-info=build/app/outputs/symbols';
  static const String splitPerAbi = '--split-per-abi';
  static const String noShrink = '--no-shrink';

  // Build types
  static const String apk = 'apk';
  static const String appBundle = 'appbundle';
  static const String ipa = 'ipa';
  static const String web = 'web';

  // System commands
  static const String rm = 'rm';
  static const String r = '-r';
  static const String open = 'open';
  static const String cd = 'cd';
  static const String dot = '.';
  static const String sudo = 'sudo';
  static const String arch = 'arch';
  static const String x8664 = '-x86_64';
  static const String gem = 'gem';
  static const String install = 'install';
  static const String ffi = 'ffi';
  static const String pod = 'pod';
  static const String repoUpdate = '--repo-update';

  // File paths
  static const String buildDir = 'build';
  static const String pubspecLock = 'pubspec.lock';
  static const String iosPods = 'ios/Pods';
  static const String iosPodfileLock = 'ios/Podfile.lock';
  static const String symLinks = 'ios/.symlinks';
  static const String ios = 'ios';
  static const String app = 'app';
  static const String outputs = 'outputs';
  static const String flutterApk = 'flutter-apk';
  static const String bundle = 'bundle';
  static const String releaseFolder = 'release';

  // Build output paths
  static String get apkOutputPath => '$buildDir/$app/$outputs/$flutterApk';
  static String get bundleOutputPath =>
      '$buildDir/$app/$outputs/$bundle/$releaseFolder';
  static String get webOutputPath => '$buildDir/$web';

  // Build commands
  static List<String> get apkBuildCommand =>
      [build, apk, release, obfuscate, splitDebugInfo, splitPerAbi, noShrink];

  static List<String> get bundleBuildCommand =>
      [build, appBundle, release, obfuscate, splitDebugInfo, noShrink];

  static List<String> get ipaBuildCommand =>
      [build, ipa, obfuscate, splitDebugInfo];

  static List<String> get webBuildCommand => [build, web, release];
}
