import 'dart:io';

import 'package:dart_core_extensions/dart_core_extensions.dart';
import 'package:knowledge_note/core/utils/app_util.dart';
import 'package:than_pkg_android/than_pkg_android.dart';

class PlatformUtil {
  static final PlatformUtil instance = PlatformUtil._();
  PlatformUtil._();
  factory PlatformUtil() => instance;

  final _appUtil = AppUtil.instance;

  Directory getCacheFolder([String? name]) {
    return Directory(_appUtil.getPlatformCachePath(name));
  }

  String getDBFolder({String? name}) {
    if (Platform.isLinux) {
      final root = Platform.environment['HOME']!;
      final dir = Directory(root.join('Downloads').join(_appUtil.appName));
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
      if (name != null) {
        return dir.path.join(name);
      }
      return dir.path;
    }
    if (Platform.isAndroid) {
      final root = ThanPkgAndroid.getInstance.pathHandler
          .getDeviceStoragePath();
      final dir = Directory(root.join('Download').join(_appUtil.appName));
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
      if (name != null) {
        return dir.path.join(name);
      }
      return dir.path;
    }
    throw UnsupportedError(Platform.operatingSystem);
  }

  Future<bool> storagePermissionGranted() async {
    if (Platform.isAndroid) {
      final pkg = ThanPkgAndroid.getInstance.storagePermissionHandler;
      return await pkg.isStoragePermissionGranted();
    }
    return true;
  }

  Future<bool> reqStoragePermission() {
    final pkg = ThanPkgAndroid.getInstance.storagePermissionHandler;
    return pkg.requestStoragePermission();
  }
}
