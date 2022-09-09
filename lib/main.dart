import 'package:flutter/material.dart';
import 'home.dart';
import 'theme.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

void main() {
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
                home: const HomePage(),
              );
            },
          );
        },
      ),
    );
  }
}

// TODO: Landing Page to start the game after entering the name of the players
// TODO: Capture the name of Payer 1 and Player 2
// TODO: Display the name of the players on the game screen
// TODO: Save the score of the players in the database after a win
// TODO: Leader Board to display the name of the players and their scores
