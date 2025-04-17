import 'package:flutter/material.dart';
import 'package:smart_home/entities/auth/store/token_store.dart';
import 'package:smart_home/screens/auth_screen/view/view.dart';
import 'package:smart_home/screens/home_screen/view/view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final accessToken = TokenManager.getAccessToken();

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => accessToken != null ? HomeScreen() : AuthScreen(),
        );

      case '/login':
        return MaterialPageRoute(builder: (_) => AuthScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
