import 'package:flutter/material.dart';
import 'package:smart_home/shared/config.dart';
import 'package:smart_home/shared/router.dart';

void main() {
  AppConfig.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        scaffoldBackgroundColor: Color.fromARGB(255, 31, 31, 31),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 31, 31, 31),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        listTileTheme: ListTileThemeData(iconColor: Colors.white),
        textTheme: TextTheme(
          bodyLarge: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
          bodyMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          labelSmall: TextStyle(
            color: const Color.fromARGB(255, 213, 191, 191),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
