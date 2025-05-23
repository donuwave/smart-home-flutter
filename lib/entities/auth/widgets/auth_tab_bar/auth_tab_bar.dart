import 'package:flutter/material.dart';

class AuthTabBar extends StatelessWidget {
  final TabController tabController;
  final PageController pageController;

  const AuthTabBar({
    super.key,
    required this.tabController,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TabBar(
      controller: tabController,
      tabs: const [Tab(text: 'Вход'), Tab(text: 'Регистрация')],
      labelColor: theme.colorScheme.primary,
      unselectedLabelColor: Colors.grey,
      indicatorColor: theme.colorScheme.primary,
      physics: const NeverScrollableScrollPhysics(),
      onTap: (index) => pageController.jumpToPage(index),
    );
  }
}
