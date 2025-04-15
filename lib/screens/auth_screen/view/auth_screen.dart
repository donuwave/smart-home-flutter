import 'package:flutter/material.dart';
import 'package:smart_home/features/auth_form/view.dart';
import 'package:smart_home/features/registration_form/view.dart';
import 'package:smart_home/screens/auth_screen/widgets/view.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  late PageController _pageController;
  late TabController _tabController;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            AuthTabBar(
              tabController: _tabController,
              pageController: _pageController,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  LoginForm(
                    loginController: _loginController,
                    passwordController: _passwordController,
                    obscureText: _obscureText,
                    togglePasswordVisibility: togglePasswordVisibility,
                  ),
                  RegistrationForm(
                    nameController: _nameController,
                    loginController: _loginController,
                    passwordController: _passwordController,
                    obscureText: _obscureText,
                    togglePasswordVisibility: togglePasswordVisibility,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
