import 'package:smartbridge/domain/screen_factory.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart' as salomon;
import 'package:smartbridge/ui/locales/locale_switcher.dart';

class HRMainScreenWidget extends StatefulWidget {
  const HRMainScreenWidget({Key? key}) : super(key: key);

  @override
  MainScreenWidgetState createState() => MainScreenWidgetState();
}

class MainScreenWidgetState extends State<HRMainScreenWidget> {
  int _selectedTab = 0;
  final _screenFactory = ScreenFactory();

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text('SmartBridge'),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _screenFactory.makeSearchResume(),
          _screenFactory.makeFavorite(),
          _screenFactory.makeTemplatesList(),
          Scaffold(body: _screenFactory.makeSettings()),
        ],
      ),
      bottomNavigationBar: salomon.SalomonBottomBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedTab,
        unselectedItemColor: Colors.black,
        onTap: onSelectTab,
        items: [
          salomon.SalomonBottomBarItem(
            title: const Text("Поиск"),
            icon: const Icon(Icons.post_add),
            selectedColor: Colors.red,
          ),
          salomon.SalomonBottomBarItem(
            title: const Text("Избранное"),
            icon: const Icon(Icons.favorite),
            selectedColor: Colors.red,
          ),
          salomon.SalomonBottomBarItem(
            title: const Text("Шаблоны"),
            icon: const Icon(Icons.message),
            selectedColor: Colors.red,
          ),
          salomon.SalomonBottomBarItem(
            title: const Text("Настройки"),
            icon: const Icon(Icons.settings),
            selectedColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
