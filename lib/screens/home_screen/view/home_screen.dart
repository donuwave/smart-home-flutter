import 'package:flutter/material.dart';
import 'package:smart_home/entities/auth/store/token_store.dart';
import 'package:smart_home/entities/device/service/device_response.dart';
import 'package:smart_home/entities/device/service/device_service.dart';
import 'package:smart_home/entities/device/widgets/device_card.dart';
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
  late final Future<List<DeviceResponse>> _futureDevices;

  @override
  void initState() {
    super.initState();
    _futureHome = HomeService().getHomeById(widget.homeId).then((home) {
      _futureDevices = DeviceService().getDeviceList();
      return home;
    });
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
          if (snap.hasError) {
            return Text('Ошибка: ${snap.error}');
          }
          final home = snap.data;
          if (home == null) {
            return const SizedBox.shrink();
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
                icon: AssetImage('assets/cloud.png'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Список устройств',
                          style: theme.textTheme.bodyLarge,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: здесь ваша логика добавления устройства (навигация на экран добавления и т.п.)
                          },
                          icon: Icon(Icons.add, color: Colors.white, size: 20),
                          label: Text(
                            'Добавить',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: theme.primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            shape: const StadiumBorder(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 32, 0, 12),
                      child: FutureBuilder<List<DeviceResponse>>(
                        future: _futureDevices,
                        builder: (context, deviceSnap) {
                          if (deviceSnap.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (deviceSnap.hasError) {
                            return Text(
                              'Ошибка загрузки устройств: ${deviceSnap.error}',
                            );
                          }
                          final devices = deviceSnap.data!;
                          if (devices.isEmpty) {
                            return const Text('Устройства не найдены');
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 3 / 2,
                                ),
                            itemCount: devices.length,
                            itemBuilder: (context, index) {
                              final device = devices[index];
                              return DeviceCard(
                                device: device,
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/camera',
                                    arguments: 1,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                    'Выйти из дома',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      color: theme.primaryColor,
                      decoration: TextDecoration.underline,
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
                      Navigator.pushReplacementNamed(context, '/login');
                    } catch (e) {}
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      theme.primaryColor,
                    ),
                  ),
                  child: Text(
                    'Выйти',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
