import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:learning_ui/utils/extensions.dart';
import 'package:learning_ui/screens/about.dart';
import 'package:learning_ui/screens/leaderboard.dart';
import 'package:learning_ui/screens/rules.dart';
import 'package:learning_ui/screens/settings.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              curve: Curves.easeIn,
              duration: const Duration(seconds: 1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.surfaceTint,
                    Theme.of(context).colorScheme.onTertiary,
                  ],
                ),
              ),
              child: Image.asset(
                'assets/icon/tic-tac-toe.png',
                width: 150,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.rule),
              title: Text(
                'Rules',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Rules(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.leaderboard),
              title: Text(
                'Leaderboard',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaderBoard(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'Settings',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(
                'About',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const About(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
