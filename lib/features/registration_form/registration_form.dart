import 'package:flutter/material.dart';

class RegistrationForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final bool obscureText;
  final VoidCallback togglePasswordVisibility;

  const RegistrationForm({
    super.key,
    required this.nameController,
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
          Text(
            'Создание нового аккаунта',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          TextField(
            controller: nameController,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              labelText: 'Имя',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: loginController,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              labelText: 'Электронная почта',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            obscureText: obscureText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color,
            ),
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
          const SizedBox(height: 20),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print('Попытка регистрации...');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    theme.colorScheme.primary,
                  ),
                ),
                child: Text(
                  'Зарегистрироваться',
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
