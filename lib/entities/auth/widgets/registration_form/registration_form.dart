import 'package:flutter/material.dart';
import 'package:smart_home/entities/auth/service/auth_service.dart';

class RegistrationForm extends StatefulWidget {
  final bool obscureText;
  final VoidCallback togglePasswordVisibility;

  const RegistrationForm({
    super.key,
    required this.obscureText,
    required this.togglePasswordVisibility,
  });

  @override
  State<RegistrationForm> createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  final FocusNode loginFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  bool isLoginValidated = false;
  bool isPasswordValidated = false;

  Future<void> register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final login = loginController.text;
      final password = passwordController.text;

      try {
        final response = await AuthService().register(login, password);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Успешный вход!')));
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // Слушатели для отслеживания фокуса
    loginFocusNode.addListener(() {
      if (!loginFocusNode.hasFocus) {
        setState(() {
          isLoginValidated = true; // Убираем ошибку при фокусе
        });
      }
    });

    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          isPasswordValidated = false; // Убираем ошибку при фокусе
        });
      }
    });
  }

  @override
  void dispose() {
    loginFocusNode.dispose();
    passwordFocusNode.dispose();
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 60),
            Text(
              'Создание нового аккаунта',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            TextFormField(
              controller: loginController,
              style: theme.textTheme.bodyMedium,
              focusNode: loginFocusNode,
              decoration: InputDecoration(
                labelText: 'Электронная почта',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите логин';
                }

                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                if (!emailRegex.hasMatch(value)) {
                  return 'Введите корректный email';
                }
                return null; // Нет ошибок
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: widget.obscureText,
              focusNode: passwordFocusNode,
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
                    widget.obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  onPressed: widget.togglePasswordVisibility,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Пожалуйста, введите пароль';
                }
                if (value.length < 6) {
                  return 'Пароль должен содержать минимум 6 символов';
                }
                return null; // Нет ошибок
              },
            ),
            const SizedBox(height: 20),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => register(context),
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
      ),
    );
  }
}
