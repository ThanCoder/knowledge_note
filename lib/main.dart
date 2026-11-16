import 'dart:io';

import 'package:knowledge_note/core/utils/app_util.dart';
import 'package:material_ui/material_ui.dart';
import 'package:than_pkg_linux/than_pkg_linux.dart';

import 'keys.dart';
import 'platforms/platform_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppUtil.instance.init();

  if (Platform.isLinux) {
    final cf = AppUtil.instance.config;
    ThanPkgLinux.getInstance.window.setWindowSize(
      width: cf.getDouble(appWindowWidthKey, 600).toInt(),
      height: cf.getDouble(appWindowHeightKey, 400).toInt(),
    );
  }

  // ControllerManager.register(VFileController());
  // ControllerManager.initAll();

  runApp(const PlatformApp());
}
