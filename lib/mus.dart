import 'dart:io';

class AppCommands {
  static const clean = 'clean';
  static const apk = 'apk';
  static const ipa = 'ipa';
  static const fixPods = 'fixPods';
  static const appBundle = 'appBundle';
  static const web = 'web';
  static const runBuildRunner = 'runBuildRunner';
}

class AppConstants {
  static const flutter = 'flutter';
  static const pub = 'pub';
  static const getWord = 'get';
  static const rm = 'rm';
  static const r = '-r';
  static const iosPods = 'ios/Pods';
  static const iosPodfileLock = 'ios/Podfile.lock';
  static const symLinks = 'ios/.symlinks';
  static const sudo = 'sudo';
  static const arch = 'arch';
  static const x8664 = '-x86_64';
  static const gem = 'gem';
  static const install = 'install';
  static const ffi = 'ffi';
  static const pod = 'pod';
  static const repoUpdate = '--repo-update';
  static const build = 'build';
  static const apk = 'apk';
  static const release = '--release';
  static const obfuscate = '--obfuscate';
  static String splitDebugInfo =
      '--split-debug-info=${Directory.current.path}/debug_info';
  static const spilitPerAbi = '--split-per-abi';
  static const noShrink = '--no-shrink';
  static const pubspecLock = 'pubspec.lock';
  static const appBundle = 'appbundle';
  static const web = 'web';
  static const cd = 'cd';
  static const ios = 'ios';
  static const dot = '..';
  static const open = 'open';
  static const outputs = 'outputs';
  static const app = 'app';
  static const bundle = 'bundle';
  static const releaseFolder = 'release';
  static const flutterApk = 'flutter-apk';
  static const dart = 'dart';
  static const run = 'run';
  static const buildRunner = 'build_runner';
  static const deleteConflictingOutputs = 'delete-conflicting-outputs';
}

class HelpDescriptions {
  static const clean = 'Run flutter clean';
  static const releaseApk = 'Run release Apk script';
  static const buildIpa = 'Run Ipa script';
  static const fixPods = 'Run fix pods script';
  static const appBundle = 'Run app bundle script';
  static const web = 'Run web build script';
  static const runBuildRunner = 'Run build runner script';
}

class ShortHands {
  static const clean = 'c';
  static const releaseApk = 'a';
  static const buildIpa = 'i';
  static const fixPods = 'p';
  static const appBundle = 'b';
  static const web = 'w';
  static const runBuildRunner = 'r';
}
