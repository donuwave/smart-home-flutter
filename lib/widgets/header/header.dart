import 'package:flutter/material.dart';
import 'package:smart_home/entities/profile/service/profile_service.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const Header({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final _profileService = ProfileService();
  String? _firstName;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _profileService.getProfile();
      if (!mounted) return;

      setState(() {
        _firstName = profile.firstName;
        _loading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: 122,
      backgroundColor: theme.appBarTheme.backgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(widget.title, style: theme.appBarTheme.titleTextStyle),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () {
              // здесь переход на экран профиля
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: theme.primaryColor,
                  child: Icon(
                    Icons.person,
                    size: 18,
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _loading ? '' : (_firstName ?? ''),
                  style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: theme.dividerColor),
      ),
    );
  }
}
