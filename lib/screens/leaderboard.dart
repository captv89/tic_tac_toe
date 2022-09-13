// Leader Board Screen to show the players and their scores

import 'package:flutter/material.dart';
import 'package:learning_ui/utils/db.dart';
import 'package:learning_ui/utils/theme.dart';
import 'package:learning_ui/utils/extensions.dart';
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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            'Leader Board',
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
        body: _buildLeaderBoard(context),
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
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rank',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      'Name',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      'Score',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                          style: context.textTheme.titleMedium?.copyWith(
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
                          style: context.textTheme.titleMedium?.copyWith(
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
