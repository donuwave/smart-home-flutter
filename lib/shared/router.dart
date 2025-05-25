import 'package:flutter/material.dart';
import 'package:smart_home/entities/auth/store/token_store.dart';
import 'package:smart_home/screens/auth_screen/view/view.dart';
import 'package:smart_home/screens/deices_screen/view/devices_screen.dart';
import 'package:smart_home/screens/home_list_screen/home_list_screen.dart';
import 'package:smart_home/screens/home_screen/view/view.dart';
import 'package:smart_home/widgets/header/header.dart';
import 'package:smart_home/widgets/navigation/navigation.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final accessToken = TokenManager.getAccessToken();
    final homeId = TokenManager.getHomeId();

    Widget wrapWithHeader(Widget page, String title) {
      return Scaffold(appBar: Header(title: title), body: page);
    }

    if (accessToken == null) {
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    }

    if (homeId == null) {
      return MaterialPageRoute(
        builder:
            (_) => wrapWithHeader(
              const HomeListScreen(),
              "Список доступных домов",
            ),
        settings: settings,
      );
    }

    Widget wrapWithNav(Widget page) => NavigationBottomBar(child: page);

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => wrapWithNav(const HomeScreen()),
          settings: settings,
        );

      case '/home-list':
        return MaterialPageRoute(
          builder:
              (_) => wrapWithHeader(
                const HomeListScreen(),
                "Список доступных домов",
              ),
          settings: settings,
        );

      case '/camers-list':
        return MaterialPageRoute(
          builder: (_) => wrapWithNav(const DevicesScreen()),
          settings: settings,
        );

      case '/settings':
        return MaterialPageRoute(
          builder:
              (_) => wrapWithNav(
                const Center(
                  child: Text('Настройки', style: TextStyle(fontSize: 24)),
                ),
              ),
          settings: settings,
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
          settings: settings,
        );
    }
  }
}
