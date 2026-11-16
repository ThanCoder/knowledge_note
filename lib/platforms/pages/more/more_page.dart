import 'package:knowledge_note/core/utils/app_util.dart';
import 'package:knowledge_note/platforms/pages/more/version_manager.dart';
import 'package:knowledge_note/ui/index.dart';
import 'package:material_ui/material_ui.dart';

import '../dev_pages/dev_route_tile.dart';
import 'app_about_dialog.dart';
import 'cache_manager.dart';

class MorePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("More")),
      body: ScrollableColumn(
        children: [
          MaterialThemeProviderChooser(),
          VersionManager(
            githubUrl: 'https://github.com/ThanCoder/knowledge_note',
          ),
          if (AppUtil.instance.platformCacheExists)
            CacheManagerListTile(
              cacheDirPath: AppUtil.instance.getPlatformCachePath(),
            ),

          DevRouteTile(),
          AppAboutDialogListTile(
            descText: 'Knowledge Note Application.',
            iconAssetPath: 'assets/logo/app_logo.png',
          ),
        ],
      ),
    );
  }
}
