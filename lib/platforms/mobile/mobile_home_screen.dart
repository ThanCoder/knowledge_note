import 'package:knowledge_note/platforms/mobile/mobile_home_page.dart';
import 'package:material_ui/material_ui.dart';

import '../pages/more/more_page.dart';


class MobileHomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [MobileHomePage(), MorePage()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Video',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
