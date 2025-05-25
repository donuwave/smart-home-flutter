import 'package:flutter/material.dart';
import 'package:smart_home/widgets/header/header.dart';

class NavigationBottomBar extends StatelessWidget {
  final Widget child;
  const NavigationBottomBar({Key? key, required this.child}) : super(key: key);

  static const _paths = ['/', '/camers-list', '/settings'];
  static const _titles = ['Главная', 'Устройства', 'Настройки'];
  static const _icons = [Icons.home, Icons.videocam, Icons.settings];

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '/';
    final currentIndex = _paths.indexOf(routeName).clamp(0, _paths.length - 1);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: Header(title: _titles[currentIndex]),
      body: child,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1, thickness: 1, color: Colors.white),
          BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: theme.appBarTheme.backgroundColor,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.white70,
            onTap: (i) => Navigator.pushReplacementNamed(context, _paths[i]),
            items: List.generate(
              _paths.length,
              (i) => BottomNavigationBarItem(
                icon: Icon(_icons[i]),
                label: _titles[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
