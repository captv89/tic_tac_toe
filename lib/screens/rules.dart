// Leader Board Screen to show the players and their scores

import 'package:flutter/material.dart';
import 'package:learning_ui/utils/extensions.dart';
import 'package:learning_ui/utils/theme.dart';
import 'package:provider/provider.dart';

class Rules extends StatefulWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  RulesState createState() => RulesState();
}

class RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            'Rules',
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
        body: _buildRules(context),
      );
    });
  }

  Widget _buildRules(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              '1. The game is played on a grid that is 3 squares by 3 squares.',
              style: context.textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '2. If you are X, your friend is O. Players take turns putting their marks in empty squares.',
              style: context.textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '3. The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner.',
              style: context.textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '4. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.',
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
