// Leader Board Screen to show the players and their scores

import 'package:flutter/material.dart';
import 'package:learning_ui/screens/game.dart';
import 'package:learning_ui/utils/db.dart';
import 'package:learning_ui/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Leaders {
  final String name;
  final int score;

  Leaders({required this.name, required this.score});
}

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  LeaderBoardState createState() => LeaderBoardState();
}

class LeaderBoardState extends State<LeaderBoard> {
  final int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _getLeaders();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
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
        drawer: SizedBox(
          width: 60.w,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 55),
                  curve: Curves.easeIn,
                  duration: const Duration(seconds: 1),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.tertiaryContainer,
                      ],
                    ),
                  ),
                  child: Text(
                    'Tic Tac Toe',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.leaderboard),
                  title: Text(
                    'Leader Board',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(
                    'About',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
        ),
        body: _buildLeaderBoard(context),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).colorScheme.secondaryContainer,
            primaryColor: Theme.of(context).colorScheme.onSecondaryContainer,
            textTheme: Theme.of(context).textTheme.copyWith(
                  caption: const TextStyle(color: Colors.white),
                ),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard),
                label: 'Leaderboard',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            onTap: (index) {
              if (index == 0) {
                Scores().loadScores().then((value) {
                  xScore = value[0];
                  oScore = value[1];
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameScreen(),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaderBoard(),
                  ),
                );
              }
            },
          ),
        ),
      );
    });
  }

  Widget _buildLeaderBoard(BuildContext context) {
    return FutureBuilder<List<Leaders>>(
      future: _getLeaders(),
      builder: (BuildContext context, AsyncSnapshot<List<Leaders>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 10.h,
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rank',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                    ),
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                    ),
                    Text(
                      'Score',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    Leaders leader = snapshot.data![index];
                    return Card(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: ListTile(
                        leading: Text(
                          '${index + 1}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                        ),
                        title: Align(
                          alignment: Alignment.center,
                          child: Text(
                            leader.name.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                ),
                          ),
                        ),
                        trailing: Text(
                          leader.score.toString(),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

//  Get the leaders and score from database
//  and show them in a list view
  Future<List<Leaders>> _getLeaders() async {
    var leaders = await SqliteService().getLeaders();
    List<Leaders> leaderList = [];
    for (var leader in leaders) {
      leaderList.add(Leaders(name: leader['name'], score: leader['score']));
    }

    // Sort the list in descending order
    leaderList.sort((a, b) => b.score.compareTo(a.score));

    return leaderList;
  }
}
