import 'package:flutter/material.dart';
import 'package:smart_home/entities/auth/store/token_store.dart';
import 'package:mjpeg_stream/mjpeg_stream.dart';
import 'package:smart_home/entities/home/service/home_response.dart';
import 'package:smart_home/entities/home/service/home_service.dart';

class HomeScreen extends StatefulWidget {
  final int homeId;
  const HomeScreen({super.key, required this.homeId});

  @override
  State<HomeScreen> createState() => HomeStateScreen();
}

class HomeStateScreen extends State<HomeScreen> {
  late final Future<HomeResponse> _futureHome;

  @override
  void initState() {
    super.initState();
    _futureHome = HomeService().getHomeById(widget.homeId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var children = [
      const SizedBox(height: 60),

      FutureBuilder<HomeResponse>(
        future: _futureHome,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }
          if (snap.hasError) {
            return Text(
              'Ошибка: ${snap.error}',
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            );
          }
          return Text(
            'ID дома: ${snap.data!.id}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ),
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
