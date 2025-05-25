import 'package:flutter/material.dart';
import 'package:smart_home/entities/auth/service/view.dart';
import 'package:smart_home/entities/auth/store/token_store.dart';

class LoginForm extends StatefulWidget {
  final bool obscureText;
  final VoidCallback togglePasswordVisibility;

  const LoginForm({
    super.key,
    required this.obscureText,
    required this.togglePasswordVisibility,
  });

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();

  final FocusNode loginFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  bool isLoginValidated = false;
  bool isPasswordValidated = false;

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final login = loginController.text;
      final password = passwordController.text;

      try {
        final response = await AuthService().login(login, password);
        await TokenManager.saveTokens(
          response.accessToken,
          response.refreshToken,
          response.userId,
        );
        Navigator.pushReplacementNamed(context, '/home-list');
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

    loginFocusNode.addListener(() {
      if (!loginFocusNode.hasFocus) {
        setState(() {
          isLoginValidated = true;
        });
      }
    });

    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          isPasswordValidated = false;
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
            Text('Вход в аккаунт', style: theme.textTheme.bodyLarge),
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
              style: theme.textTheme.bodyMedium,
              focusNode: passwordFocusNode,
              obscureText: widget.obscureText,
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => login(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      theme.primaryColor,
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
      ),
    );
  }
}
