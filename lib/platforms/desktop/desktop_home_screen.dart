import 'package:knowledge_note/platforms/pages/search/search_home_page.dart';
import 'package:material_ui/material_ui.dart';

import '../mobile/mobile_home_page.dart';
import '../pages/more/more_page.dart';

class DesktopHomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: index,
            onDestinationSelected: (value) {
              setState(() {
                index = value;
              });
            },
            destinations: [
              .new(icon: Icon(Icons.home_outlined), label: Text('Home')),
              .new(icon: Icon(Icons.search_outlined), label: Text('Search')),
              .new(icon: Icon(Icons.grid_view_outlined), label: Text('More')),
            ],
          ),
          VerticalDivider(),
          Expanded(
            child: IndexedStack(
              index: index,
              children: [MobileHomePage(), SearchHomePage(), MorePage()],
            ),
          ),
        ],
      ),
    );
  }
}
