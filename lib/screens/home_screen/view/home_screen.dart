import 'package:flutter/material.dart';
import 'package:smart_home/entities/auth/store/token_store.dart';
import 'package:mjpeg_stream/mjpeg_stream.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeStateScreen();
}

class HomeStateScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var children = [
      const SizedBox(height: 60),
      const Text("ПУПУ2"),
      // MJPEGStreamScreen(
      //   streamUrl: 'http://10.0.2.2:8003/api/v1/stream/video_feed?device_id=2',
      //   width: double.infinity,
      //   height: 300.0,
      //   fit: BoxFit.cover,
      //   showLiveIcon: true,
      // ),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            try {
              await TokenManager.clearTokens();
              Navigator.pushReplacementNamed(context, '/login');
            } catch (e) {}
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(theme.primaryColor),
          ),
          child: Text(
            'Выйти',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            try {
              await TokenManager.clearTokens();
              Navigator.pushReplacementNamed(context, '/home-list');
            } catch (e) {}
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(theme.primaryColor),
          ),
          child: Text(
            'home-list',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
      ),
    ];
    return Scaffold(
      drawer: Drawer(
        backgroundColor: theme.appBarTheme.backgroundColor,
        child: ListView(
          children: const [
            DrawerHeader(child: Text("Меню")),
            ListTile(title: Text("Пункт 1")),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }
}
