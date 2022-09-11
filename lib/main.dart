import 'package:flutter/material.dart';
import 'package:learning_ui/screens/players.dart';
import 'package:learning_ui/utils/db.dart';
import 'package:learning_ui/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteService().initializeDB();
  await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(
        builder: (context, ThemeModel themeNotifier, child) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Tic Tac Toe',
                theme: themeNotifier.isDarkMode
                    ? Themes.darkTheme
                    : Themes.lightTheme,
                home: const PlayerName(),
              );
            },
          );
        },
      ),
    );
  }
}
