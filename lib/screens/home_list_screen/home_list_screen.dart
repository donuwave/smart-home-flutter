import 'package:flutter/material.dart';
import 'package:smart_home/entities/auth/store/token_store.dart';
import 'package:smart_home/entities/home/service/home_response.dart';
import 'package:smart_home/entities/home/service/home_service.dart';

class HomeListScreen extends StatefulWidget {
  const HomeListScreen({super.key});

  @override
  State<HomeListScreen> createState() => _HomeListState();
}

class _HomeListState extends State<HomeListScreen> {
  late final Future<List<HomeResponse>> _futureHomes;

  @override
  void initState() {
    super.initState();
    _futureHomes = HomeService().getHomeList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<HomeResponse>>(
      future: _futureHomes,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Ошибка: ${snap.error}'));
        }

        final homes = snap.data ?? [];

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: homes.length + 1,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index < homes.length) {
              final item = homes[index];
              return Card(
                color: theme.appBarTheme.surfaceTintColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: Text(
                    item.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        'Адрес: ${item.address}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Участники: ',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  onTap: () {
                    TokenManager.setHomeId(item.id);
                    Navigator.pushReplacementNamed(
                      context,
                      '/',
                      arguments: item.id,
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: TextButton(
                  onPressed: () {
                    /* TODO */
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center,
                  ),
                  child: Text(
                    'Добавить новый дом +',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      color: theme.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
