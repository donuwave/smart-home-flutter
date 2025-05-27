import 'package:flutter/material.dart';
import 'package:smart_home/entities/auth/store/token_store.dart';
import 'package:mjpeg_stream/mjpeg_stream.dart';
import 'package:smart_home/entities/home/service/home_response.dart';
import 'package:smart_home/entities/home/service/home_service.dart';
import 'package:smart_home/entities/weather/view/weather_card.dart';
import 'package:smart_home/screens/home_screen/widgets/greeting_text.dart';

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
      FutureBuilder<HomeResponse>(
        future: _futureHome,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2) Ошибка
          if (snap.hasError) {
            return Text('Ошибка: ${snap.error}');
          }
          // 3) Нет данных
          final home = snap.data;
          if (home == null) {
            // Если дома нет — возвращаем пустой виджет или текст
            return const SizedBox.shrink();
            // или, например:
            // return Center(child: Text('Дом не найден'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingText(
                name: "Daniil",
                subtitle: 'Добро пожаловать в ${home.name}',
              ),

              const SizedBox(height: 16),

              Text(
                'ID дома: ${home.id}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              WeatherCard(
                description: 'Облачно',
                location: 'Нижний Новгород, Россия',
                temperature: '22°',
                feelsLike: '27°C',
                precipitation: '4%',
                humidity: '66%',
                wind: '16 км/ч',
                icon: AssetImage('assets/vinni-pukh-v-png.png'),
              ),

              // SizedBox(
              //   width: double.infinity,
              //   height: 50,
              //   child: ElevatedButton(
              //     onPressed: () async {
              //       try {
              //         await TokenManager.clearTokens();
              //         // ignore: use_build_context_synchronously
              //         Navigator.pushReplacementNamed(context, '/login');
              //       } catch (e) {}
              //     },
              //     style: ButtonStyle(
              //       backgroundColor: WidgetStateProperty.all(
              //         theme.primaryColor,
              //       ),
              //     ),
              //     child: Text(
              //       'Выйти',
              //       style: theme.textTheme.bodyMedium?.copyWith(
              //         color: const Color.fromRGBO(255, 255, 255, 1),
              //       ),
              //     ),
              //   ),
              // ),
              Center(
                child: TextButton(
                  onPressed: () async {
                    try {
                      await TokenManager.clearHomeId();
                      Navigator.pushReplacementNamed(context, '/home-list');
                    } catch (e) {}
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center,
                  ),
                  child: Text(
                    'Изменить дом',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      color: theme.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
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
