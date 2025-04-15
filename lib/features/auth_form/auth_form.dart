import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final bool obscureText;
  final VoidCallback togglePasswordVisibility;

  const LoginForm({
    super.key,
    required this.loginController,
    required this.passwordController,
    required this.obscureText,
    required this.togglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(height: 60),
          Text('Вход в аккаунт', style: theme.textTheme.bodyLarge),
          const SizedBox(height: 50),
          TextField(
            controller: loginController,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              labelText: 'Логин',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            style: theme.textTheme.bodyMedium,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: 'Пароль',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                onPressed: togglePasswordVisibility,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print('Попытка авторизации...');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    theme.colorScheme.primary,
                  ),
                ),
                child: Text(
                  'Войти',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
