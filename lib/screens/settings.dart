// Leader Board Screen to show the players and their scores

import 'package:flutter/material.dart';
import 'package:learning_ui/utils/extensions.dart';
import 'package:learning_ui/utils/theme.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            'Settings',
            style: context.textTheme.titleLarge?.copyWith(
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                themeNotifier.isDarkMode
                    ? Icons.wb_sunny
                    : Icons.nightlight_round,
              ),
              onPressed: () {
                themeNotifier.isDarkMode
                    ? themeNotifier.isDarkMode = false
                    : themeNotifier.isDarkMode = true;
              },
            ),
          ],
        ),
        body: _buildSettings(context),
      );
    });
  }

  Widget _buildSettings(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              'Settings for this app will soon appear here.',
              style: context.textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
