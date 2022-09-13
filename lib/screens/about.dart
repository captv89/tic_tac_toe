// Leader Board Screen to show the players and their scores

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning_ui/utils/extensions.dart';
import 'package:learning_ui/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            'About',
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
        body: _buildAboutUs(context),
      );
    });
  }

  Widget _buildAboutUs(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              'This is a simple tic tac toe game made using Flutter.',
              style: context.textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text:
                    'As part of learning Dart & Flutter, this app is made by ',
                style: context.textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '@CaptV89',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchInBrowser(
                          Uri.parse('https://captv89.github.io/'),
                        );
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'You can find the source code on ',
                style: context.textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'GitHub',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchInBrowser(
                          Uri.parse('https://github.com/captv89/tic_tac_toe'),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
