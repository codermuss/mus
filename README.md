# 🚀 Mus - Flutter Build CLI Tool

A powerful command-line interface tool for streamlining Flutter build processes across multiple platforms.

## 📦 Installation

### Install globally

```bash
dart pub global activate mus
```

Or
```bash
dart pub global activate --source git https://github.com/codermuss/mus.git
```

Or run directly
```bash
dart run mus
```

## 🎯 Features

- **Cross-Platform Builds**: Build for Android, iOS, and Web platforms
- **Environment Management**: Support for different environments (dev, prod, staging)
- **Automated Cleanup**: Clean build directories and dependencies
- **iOS Pod Management**: Fix and update iOS pods automatically
- **Beautiful Output**: Colorized and formatted terminal output
- **Smart Naming**: Automatic versioning and naming of build artifacts

## 🛠️ Commands

### Build Commands

#### Build Android APK
```bash
mus apk
```
or
```bash
mus -a
```

#### Build Android App Bundle
```bash
mus appbundle
```
or
```bash
mus -b
```

#### Build iOS IPA
```bash
mus ipa
```
or
```bash
mus -i
```

#### Build Web
```bash
mus web
```
or
```bash
mus -w
```

### Utility Commands

#### Clean Project
```bash
mus clean
```
or
```bash
mus -c
```

#### Fix iOS Pods
```bash
mus fixPods
```
or
```bash
mus -p
```

### Global Options

#### Show Help
```bash
mus --help
```
or
```bash
mus -h
```

#### Show Version
```bash
mus --version
```
or
```bash
mus -v
```

## 📝 Usage Examples

#### Build Android APK
```bash
mus apk
```

#### Build iOS IPA
```bash
mus ipa
```

#### Build Web
```bash
mus web
```

#### Clean Project
```bash
mus clean
```

#### Fix iOS Pods
```bash
mus fixPods
```

## 🔧 Build Process

### Android APK/App Bundle
- Cleans build directory
- Builds the app
- Automatically names the output file with environment and date
- Opens the output directory

### iOS IPA
- Fixes pods
- Cleans build directory
- Builds the app

### Web
- Cleans build directory
- Builds the web app

## 🎨 Output Format

The CLI provides beautifully formatted output with:
- Color-coded status messages
- Command execution details
- Error handling and reporting
- Progress indicators

## 🔍 Environment Support

When building, you'll be prompted to select an environment:
- dev
- prod
- staging

The selected environment is included in the output filename.

## 📦 Dependencies

- Flutter SDK
- Dart SDK
- iOS: CocoaPods
- Android: Android SDK

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
