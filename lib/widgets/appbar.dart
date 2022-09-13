import 'package:flutter/material.dart';
import 'package:learning_ui/utils/extensions.dart';
import 'package:learning_ui/utils/theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.title,
    required this.themeNotifier,
  }) : super(key: key);

  final String title;
  final ThemeModel themeNotifier;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(
        title,
        style: context.textTheme.titleLarge?.copyWith(
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            themeNotifier.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
          ),
          onPressed: () {
            themeNotifier.isDarkMode
                ? themeNotifier.isDarkMode = false
                : themeNotifier.isDarkMode = true;
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
