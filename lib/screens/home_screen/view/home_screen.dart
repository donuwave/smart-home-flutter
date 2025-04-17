import 'package:flutter/material.dart';
import 'package:smart_home/entities/auth/store/token_store.dart';

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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text("ПУПУ"),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await TokenManager.clearTokens();
                    Navigator.pushReplacementNamed(context, '/login');
                  } catch (e) {
                    // Обработка ошибок
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    theme.colorScheme.primary,
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
        ),
      ),
    );
  }
}
